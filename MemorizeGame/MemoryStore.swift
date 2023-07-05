//
//  MemoryStore.swift
//  MemorizeGame
//
//  Created by Eugene Demenko on 05.07.2023.
//

import Combine
import Foundation
import SwiftUI

class MemoryStore: ObservableObject {

    private var autosave: AnyCancellable?
    @Published var themes: [Theme]

    init() {
        let defaultsKey = "EmojiMemoryThemeStore"
        themes = (UserDefaults.standard.object(forKey: defaultsKey) as? [Data])?
            .compactMap({ Theme(json: $0) }) ?? Theme.themes
        autosave = $themes.sink { themes in
            UserDefaults.standard.set(themes.map{$0.json}, forKey: defaultsKey)
        }
    }

    // MARK: - Intents
    func updateTheme(for theme: Theme, name: String, emoji: [String], color: Color, numberOfPairs: Int) {
        let newTheme = Theme(themeName: name, themeArray: emoji, numberCards: numberOfPairs, colorCards: color)
        if let index = themes.firstIndex(where: { $0.id == theme.id }) {
            themes[index] = newTheme
        }
    }

}
