//
//  Cardify.swift
//  MemorizeGame
//
//  Created by Eugene Demenko on 28.02.2023.
//

import SwiftUI

struct Cardify: AnimatableModifier {
    init(isFaceUp: Bool){
        rotation = isFaceUp ? 0 : 180
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
//                let borderColor: Color = viewmodel.setBorderColor()
                shape.stroke(lineWidth: DrawingConstants.lineWidth)
                Pie(startAngle: Angle(degrees: 0-90), endAngle: Angle(degrees: 270-90)).padding(5).opacity(0.5)
                
            }else{
                shape.fill()
            }
           
                content.opacity(rotation < 90  ? 1 : 0)
           
        }
        .rotation3DEffect(Angle.degrees(rotation), axis: (0, 1, 0))
    }
    private struct DrawingConstants{
        static let cornerRadius: CGFloat = 20
        static let lineWidth: CGFloat = 3
    }
}

extension View{
    func cardify(isFaceUp: Bool)-> some View{
        self.modifier(Cardify(isFaceUp: isFaceUp))
    }
}
