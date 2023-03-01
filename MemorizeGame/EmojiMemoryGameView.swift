//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Eugene Demenko on 25.01.2023.
//
//Views
import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var game: EmojiMemoryGame
    @Namespace private var dealingNamespace
    
    
    var body: some View {
        
        VStack{
            HStack{
                titleViewer
                Spacer()
                scoreViewer
            }
                
                gameBody
                deckBody
                Spacer()
                HStack{
                    shuffle
                    Spacer()
                    NewGameButton
                    
                }
        }.foregroundColor(game.setColor()).padding(.horizontal)
    
    }
    
    var titleViewer: some View{
        Text(game.setTitle())
            .font(.largeTitle)
            .fontWeight(.bold)
            .padding(10)
    }
    
    var scoreViewer: some View{
        Text(game.setScore())
            .font(.largeTitle)
            .fontWeight(.bold)
            .padding(10)
    }
    
    @State private var dealt = Set<Int>()
    
    
    private func deal(_ card: EmojiMemoryGame.Card){
        dealt.insert(card.id)
    }
    
    private func isUndealt(_ card: EmojiMemoryGame.Card) -> Bool{
        !dealt.contains(card.id)
    }
    
    private func dealAnimation(for card: EmojiMemoryGame.Card) -> Animation {
           var delay = 0.0
           if let index = game.cards.firstIndex(where: { $0.id == card.id }) {
               delay = Double(index) * ( CardConstants.totalDealDuration / Double(game.cards.count))
           }
           return Animation.easeInOut(duration: CardConstants.dealDuration).delay(delay)
    }
    private func zIndex(of card: EmojiMemoryGame.Card) -> Double{
        -Double(game.cards.firstIndex(where: {$0.id == card.id}) ?? 0)
    }
    
    var gameBody: some View {
        AspectVGrid (items:game.cards,aspectRatio: 2/3){ card in
            if isUndealt(card)||(card.isMatched && !card.isFaceUp){
                Color.clear
            } else {
                CardView(card)
                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                    .padding(4)
                    .transition(AnyTransition.asymmetric(insertion: .identity, removal: .scale))
                    .zIndex(zIndex(of: card))
                    .onTapGesture {
                        withAnimation  {
                            game.choose(card)
                        }
                    }
            }
        }.padding(10)
    }
    
    var deckBody: some View {
          ZStack {
              ForEach(game.cards.filter(isUndealt)) { card in
                  CardView(card)
                      .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                  .transition(AnyTransition
                              .asymmetric(insertion: .opacity, removal: .identity))
              }
          }
          .frame(width: CardConstants.undealtWidth, height: CardConstants.undealtHeight)
          .foregroundColor(game.setColor())
          .onTapGesture {
              // "deal" cards
              for card in game.cards {
              withAnimation(dealAnimation(for: card)) {
                      deal(card)
                  }
              }
          }
      }
    
    var shuffle: some View{
        Button("Shuffle"){
            withAnimation(.easeInOut(duration: 0.5)){
                game.shuffle()
            }
            
        }.font(.title2.bold()).foregroundColor(game.setColor())
            .padding(.horizontal, 50.0).padding(.vertical, 20.0)
            .background(Color.white)
            .cornerRadius(20)
            .shadow(radius: 30)
    }
    
  
    var NewGameButton: some View {
        Button {
            dealt = []
            game.newGame()
        } label: {
            VStack() {
                Text("New")
                    .font(.title2.bold()).foregroundColor(game.setColor())
                        .padding(.horizontal, 60.0).padding(.vertical, 20.0)
                        .background(Color.white)
                        .cornerRadius(20)
                        .shadow(radius: 30)
            }
        }
    }
 
  
    
    private struct CardConstants {
          static let aspectRatio: CGFloat = 2/3
          static let dealDuration: Double = 0.5
          static let totalDealDuration: Double = 2
          static let undealtHeight: CGFloat = 90
          static let undealtWidth = undealtHeight * aspectRatio
      }
    
    
}


  

struct CardView: View{
    private let card: EmojiMemoryGame.Card
    
    @State private var animatedBonusRemaining = 0.0
    
    init(_ card: EmojiMemoryGame.Card){
        self.card = card
    }
   
   
    @ViewBuilder
    var body: some View {
        
        GeometryReader { geometry in
            ZStack{
                Group {
                        if card.isConsumingBonusTime {
                            Pie(startAngle: .degrees(90), endAngle: .degrees(-animatedBonusRemaining*360-90), clockwise: true)
                                              .onAppear {
                                                  animatedBonusRemaining = card.bonusRemaining
                                                  withAnimation(.linear(duration: card.bonusTimeRemaining)) {
                                                      animatedBonusRemaining = 0
                                                  }
                                              }
                                      } else {
                                          Pie(startAngle: .degrees(0), endAngle: .degrees(-card.bonusRemaining*360-90), clockwise: true)
                                          
                                      }
                               }
                               .padding(5)
                               .opacity(0.6)
                               .transition(.identity)
                
                Text(card.content)
                    .rotationEffect(Angle.degrees(card.isMatched ? 360 : 0))
                    .animation(Animation.linear(duration: 1)
                    .repeatForever(autoreverses: false), value: true)
                    .font(Font.system(size: DrawingConstants.fontSize))
                    .scaleEffect(scale (thatFits: geometry.size))
            }.cardify(isFaceUp: card.isFaceUp)
            
        }
    }
    private func scale(thatFits size: CGSize)->CGFloat{
        min(size.width, size.height)/(DrawingConstants.fontSize / DrawingConstants.fontScale)
    }
    private func font(in size: CGSize) -> Font{
        Font.system(size: min(size.width, size.height)*DrawingConstants.fontScale)
    }
    private struct DrawingConstants{
        static let fontScale: CGFloat = 0.5
            static let fontSize: CGFloat = 32
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        game.choose(game.cards.first!)
        return EmojiMemoryGameView(game: game)
    }
}
