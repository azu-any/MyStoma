import SwiftUI

struct ChatBotOverlay: View {
    
    @EnvironmentObject var viewModel: OstomyViewModel
    @EnvironmentObject var itemsViewModel: InventoryViewModel
    @State private var currentStep: Int = 0
    @Binding var showDialogue: Bool
    
    var body: some View {
        
        VStack {
            
            VStack(alignment: .center) {
                //let dialogue = viewModel.ostomy.steps[viewModel.currentStepIndex].dialogues[viewModel.currentDialogueIndex]
                
                Text(viewModel.ostomy.steps[viewModel.currentStepIndex].dialogues[viewModel.currentDialogueIndex])
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
                    
                    if viewModel.currentDialogueIndex == viewModel.ostomy.steps[viewModel.currentStepIndex].dialogues.count - 1 {
                        Button {
                            viewModel.currentStepIndex += 1
                            viewModel.currentDialogueIndex = 0
                            viewModel.isDone = false
                            viewModel.spaceID = ColostomySpaces[viewModel.currentStepIndex].id
                            
                            itemsViewModel.items.removeAll()
                            itemsViewModel.items.append(contentsOf: ColostomySpaces[viewModel.currentStepIndex].items)
                            
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
        /*VStack(alignment: .trailing) {
            HStack(alignment: .top, spacing: 20) {
                
                VStack(alignment: .trailing) {
                    //let dialogue = viewModel.ostomy.steps[viewModel.currentStepIndex].dialogues[viewModel.currentDialogueIndex]
                    
                    Text(viewModel.ostomy.steps[viewModel.currentStepIndex].dialogues[viewModel.currentDialogueIndex])
                    //TypingTextView(fullText: dialogue, trigger: viewModel.currentDialogueIndex)
                        .multilineTextAlignment(.leading)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 20)
                            .fill(Color.gray.opacity(0.1))
                            .shadow(radius: 5)
                            )
                        .cornerRadius(20)
                        .frame(maxWidth: 280, alignment: .trailing)
                        .font(.body)
                        .transition(.slide)

                        

                                        
                }
                
                
                VStack {
                    Image("NurseRight")
                        .resizable()
                        .frame(width: 60, height: 60)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.white, lineWidth: 2))
                        .shadow(radius: 4)
                    
                    HStack {
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
        .frame(maxWidth: 500)
        .padding()*/
    }
}

#Preview {
    ColostomyView()
        .environmentObject(OstomyViewModel(ostomy: loadOstomyFromBundle() ?? defaultOstomy)
        )
}
