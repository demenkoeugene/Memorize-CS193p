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
    
    
    var body: some View {
        
        VStack{
            HStack{
                Text(game.setTitle())
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(10)
                Spacer()
                Text(game.setScore())
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(10)
            }
                
                AspectVGrid(items: game.cards, aspectRatio: 2/3)  {card in
                    cardView(for: card)
                }.padding(10)
                
                Spacer()
                HStack{
                    Spacer()
                    NewGameButton(viewModel: game)
                    Spacer()
                }
        }.foregroundColor(game.setColor()).padding(.horizontal)
    
    }
    @ViewBuilder
    private func cardView(for card: EmojiMemoryGame.Card) -> some View{
        if card.isMatched && !card.isFaceUp{
            Rectangle().opacity(0)
        }else{
            CardView(card,game).padding(4).aspectRatio(2/3, contentMode: .fit).onTapGesture {
                game.choose(card)
               
            }
        }
    }
}

struct NewGameButton: View {
      @ObservedObject var viewModel: EmojiMemoryGame
      
      var body: some View {
          Button {
              viewModel.newGame()
          } label: {
              VStack() {
                  Text("New Game")
                      .font(.title2.bold()).foregroundColor(viewModel.setColor())
                      .padding(.horizontal, 50.0).padding(.vertical, 20.0)
                      .background(Color.white)
                      .cornerRadius(20)
                      .shadow(radius: 10)
              }
          }
      }
  }
  

struct CardView: View{
    private let card: EmojiMemoryGame.Card
    var viewmodel: EmojiMemoryGame

    
    init(_ card: EmojiMemoryGame.Card,_ viewmodel: EmojiMemoryGame){
        self.card = card
        self.viewmodel = viewmodel
    }
    
   
    
    var body: some View {
        GeometryReader {geometry in
            ZStack{
                let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
                if card.isFaceUp{
                    shape.fill().foregroundColor(.white)
                    let borderColor: Color = viewmodel.setBorderColor()
                    shape.stroke(borderColor, lineWidth: DrawingConstants.lineWidth)
                    Pie(startAngle: Angle(degrees: 0-90), endAngle: Angle(degrees: 270-90)).padding(5).opacity(0.5)
//                    Diamond().padding(5).opacity(0.5)
                        
                    Text(card.content).font(font(in: geometry.size)).padding()
                }else if card.isMatched{
                    shape.opacity(0)
                }
                else{
                    shape.fill()
                }
            }
        }
    }
    private func font(in size: CGSize) -> Font{
        Font.system(size: min(size.width, size.height)*DrawingConstants.fontScale)
    }
    private struct DrawingConstants{
        static let cornerRadius: CGFloat = 20
        static let lineWidth: CGFloat = 3
        static let fontScale: CGFloat = 0.5
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        game.choose(game.cards.first!)
        return EmojiMemoryGameView(game: game)
    }
}
