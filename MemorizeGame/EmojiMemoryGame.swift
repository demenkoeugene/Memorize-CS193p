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
    private static let vihiclesArray = ["🚗","🚌","🚲","🚄","🚛", "🚜", "🏎", "🚓", "🚑", "🚒", "🚐", "✈️", "🛵","🚇","🚢", "🛥", "🛴", "🚕", "🚙", "🚝", "🚞", "🚤", "⛴", "🛩"]
    private static let animalArray = ["🐶","🐱","🐭","🐹","🐰", "🦊", "🐻", "🐼", "🐻‍❄️", "🐨", "🐯", "🦁", "🐮","🐷","🐽", "🐸", "🐵", "🐔", "🐧", "🐦", "🐤", "🦆", "🦅", "🦉"]
    private static let foodArray = ["🍏","🍎","🍐","🍊","🍋", "🍌", "🍉", "🍇", "🍓", "🫐", "🍈", "🍒", "🍑","🥭","🍍", "🥥", "🥝", "🍅", "🍆", "🥑", "🥦", "🥬", "🥒", "🌶"]
    private static let activeArray = ["⚽️","🏀","🏈","⚾️","🥎", "🎾", "🏐", "🥏", "🏉", "🎱", "🪀", "🏓", "🏸","🏒","🏑", "🥍", "🏏", "🪃", "🥅", "🪁", "🛝", "🏹", "🎣", "🤿"]
    private static let sportsArray = ["🪂","⛷","🏂", "🏋️‍♀️", "🤼‍♀️", "🤸‍♀️", "⛹️‍♀️", "🤺", "🤾‍♀️", "🏌️‍♀️", "🏇","🧘‍♀️","🏄‍♀️", "🏊", "🤽‍♀️", "🚣‍♀️", "🧗‍♀️", "🚵‍♀️", "🚴‍♀️"]
    private static let faceArray = ["😀","😃","😄", "😁", "😆", "🥹", "😅", "😂", "🤣", "🥲", "☺️","😇","🙂", "🙃", "😉", "😌", "😍", "🥰", "😘"]
    
    private static let themes = [
        Theme(themeName: "Vehicles", themeArray: vihiclesArray, numberCards: generateRandomNumber(), colorCards: Color.blue),
        Theme(themeName: "Animal", themeArray: animalArray, numberCards: generateRandomNumber(), colorCards: Color.orange),
        Theme(themeName: "Food", themeArray: foodArray, numberCards: generateRandomNumber(), colorCards: Color.red),
        Theme(themeName: "Active", themeArray: activeArray, numberCards: generateRandomNumber(), colorCards: Color.pink),
        Theme(themeName: "Sports", themeArray: sportsArray, numberCards: generateRandomNumber(), colorCards: Color.purple),
        Theme(themeName: "Face", themeArray: faceArray, numberCards: generateRandomNumber(), colorCards: Color.green)
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
    
    //function for View
    func newGame() {
        model = EmojiMemoryGame.createMemoryGame()
        objectWillChange.send()
    }

    func setTitle() -> String{
        EmojiMemoryGame.randomCase.themeName
    }
    
    func setColor() -> Color{
        EmojiMemoryGame.randomCase.colorCards
    }
    //function for array
    static func generateRandomNumber() -> Int {
        return Int.random(in: 4...20)
    }
    
    
    var cards: Array<Card>{
        model.cards
    }
    //MARK: -Intent(s)
    
   
    
    func choose(_ card: Card){
        model.choose(card)
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
