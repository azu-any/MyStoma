import SwiftUI

struct ChatBotOverlay: View {
    
    @EnvironmentObject var viewModel: OstomyViewModel
    @EnvironmentObject var itemsViewModel: InventoryViewModel
    @State private var currentStep: Int = 0
    @Binding var showDialogue: Bool
    @Binding var showEnd: Bool
    @Binding var showInventory: Bool
    
    
    var body: some View {
        
        VStack {
            
            VStack(alignment: .center) {
                let dialogue = viewModel.ostomy.steps[viewModel.currentStepIndex].dialogues[viewModel.currentDialogueIndex]
                
                // Text(dialogue)
                TextViewWithPopovers(
                    fullText: dialogue
                        )
                    //.multilineTextAlignment(.center)
                    //.padding()
                    /*.popover(isPresented: $showPopover, attachmentAnchor: .point(.bottom), arrowEdge: .bottom) {
                        if let word = selectedWord, let definition = definitions[word.lowercased()] {
                            Text(definition)
                                .padding()
                                .frame(maxWidth: 300)
                        }
                    }*/
            }
            .frame(maxWidth: 500)
            .font(.body)
                    
            Spacer()
            
            VStack {
                
                HStack {
                    if viewModel.currentStepIndex == viewModel.ostomy.steps.count - 1 {
                        Button {
                            showEnd = true
                        } label: {
                            Text("End")
                        }
                        .disabled(!viewModel.isDone)
                    }
                    
                    else if viewModel.currentDialogueIndex == viewModel.ostomy.steps[viewModel.currentStepIndex].dialogues.count - 1 {
                        Button {
                            viewModel.currentStepIndex += 1
                            viewModel.currentDialogueIndex = 0
                            viewModel.isDone = false
                            showInventory = false
                            viewModel.spaceID = ColostomySpaces[viewModel.currentStepIndex].id
                            
                            itemsViewModel.items.removeAll()
                            
                        } label: {
                            Text("Next step")
                        }
                        .disabled(!viewModel.isDone)
                    }
                    
                    
                    Spacer()
                    
                    Button {
                        viewModel.currentDialogueIndex -= 1
                    } label: {
                        Image(systemName: "chevron.left")
                    }
                    .buttonStyle(.plain)
                    .disabled(!canGoBack(index: viewModel.currentDialogueIndex))
                    
                    
                    Button {
                        if viewModel.ostomy.steps[viewModel.currentStepIndex].timeQuestion == viewModel.currentDialogueIndex {
                            showDialogue.toggle()
                            
                        }
                        
                        else if !showInventory && viewModel.currentDialogueIndex >= viewModel.ostomy.steps[viewModel.currentStepIndex].timePractice {
                            
                            showInventory = true
                            itemsViewModel.items.append(contentsOf: ColostomySpaces[viewModel.currentStepIndex].items)
                            
                        }
                        viewModel.currentDialogueIndex += 1
                    } label: {
                        Image(systemName: "chevron.right")
                    }
                    .buttonStyle(.plain)
                    .disabled(!canGoForward(index: viewModel.currentDialogueIndex, count: viewModel.ostomy.steps[viewModel.currentStepIndex].dialogues.count))
                }
                .padding()
                
            }
        }
    }
}

#Preview {
    ColostomyView()
        .environmentObject(OstomyViewModel(ostomy: loadOstomyFromBundle() ?? defaultOstomy)
        )
}


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
    /*
    var body: some View {
            
        let attributed: AttributedString = {
                    var attr = AttributedString(fullText)
                    let cleanedWord = word.trimmingCharacters(in: .punctuationCharacters.union(.whitespacesAndNewlines))
                    
                    if let range = attr.range(of: cleanedWord, options: .caseInsensitive) {
                        hasWord = true
                        attr[range].foregroundColor = .accentColor
                        attr[range].font = .body.bold()
                    } /*else {
                        hasWord = false
                    }*/
                    print(hasWord)
                    return attr
                }()
                
                Text(attributed)
                    .onTapGesture {
                        if hasWord {
                            showPopover = true
                        }
                    }
                    .popover(isPresented: $showPopover) {
                        Text("Definition of '\(word)' goes here.")
                            .padding()
                    }*/
        /*VStack {
            var attributed = AttributedString(fullText)

            if let range = attributed.range(of: word, options: .caseInsensitive) {
                if !hasWord {
                    hasWord = true
                    print(hasWord)
                }
                attributed[range].foregroundColor = .accentColor
                attributed[range].font = .body.bold()
                
            }
    
            return Text(attributed)
                .onTapGesture {
                    showPopover = true
                }
            }
            .padding()
            .popover(isPresented: $showPopover, content: {
                // El contenido del popover, en este caso, una definición de la palabra
                Text("La palabra \(word) significa...")
                    .padding()
                    .frame(width: 200, height: 100)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)
                    .onTapGesture {
                        showPopover = false
                    }
            })
            .disabled(!hasWord)
        */
        /*VStack {
            Text(fullText)
                .foregroundStyle(.clear)
            //.multilineTextAlignment(.center) // start with an empty view
                .overlay(alignment: .center) {
                    HStack(spacing: 4) {
                        ForEach(Array(words), id: \.self) { word in
                            let trimmed = word.trimmingCharacters(in: .punctuationCharacters)
                            if definitions.keys.contains(trimmed.lowercased()) {
                                Button {
                                    selectedWord = trimmed
                                    showPopover = true
                                } label: {
                                    Text(String(word))
                                        .foregroundColor(.blue)
                                        .underline()
                                }
                                .popover(isPresented: $showPopover, attachmentAnchor: .point(.bottom), arrowEdge: .bottom) {
                                    if let word = selectedWord, let definition = definitions[word.lowercased()] {
                                        Text(definition)
                                            .padding()
                                            .frame(maxWidth: 300)
                                    }
                                }
                            } else {
                                Text(word)//String(word))
                                    .foregroundStyle(.black)
                            }
                        }
                    }
                    //.multilineTextAlignment(.center)
                }
        }
    }*/
}

