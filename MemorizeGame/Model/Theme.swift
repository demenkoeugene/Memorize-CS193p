//
//  Theme.swift
//  MemorizeGame
//
//  Created by Eugene Demenko on 05.07.2023.
//


import Foundation
import SwiftUI

struct Theme: Codable, Identifiable {
    var id = UUID()
        let themeName: String
        let themeArray: [String]
        let numberCards: Int
        let colorCards: Color

        enum CodingKeys: String, CodingKey {
            case themeName, themeArray, numberCards, colorCards
        }

        init(themeName: String, themeArray: [String], numberCards: Int, colorCards: Color) {
            self.themeName = themeName
            self.themeArray = themeArray
            self.numberCards = numberCards
            self.colorCards = colorCards
        }

        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            themeName = try container.decode(String.self, forKey: .themeName)
            themeArray = try container.decode([String].self, forKey: .themeArray)
            numberCards = try container.decode(Int.self, forKey: .numberCards)

            if let colorHex = try container.decodeIfPresent(String.self, forKey: .colorCards) {
                colorCards = Color(hex: colorHex) ?? .gray
            } else {
                colorCards = .gray
            }
        }

        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(themeName, forKey: .themeName)
            try container.encode(themeArray, forKey: .themeArray)
            try container.encode(numberCards, forKey: .numberCards)
            
            if let colorHex = colorCards.toHex() {
                try container.encode(colorHex, forKey: .colorCards)
            }
        }
    
    var json: Data? {
         try? JSONEncoder().encode(self)
     }
    
    
    init?(json: Data?) {
            if let json = json, let newTheme = try? JSONDecoder().decode(Theme.self, from: json) {
                self = newTheme
            }
            else {
                return nil
            }
        }
  
  
   
    static var themes: [Theme] = [
        Theme(themeName: "Vehicles", themeArray: vehiclesArray, numberCards: generateRandomNumber(), colorCards: Color(hex: "#759DD1")!),
        Theme(themeName: "Animal", themeArray: animalArray, numberCards: generateRandomNumber(), colorCards: Color(hex: "#D5CD81")!),
        Theme(themeName: "Food", themeArray: foodArray, numberCards: generateRandomNumber(), colorCards: Color(hex: "#A4A3E0")!),
        Theme(themeName: "Active", themeArray: activeArray, numberCards: generateRandomNumber(), colorCards: Color(hex: "#D47D80")!),
        Theme(themeName: "Sports", themeArray: sportsArray, numberCards: generateRandomNumber(), colorCards: Color(hex: "#E0D6A3")!),
        Theme(themeName: "Face", themeArray: faceArray, numberCards: generateRandomNumber(), colorCards: Color(hex: "#A3D7E0")!)
    ]
    
    static func generateRandomNumber() -> Int {
        return Int.random(in: 4...12)
    }
    
    static let template = Theme(themeName: "Untitled",
                                themeArray: ["🤹‍♀️", "🎤", "🎲", "🏨"],
                                numberCards: 6,
                                colorCards: .gray)
}




extension Color {
    init?(hex: String) {
        let r, g, b: Double

        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])

            if hexColor.count == 6 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0

                if scanner.scanHexInt64(&hexNumber) {
                    r = Double((hexNumber & 0xff0000) >> 16) / 255
                    g = Double((hexNumber & 0x00ff00) >> 8) / 255
                    b = Double(hexNumber & 0x0000ff) / 255

                    self.init(red: r, green: g, blue: b)
                    return
                }
            }
        }

        return nil
    }
    
    func toHex() -> String? {
        if let components = UIColor(self).cgColor.components {
            let r = Float(components[0])
            let g = Float(components[1])
            let b = Float(components[2])
            return String(format: "#%02lX%02lX%02lX", lroundf(r * 255), lroundf(g * 255), lroundf(b * 255))
        }
        return nil
    }
}


let vehiclesArray = ["🚗","🚌","🚲","🚄","🚛", "🚜", "🏎", "🚓", "🚑", "🚒", "🚐", "✈️", "🛵","🚇","🚢", "🛥", "🛴", "🚕", "🚙", "🚝", "🚞", "🚤", "⛴", "🛩"]
let animalArray = ["🐶","🐱","🐭","🐹","🐰", "🦊", "🐻", "🐼", "🐻‍❄️", "🐨", "🐯", "🦁", "🐮","🐷","🐽", "🐸", "🐵", "🐔", "🐧", "🐦", "🐤", "🦆", "🦅", "🦉"]
let foodArray = ["🍏","🍎","🍐","🍊","🍋", "🍌", "🍉", "🍇", "🍓", "🫐", "🍈", "🍒", "🍑","🥭","🍍", "🥥", "🥝", "🍅", "🍆", "🥑", "🥦", "🥬", "🥒", "🌶"]
let activeArray = ["⚽️","🏀","🏈","⚾️","🥎", "🎾", "🏐", "🥏", "🏉", "🎱", "🪀", "🏓", "🏸","🏒","🏑", "🥍", "🏏", "🪃", "🥅", "🪁", "🛝", "🏹", "🎣", "🤿"]
let sportsArray = ["🪂","⛷","🏂", "🏋️‍♀️", "🤼‍♀️", "🤸‍♀️", "⛹️‍♀️", "🤺", "🤾‍♀️", "🏌️‍♀️", "🏇","🧘‍♀️","🏄‍♀️", "🏊", "🤽‍♀️", "🚣‍♀️", "🧗‍♀️", "🚵‍♀️", "🚴‍♀️"]
let faceArray = ["😀","😃","😄", "😁", "😆", "🥹", "😅", "😂", "🤣", "🥲", "☺️","😇","🙂", "🙃", "😉", "😌", "😍", "🥰", "😘"]


