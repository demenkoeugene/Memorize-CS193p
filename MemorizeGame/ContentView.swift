//
//  ContentView.swift
//  Memorize
//
//  Created by Eugene Demenko on 25.01.2023.
//
//Views
import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: EmojiMemoryGame

    
    var body: some View {
       
        VStack{
            HStack{
                Text(viewModel.setTitle())
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(10)
                Spacer()
                Text(viewModel.setScore())
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(10)
            }
            ScrollView{
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 70))]){
                    ForEach(viewModel.cards) { card in
                        CardView(card: card).aspectRatio(2/3, contentMode: .fit).onTapGesture {
                            viewModel.choose(card)
                        }
                    }
                }.padding(10)
            }
            Spacer()
            HStack{
                            Spacer()
                            NewGameButton(viewModel: viewModel)
                            Spacer()
            }
        }.foregroundColor(viewModel.setColor()).padding(.horizontal)
    }
   
}

struct NewGameButton: View {
      @ObservedObject var viewModel: EmojiMemoryGame
      
      var body: some View {
          Button {
              viewModel.newGame()
          } label: {
              VStack {
                  Text("New Game")
                      .font(.title2.bold())
              }
          }
      }
  }
  

struct CardView: View{
    let card: MemoryGame<String>.Card
    
    
    var body: some View {
        ZStack{
            let shape = RoundedRectangle(cornerRadius: 25)
            if card.isFaceUp{
                shape.fill().foregroundColor(.white)
                shape.stroke(lineWidth: 3)
                Text(card.content).font(.largeTitle).padding()
            }else if card.isMatched{
                shape.opacity(0)
            }
            else{
                shape.fill()
            }
        }
        
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        ContentView(viewModel: game)
    }
}
