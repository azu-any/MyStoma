import SwiftUI

struct ChatBotOverlay: View {
    
    @EnvironmentObject var viewModel: OstomyViewModel
    @State private var currentStep: Int = 0
    
    let steps: [String]
    
    var body: some View {
        VStack(alignment: .trailing) {
            HStack(alignment: .center, spacing: 16) {
                
                VStack(alignment: .trailing) {
                    let dialogue = viewModel.ostomy.steps[viewModel.currentStepIndex].dialogues[viewModel.currentDialogueIndex]
                    
                    Text(dialogue)
                        .multilineTextAlignment(.leading)
                        .padding()
                        .background(Color.bluePrimary.opacity(0.2))
                        .cornerRadius(20)
                        .frame(maxWidth: 400)
                        .font(.body)
                        .transition(.slide)
                    
                
                    HStack {
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
                                //showDialogue.toggle()
                            }
                            viewModel.currentDialogueIndex += 1
                        } label: {
                            Image(systemName: "chevron.right")
                        }
                        .buttonStyle(.plain)
                        .disabled(!canGoForward(index: viewModel.currentDialogueIndex, count: viewModel.ostomy.steps[viewModel.currentStepIndex].dialogues.count))
                    }
                    .padding(.trailing)
                    
                }
                
                Image("NurseRight")
                    .resizable()
                    .frame(width: 60, height: 60)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 2))
                    .shadow(radius: 4)
                
                
            }
        }
        .frame(maxWidth: 500)
        .padding()
    }
}

#Preview {
    ColostomyView()
        .environmentObject(OstomyViewModel(ostomy: loadOstomyFromBundle() ?? defaultOstomy)
        )
}
