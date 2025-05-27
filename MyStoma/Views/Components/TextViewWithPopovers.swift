//
//  TextViewWithPopovers.swift
//  MyStoma
//
//  Created by Azuany Mila Cerón on 27/05/25.
//
import SwiftUI

struct TextViewWithPopovers: View {
    let fullText: String
     let word = "plaque"

    @State var selectedWord: String?
    @State var showPopover: Bool = false
    @State var hasWord: Bool = false
    @State private var attributedText = AttributedString("")

    var body: some View {
            Text(attributedText)
                .padding()
                .onTapGesture {
                    if hasWord {
                        showPopover = true
                    }
                }
                .onAppear{
                    setupAttributedText()
                }
                .onChange(of: fullText) {
                    setupAttributedText()
                }
                .popover(isPresented: $showPopover) {
                    Text("Definition of '\(word)' goes here.")
                        .padding()
                }
        }
    

        private func setupAttributedText() {
            var attributed = AttributedString(fullText)
            let cleanedWord = word.trimmingCharacters(in: .punctuationCharacters.union(.whitespacesAndNewlines))

            if let range = attributed.range(of: cleanedWord, options: .caseInsensitive) {
                attributed[range].foregroundColor = .accentColor
                attributed[range].font = .body.bold()
                hasWord = true
            } else {
                hasWord = false
            }

            attributedText = attributed
        }
}
