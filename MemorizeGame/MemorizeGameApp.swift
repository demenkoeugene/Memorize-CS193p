//
//  Memorize_CS193P_App.swift
//  Memorize(CS193P)
//
//  Created by Eugene Demenko on 25.01.2023.
//

import SwiftUI

@main
struct Memorize_CS193P_App: App {
    let game = EmojiMemoryGame()
    
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: game)
        }
    }
}
