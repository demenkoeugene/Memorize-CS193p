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

                        NavigationLink(destination: EmojiMemoryGameView(viewModel: EmojiMemoryGame(theme: theme))) {
                            Color.clear
                        }
                        .opacity(0.0)
                        .buttonStyle(PlainButtonStyle())
                    }
                    .listRowBackground(theme.colorCards)
                }
                
                .onDelete { indexSet in
                    self.store.themes.remove(atOffsets: indexSet)
                }
                .listRowInsets(EdgeInsets())
                
            }
            .sheet(item: self.$editingTheme, content: { theme in
                EmptyView()
                MemoryEdit(theme: theme)
                    .environmentObject(self.store)
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
                    .font(.headline)
                    .padding(.bottom, 10)
                HStack(spacing: 70) {
                    Text("\(Image(systemName: "rectangle.on.rectangle")) \(theme.numberCards)")
                        .truncationMode(.tail)
                    Text("Emoji: \(theme.themeArray.joined())")
                        .lineLimit(1)

                }
            }
            Spacer()

            if self.isEditing {
                Button(action: editTheme) {
                    Image(systemName: "pencil")
                        .imageScale(.large)
                }
                .buttonStyle(PlainButtonStyle())
            }
        }
        .padding(20)
        
    }
}

struct ThemeChooser_Previews: PreviewProvider {
    static var previews: some View {
        ThemeChooser()
    }
}
