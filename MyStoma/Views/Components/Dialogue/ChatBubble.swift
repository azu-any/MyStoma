

// TODO: Simplify view with Popover view
import SwiftUI

struct ChatBotOverlay: View {
    
    @EnvironmentObject var viewModel: OstomyViewModel
    
    var body: some View {
            
        VStack(alignment: .leading) {
            let dialogue = viewModel.ostomy.steps[viewModel.currentStepIndex].dialogues[viewModel.currentDialogueIndex]
            
            TextViewWithPopovers(fullText: dialogue)
                
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    ColostomyView()
        .environmentObject(OstomyViewModel(ostomy: loadOstomyFromBundle() ?? defaultOstomy))
}
