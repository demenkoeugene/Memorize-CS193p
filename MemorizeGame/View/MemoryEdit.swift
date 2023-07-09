//
//  MemoryEdit.swift
//  MemorizeGame
//
//  Created by Eugene Demenko on 09.07.2023.
//

import SwiftUI

struct MemoryEdit: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var store: MemoryStore

    let theme: Theme

    @State private var name: String = ""
    @State private var emojis: [String] = ["🦁"]
    @State private var numberOfPairs: Int = 4
    @State private var color: Color = .brown
    @State private var addEmoji: String = ""

    var body: some View {
        NavigationView {
            Form {
                nameSection
                addEmojiSection
                emojisSection
                cardCountSection
                colorSection
            }
            .onAppear() {
                self.name = self.theme.themeName
                self.emojis = self.theme.themeArray
                self.numberOfPairs = self.theme.numberCards
                self.color = self.theme.colorCards
            }
            .navigationBarTitle(Text(self.theme.themeName), displayMode: .inline)
            .navigationBarItems(
                leading: Button(action: cancel, label: { Text("Cancel") }),
                trailing: Button(action: saveTheme, label: { Text("Done") })
                    .disabled(cannotSave)
            )
        }
    }

    var nameSection: some View {
        Section {
            TextField("Theme Name", text: $name)
        }
    }

    var addEmojiSection: some View {
        Section(header: Text("Add Emoji").font(.headline)) {
            HStack {
                TextField("Emoji", text: $addEmoji)
                Button(action: {
                    let newEmojis = self.addEmoji.trimmingCharacters(in: .whitespacesAndNewlines)
                    self.emojis.insert(contentsOf: Set<String>(newEmojis.map{String($0)}), at: 0)
                    self.addEmoji = ""
                }) {
                    Text("Add")
                }
                .buttonStyle(BorderlessButtonStyle())
            }
        }
    }

    var emojisSection: some View {
        Section(header: HStack {
            Text("Emojis").font(.headline)
            Spacer()
            Text("tap emoji to exclude")
        }) {
            ScrollView{
                LazyVGrid(columns: createGridColumns(), spacing: 10) {
                    ForEach(emojis, id: \.self) { emoji in
                        emojiItemView(emoji)
                    }
                }
            }
            .frame(height: self.emojiGridHeight)
        }
    }

    func createGridColumns() -> [GridItem] {
        let gridItem = GridItem(.flexible())
        return Array(repeating: gridItem, count: 3)
    }


    func emojiItemView(_ emoji: String) -> some View {
        Text(emoji)
            .font(Font.system(size: self.emojiGridFontSize))
            .onTapGesture {
                self.emojis.removeAll(where: { $0 == emoji })
                self.numberOfPairs = min(self.emojis.count, self.numberOfPairs)
        }
    }

    var cardCountSection: some View {
        Section(header: Text("Card Count").font(.headline)) {
            Stepper("\(numberOfPairs) pairs", value: $numberOfPairs, in: min(emojis.count, 2)...emojis.count)
                .disabled(emojis.count < 2)
        }
    }

    // List of available colors to choose from
    static let colorPatches: [Color] = [
        Color.red,
        Color.orange,
        Color.yellow,
        Color.cyan,
        Color.blue,
        Color.purple,
        Color.pink,
        Color.gray,
        Color.black,
        Color.white
    ]


    var colorSection: some View {
        Section(header: Text("Color").font(.headline)) {
            ScrollView{
                LazyVGrid(columns: createGridColumns(), spacing: 10) {
                    ForEach(MemoryEdit.colorPatches, id: \.self) { color in
                        self.colorItemView(color)
                    }
                }
                
            }.frame(height: self.colorGridHeight)
        }
    }







    // A color patch representing a color to choose.
    // The selection is shown using a filled checkmark symbol
    private func colorItemView(_ color: Color) -> some View {
        // determine "brightness" of the color to influence the checkmark color
        let brightness: CGFloat = .zero

        return RoundedRectangle(cornerRadius: 4)
            .frame(height: 40)
            .foregroundColor(color)
            .padding(2)
            .overlay(Group {
                if color == self.color {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(brightness < 0.55 ? .white : .black)
                }
            })
            .onTapGesture {
                self.color = color
            }
    }

    // MARK: - Confirmation actions

    private var cannotSave: Bool {
        name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
        emojis.count < 2
    }

    private func saveTheme() {
        name = name.trimmingCharacters(in: .whitespacesAndNewlines)
        store.updateTheme(for: theme, name: name, emoji: emojis, color: color, numberOfPairs: numberOfPairs)
       
        presentationMode.wrappedValue.dismiss()
    }

    private func cancel() {
        presentationMode.wrappedValue.dismiss()
    }

    // MARK: - Drawing Constants

    private let emojiGridFontSize: CGFloat = 40
    private var emojiGridHeight: CGFloat {
        CGFloat((emojis.count - 1 ) / 6 * 70 + 70)
    }

    private var colorGridHeight: CGFloat {
        CGFloat((Self.colorPatches.count - 1 ) / 5 * 70 + 70)
    }
}
