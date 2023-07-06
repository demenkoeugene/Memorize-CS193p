//
//  Cardify.swift
//  MemorizeGame
//
//  Created by Eugene Demenko on 28.02.2023.
//

import SwiftUI

struct Cardify: AnimatableModifier {
    let bordColor: Color
    
    init(isFaceUp: Bool, bordColor: Color){
        rotation = isFaceUp ? 0 : 180
        self.bordColor = bordColor
    }
    
    var rotation: Double
    var animatableData: Double{
        get{rotation}
        set{rotation = newValue}
    }
    
    func body(content: Content) ->  some View {
        ZStack{
            let shape = RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
            if rotation < 90 {
                shape.fill().foregroundColor(.white)
                shape.stroke(bordColor, lineWidth: DrawingConstants.lineWidth)
            }else{
                shape.fill()
            }
                content.opacity(rotation < 90  ? 1 : 0)
           
        }
        .rotation3DEffect(Angle.degrees(rotation), axis: (0, 1, 0))
    }
    private struct DrawingConstants{
        static let cornerRadius: CGFloat = 20
        static let lineWidth: CGFloat = 5
    }
}

extension View{
    func cardify(isFaceUp: Bool, bordColor: Color)-> some View{
        self.modifier(Cardify(isFaceUp: isFaceUp, bordColor: bordColor))
    }
}
