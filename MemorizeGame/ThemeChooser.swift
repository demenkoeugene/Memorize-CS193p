//
//  ThemeChooser.swift
//  MemorizeGame
//
//  Created by Eugene Demenko on 05.07.2023.
//

import SwiftUI

struct ThemeChooser: View {
    @EnvironmentObject var store: MemoryStore
    @State private var editMode: EditMode = .inactive
    @State private var showThemeEditor = false
    @State private var editingTheme: Theme?

    var body: some View {
        NavigationView {
            List {
                ForEach(store.themes) { theme in
                    ZStack {
                        EmojiThemeRow(theme: theme, isEditing: self.editMode == .active) {
                            self.editingTheme = theme
                        }

                        // An empty NavigationLink so that the "navigation chevron" can be hidden, but still the same "row content" is shown
                        NavigationLink(destination: EmojiMemoryGameView(viewModel: EmojiMemoryGame(theme: theme))) {
                            Color.clear
                        }
                        .opacity(self.editMode.isEditing ? 0 : 1)
                    }
                }
                .onDelete { indexSet in
                    self.store.themes.remove(atOffsets: indexSet)
                }
            }
            .sheet(item: self.$editingTheme, content: { theme in
                EmptyView()
//                EmojiMemoryThemeEditor(theme: theme)
//                    .environmentObject(self.store)
            })
            .navigationBarTitle("Memorize")
            .navigationBarItems(
                leading: Button(action: { self.store.themes.append(Theme.template) },
                                label: { Image(systemName: "plus").imageScale(.large) })
                    .opacity(editMode == .inactive ? 1 : 0),
                trailing: EditButton())
            .environment(\.editMode, $editMode)
        }
    }
}


struct EmojiThemeRow: View {
    let theme: Theme
    let isEditing: Bool
    let editTheme: ()->Void

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(theme.themeName)
                    .font(.title)
                    

                HStack {
                    Text("\(theme.numberCards == theme.themeArray.count ? "All" : "\(theme.numberCards)") of \(theme.themeArray.joined())")
                        .truncationMode(.tail)
                        .lineLimit(1)
                }
            }
            Spacer()

            if self.isEditing {
                Button(action: editTheme) {
                    Image(systemName: "pencil.circle.fill")
                        .imageScale(.large)
                }
                .buttonStyle(PlainButtonStyle())
            }
        }
    }
}

struct ThemeChooser_Previews: PreviewProvider {
    static var previews: some View {
        ThemeChooser()
    }
}
