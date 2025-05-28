import SwiftUI

struct TextViewWithPopovers: View {
    let fullText: String
    var languageCode: String {
        return Locale.current.language.languageCode?.identifier ?? "en"
    }
    
    @State private var showPopover = false
    @State private var highlightedWord: String? = nil
    @State private var attributedText = AttributedString("")
    
    var availableWords: [String] {
        let keys = definitions.keys
        var words = Set<String>()
        for key in keys {
            let components = key.split(separator: "_")
            if components.count == 2 {
                words.insert(String(components[1]))
            }
        }
        return Array(words)
    }
    
    var body: some View {
        Text(attributedText)
            .multilineTextAlignment(.leading)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            .onTapGesture {
                if highlightedWord != nil {
                    showPopover = true
                }
            }
            .onAppear {
                setupAttributedText()
            }
            .onChange(of: fullText) {
                setupAttributedText()
            }
            .popover(isPresented: $showPopover) {
                if let word = highlightedWord {
                    Text(definitions["\(languageCode)_\(word)"] ?? "No definition found")
                        .padding()
                } else {
                    Text("No definition found")
                        .padding()
                }
            }
    }
    
    private func setupAttributedText() {
        var attributed = AttributedString(fullText)
        highlightedWord = nil
        
        for word in availableWords {
            if let range = attributed.range(of: word, options: .caseInsensitive) {
                attributed[range].foregroundColor = .accentColor
                attributed[range].font = .body.bold()
                highlightedWord = word
                break
            }
        }
        
        attributedText = attributed
    }
}
