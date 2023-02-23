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
    var score: Int = 0 //our score
    
    private var indexOfTheOneAndOnlyFaceUpCard: Int?{
        get{ cards.indices.filter({ cards[$0].isFaceUp }).oneAndOnly }
        set{ cards.indices.forEach { cards[$0].isFaceUp = ($0 == newValue)}} }
    
    mutating func choose(_ card: Card){
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }),!cards[chosenIndex].isFaceUp,!cards[chosenIndex].isMatched{
            if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard{
                if cards[chosenIndex].content == cards[potentialMatchIndex].content{
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                    score+=2 //+2 points to the score
                }else {
                    if cards[potentialMatchIndex].seenBefore || cards[chosenIndex].seenBefore {
                        score -= 1
                    }
                    cards[potentialMatchIndex].seenBefore = true
                    cards[chosenIndex].seenBefore = true
                }
                cards[chosenIndex].isFaceUp = true
            }else{
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
            }
        }
        
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
        cards = []
        //add numberOfPaitsOfCards x 2 cards to cards array
        
        for pairIndex in 0..<numberOfPairsOfCards{
            let content = createCardContent(pairIndex)
            cards.append(Card(content: content, id: pairIndex*2))
            cards.append(Card(content: content, id: pairIndex*2+1))
            
        }
        
    }
    
    struct Card: Identifiable{
        var isFaceUp = false
        var isMatched = false
        var content: CardContent
        var id: Int
        var seenBefore = false
        
    }
    
   
}
    
//Struct for Theme 
struct Theme<ColorType> {
    var themeName: String
    var themeArray: [String]
    var numberCards: Int
    var colorCards: ColorType
}

extension Array{
    var oneAndOnly: Element?{
        if count == 1 {
            return first
        }else{
            return nil
        }
    }
}
