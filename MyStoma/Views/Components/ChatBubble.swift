import SwiftUI

struct ChatBotOverlay: View {
    
    @EnvironmentObject var viewModel: OstomyViewModel
    @EnvironmentObject var itemsViewModel: InventoryViewModel
    @State private var currentStep: Int = 0
    @Binding var showDialogue: Bool
    @Binding var showEnd: Bool
    @Binding var showInventory: Bool
    
    var body: some View {
            
        VStack(alignment: .leading) {
            let dialogue = viewModel.ostomy.steps[viewModel.currentStepIndex].dialogues[viewModel.currentDialogueIndex]
            
            TextViewWithPopovers(fullText: dialogue)
                
        }
        .font(.body)
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    ColostomyView()
        .environmentObject(OstomyViewModel(ostomy: loadOstomyFromBundle() ?? defaultOstomy)
        )
}
