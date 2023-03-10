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
    
    
    //Themes
    private static let vihiclesArray = ["ð","ð","ðē","ð","ð", "ð", "ð", "ð", "ð", "ð", "ð", "âïļ", "ðĩ","ð","ðĒ", "ðĨ", "ðī", "ð", "ð", "ð", "ð", "ðĪ", "âī", "ðĐ"]
    private static let animalArray = ["ðķ","ðą","ð­","ðđ","ð°", "ðĶ", "ðŧ", "ðž", "ðŧââïļ", "ðĻ", "ðŊ", "ðĶ", "ðŪ","ð·","ð―", "ðļ", "ðĩ", "ð", "ð§", "ðĶ", "ðĪ", "ðĶ", "ðĶ", "ðĶ"]
    private static let foodArray = ["ð","ð","ð","ð","ð", "ð", "ð", "ð", "ð", "ðŦ", "ð", "ð", "ð","ðĨ­","ð", "ðĨĨ", "ðĨ", "ð", "ð", "ðĨ", "ðĨĶ", "ðĨŽ", "ðĨ", "ðķ"]
    private static let activeArray = ["â―ïļ","ð","ð","âūïļ","ðĨ", "ðū", "ð", "ðĨ", "ð", "ðą", "ðŠ", "ð", "ðļ","ð","ð", "ðĨ", "ð", "ðŠ", "ðĨ", "ðŠ", "ð", "ðđ", "ðĢ", "ðĪŋ"]
    private static let sportsArray = ["ðŠ","â·","ð", "ðïļââïļ", "ðĪžââïļ", "ðĪļââïļ", "âđïļââïļ", "ðĪš", "ðĪūââïļ", "ðïļââïļ", "ð","ð§ââïļ","ðââïļ", "ð", "ðĪ―ââïļ", "ðĢââïļ", "ð§ââïļ", "ðĩââïļ", "ðīââïļ"]
    private static let faceArray = ["ð","ð","ð", "ð", "ð", "ðĨđ", "ð", "ð", "ðĪĢ", "ðĨē", "âšïļ","ð","ð", "ð", "ð", "ð", "ð", "ðĨ°", "ð"]
    
    private static let themes = [
        Theme(themeName: "Vehicles", themeArray: vihiclesArray, numberCards: generateRandomNumber(), colorCards: Color.blue),
        Theme(themeName: "Animal", themeArray: animalArray, numberCards: generateRandomNumber(), colorCards: Color.orange),
        Theme(themeName: "Food", themeArray: foodArray, numberCards: generateRandomNumber(), colorCards: Color.indigo),
        Theme(themeName: "Active", themeArray: activeArray, numberCards: generateRandomNumber(), colorCards: Color.pink),
        Theme(themeName: "Sports", themeArray: sportsArray, numberCards: generateRandomNumber(), colorCards: Color.purple),
        Theme(themeName: "Face", themeArray: faceArray, numberCards: generateRandomNumber(), colorCards: Color.teal)
    ]
    
    static var randomCase = themes.randomElement()!
    
    static func createMemoryGame() -> MemoryGame<String>{
        randomCase = themes.randomElement()!
        let shuffledArray = randomCase.themeArray.shuffled()
        return MemoryGame<String>(numberOfPairsOfCards: randomCase.numberCards) { pairIndex in
                shuffledArray[pairIndex]
        }
        }
    
    
    @Published private(set) var model = createMemoryGame()
    
    func setScore() -> String {
        return String(model.score)
    }

  
   
    func setBorderColor() -> Color{
        return model.isMatchedCard ? Color.green : setColor()
    }
    
    func newGame() {
        model = EmojiMemoryGame.createMemoryGame()
//        objectWillChange.send()
    }

    func setTitle() -> String{
        EmojiMemoryGame.randomCase.themeName
    }
    
    func setColor() -> Color{
        EmojiMemoryGame.randomCase.colorCards
    }
    //function for array
    static func generateRandomNumber() -> Int {
        return Int.random(in: 4...12)
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
