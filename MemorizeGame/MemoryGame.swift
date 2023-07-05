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
    var isMatchedCard = false
    
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
                    isMatchedCard = true
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
                isMatchedCard = false
            }
        }
        
    }
    
    func index(of card: Card)-> Int?{
        for index in 0..<8{
            if cards[index].id == card.id{
                return index
            }
        }
        return nil
    }
    
    mutating func shuffle(){
        cards.shuffle()
    }
    
    init(numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent){
        cards = []
        //add numberOfPaitsOfCards x 2 cards to cards array
        
        for pairIndex in 0..<numberOfPairsOfCards{
            let content = createCardContent(pairIndex)
            cards.append(Card(content: content, id: pairIndex*2))
            cards.append(Card(content: content, id: pairIndex*2+1))
        }
        cards.shuffle()
    }
    
    
    struct Card: Identifiable{
        var isFaceUp = false{
            didSet{
                if isFaceUp{
                    startUsingBonusTime()
                }else{
                    stopUsingBonusTime()
                }
                
            }
        }
        var isMatched = false{
            didSet{
                stopUsingBonusTime()
            }
           
        }
       
        var seenBefore = false
        let content: CardContent
                let id: Int
                
                // MARK: - Bonus Time
                
                // this could give matching bonus points
                // if the user matches the card
                // before a certain amount of time passes during which the card is face up
                
                // can be zero which means "no bonus available" for this card
                var bonusTimeLimit: TimeInterval = 10
                
                // how long this card has ever been face up
                private var faceUpTime: TimeInterval {
                    if let lastFaceUpDate = self.lastFaceUpDate {
                        return pastFaceUpTime + Date().timeIntervalSince(lastFaceUpDate)
                    } else {
                        return pastFaceUpTime
                    }
                }
                // the last time this card was turned face up (and is still face up)
                var lastFaceUpDate: Date?
                // the accumulated time this card has been face up in the past
                // (i.e. not including the current time it's been face up if it is currently so)
                var pastFaceUpTime: TimeInterval = 0
                
                // how much time left before the bonus opportunity runs out
                var bonusTimeRemaining: TimeInterval {
                    max(0, bonusTimeLimit - faceUpTime)
                }
                // percentage of the bonus time remaining
                var bonusRemaining: Double {
                    (bonusTimeLimit > 0 && bonusTimeRemaining > 0) ? bonusTimeRemaining/bonusTimeLimit : 0
                }
                // whether the card was matched during the bonus time period
                var hasEarnedBonus: Bool {
                    isMatched && bonusTimeRemaining > 0
                }
                // whether we are currently face up, unmatched and have not yet used up the bonus window
                var isConsumingBonusTime: Bool {
                    isFaceUp && !isMatched && bonusTimeRemaining > 0
                }
                
                // called when the card transitions to face up state
                private mutating func startUsingBonusTime() {
                    if isConsumingBonusTime, lastFaceUpDate == nil {
                        lastFaceUpDate = Date()
                    }
                }
                // called when the card goes back face down (or gets matched)
                private mutating func stopUsingBonusTime() {
                    pastFaceUpTime = faceUpTime
                    self.lastFaceUpDate = nil
                }
            }
    
       
    }

   

    
//Struct for Theme 


extension Array{
    var oneAndOnly: Element?{
        if count == 1 {
            return first
        }else{
            return nil
        }
    }
}
