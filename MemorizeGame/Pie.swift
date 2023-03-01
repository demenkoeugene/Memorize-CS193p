//
//  Pie.swift
//  MemorizeGame
//
//  Created by Eugene Demenko on 23.02.2023.
//

import SwiftUI

struct Pie: Shape {
    var startAngle: Angle
    var endAngle: Angle
    var clockwise = false
    
    var animatableData: AnimatablePair<Double,Double> {
        get { AnimatablePair(startAngle.radians, endAngle.radians) }
        set {
            startAngle = Angle.radians(newValue.first)
            endAngle = Angle.radians(newValue.second)
        }
    }
    
    func path(in rect: CGRect) -> Path {
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius = min (rect.width,rect.height) / 2
        let start = CGPoint(
            x: center.x + radius * CGFloat(cos(startAngle.radians)),
            y: center.y + radius * CGFloat(sin(startAngle.radians))
        )
        var p = Path()
        p.move(to: center)
        p.addLine(to: start)
        p.addArc(center: center,
                 radius: radius,
                 startAngle: startAngle,
                 endAngle: endAngle,
                 clockwise: !clockwise)
        p.addLine (to:center)
        return p
    }
}
//
//struct Diamond: Shape {
//    
//    func path(in rect: CGRect) -> Path {
//        var path = Path()
//        let width = min(rect.size.width, rect.size.height)
//        let height = width
//        let midX = rect.midX
//        let midY = rect.midY
//        let x = midX - (width / 2)
//        let y = midY - (height / 2)
//
//        path.move(to: CGPoint(x: midX, y: y))
//        path.addLine(to: CGPoint(x: x, y: midY))
//        path.addLine(to: CGPoint(x: midX, y: y + height))
//        path.addLine(to: CGPoint(x: x + width, y: midY))
//        path.addLine(to: CGPoint(x: midX, y: y))
//        path.closeSubpath()
//
//        return path
//    }
//}



