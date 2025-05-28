//
//  DialogueControlsView.swift
//  MyStoma
//
//  Created by Azuany Mila Cerón on 28/05/25.
//

import SwiftUI


struct DialogueControlsView: View {
    @EnvironmentObject var ostomyViewModel: OstomyViewModel
    
    var body: some View {
        HStack {
            
            // Previous dialogue
            Button {
                ostomyViewModel.currentDialogueIndex -= 1
            } label: {
                Image(systemName: "chevron.left.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30)
            }
            .disabled(!canGoBack(index: ostomyViewModel.currentDialogueIndex))
            
            
            Spacer()
            
            
            // Next step or End
            if ostomyViewModel.isLastDialogueInStep {
                Button {
                    ostomyViewModel.advanceOrFinish()
                } label: {
                    Text(ostomyViewModel.isLastStep ? "End" : "Next step")
                }
                .disabled(!ostomyViewModel.isDone)
                
                Spacer()

            }

            
            // Next dialogue
            Button {
                ostomyViewModel.advanceDialogue()

            } label: {
                Image(systemName: "chevron.right.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30)
            }
            .disabled(!canGoForward(index: ostomyViewModel.currentDialogueIndex, count: ostomyViewModel.ostomy.steps[ostomyViewModel.currentStepIndex].dialogues.count))
        }
    }
}

