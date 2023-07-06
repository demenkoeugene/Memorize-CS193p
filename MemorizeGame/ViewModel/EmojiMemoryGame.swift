//
//  EmojiMemoryGame.swift
//  Memorize(CS193P)
//
//  Created by Eugene Demenko on 30.01.2023.
//

import SwiftUI

//ViewModel

class EmojiMemoryGame: ObservableObject{
    typealias Card = MemoryGame<String>.Card
        
        @Published private var model: MemoryGame<String>
        var theme: Theme {
            didSet {
                newGame()
            }
        }
        
        init(theme: Theme? = nil) {
            self.theme = theme ?? Theme.themes.randomElement()!
            let emoji = self.theme.themeArray.shuffled()
            model = MemoryGame(numberOfPairsOfCards: self.theme.numberCards) {
                emoji[$0]
            }
       }

    
   
    
    static func createMemoryGame(theme: Theme) -> MemoryGame<String> {
        let shuffledArray = theme.themeArray.shuffled()
        return MemoryGame<String>(numberOfPairsOfCards: theme.numberCards) { pairIndex in
            shuffledArray[pairIndex]
        }
    }

    
    
   
    
    func setScore() -> String {
        return String(model.score)
    }

  
   

    
    func newGame() {
        model = EmojiMemoryGame.createMemoryGame(theme: theme)
    }

    func setColor() -> Color{
            theme.colorCards
    }
    
    func setBorderColor() -> Color{
           return model.isMatchedCard ? Color.green : setColor()
    }
    
    
    var cards: Array<Card>{
        model.cards
    }
    //MARK: -Intent(s)
    
   
    
    func choose(_ card: Card){
        model.choose(card)
    }

    func shuffle(){
        model.shuffle()
    }
    

}






















///Stock my code
//    func arrayShuffled(_ inputArray: inout [String]) -> [String] {
//        inputArray.shuffle()
//        return inputArray
//    }

//    static var randomCase = { () -> Theme in
//        return EmojiMemoryGame.themes.randomElement()!
//    }

//
//var randomCase = Theme.ThemeCollect.allCases.randomElement()!
//enum ThemeCollect: CaseIterable  {
//  case vihicles, animal, food, active, sports, emoji
//}

//var theme: Theme{
//    switch randomCase{
//        case .vihicles:
//            return Theme(themeName: "Vehicles", themeArray: EmojiMemoryGame.vihiclesArray, numberCards: randomNumber, colorCards: "blue")
//        case .animal:
//            return Theme(themeName: "Animal", themeArray: EmojiMemoryGame.animalArray, numberCards: randomNumber, colorCards: "orange")
//        case .food:
//            return Theme(themeName: "Food", themeArray: EmojiMemoryGame.foodArray, numberCards: randomNumber, colorCards: "red")
//        case .active:
//            return Theme(themeName: "Active", themeArray: EmojiMemoryGame.activeArray, numberCards: randomNumber, colorCards: "pink")
//        case .sports:
//            return Theme(themeName: "Sports", themeArray: EmojiMemoryGame.sportsArray, numberCards: randomNumber, colorCards: "fucsia")
//        case .emoji:
//            return Theme(themeName: "Emoji", themeArray: EmojiMemoryGame.emojiArray, numberCards: randomNumber, colorCards: "black")
//    }
//}
