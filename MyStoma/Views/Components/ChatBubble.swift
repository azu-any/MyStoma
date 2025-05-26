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
                
                Text(dialogue)
                //TypingTextView(fullText: dialogue, trigger: viewModel.currentDialogueIndex)
                    .multilineTextAlignment(.center)
                    .padding()
                    .transition(.slide)
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
