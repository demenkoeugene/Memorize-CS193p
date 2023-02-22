//
//  MemoryGame.swift
//  Memorize(CS193P)
//
//  Created by Eugene Demenko on 30.01.2023.
//

import Foundation
//Model

struct MemoryGame<CardContent> where CardContent: Equatable{
    private(set) var cards: Array<Card>
    var score: Int = 0
    
    private var indexOfTheOneAndOnlyFaceUpCard: Int?
    
    mutating func choose(_ card: Card){
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }),!cards[chosenIndex].isFaceUp,!cards[chosenIndex].isMatched{
            if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard{
                if cards[chosenIndex].content == cards[potentialMatchIndex].content{
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                    score+=2
                }else {
                    if cards[potentialMatchIndex].seenBefore || cards[chosenIndex].seenBefore {
                        score -= 1
                    }
                    cards[potentialMatchIndex].seenBefore = true
                    cards[chosenIndex].seenBefore = true
                }
                indexOfTheOneAndOnlyFaceUpCard = nil
            }else{
                for index in 0..<cards.count{
                    cards[index].isFaceUp = false
                }
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
            }
            cards[chosenIndex].isFaceUp.toggle()
        }
        print("\(cards)")
    }
    
    func index(of card: Card)-> Int?{
        for index in 0..<cards.count{
            if cards[index].id == card.id{
                return index
            }
        }
        return nil
    }
    
    init(numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent){
        cards = Array<Card>()
        //add numberOfPaitsOfCards x 2 cards to cards array
        
        for pairIndex in 0..<numberOfPairsOfCards{
            let content = createCardContent(pairIndex)
            cards.append(Card(content: content, id: pairIndex*2))
            cards.append(Card(content: content, id: pairIndex*2+1))
            
        }
        
    }
    
    struct Card: Identifiable{
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var content: CardContent
        var id: Int
        var seenBefore: Bool = false
        
    }
    
   
}


struct Theme<ColorType> {
    var themeName: String
    var themeArray: [String]
    var numberCards: Int
    var colorCards: ColorType
}
