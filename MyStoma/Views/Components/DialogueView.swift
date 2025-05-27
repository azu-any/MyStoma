//
//  DialogueView.swift
//  MyStoma
//
//  Created by Azuany Mila Cerón on 08/05/25.
//
import SwiftUI

struct DialogueView: View {
    
    @Binding var showDialogue: Bool
    @EnvironmentObject var viewModel: OstomyViewModel
    
    var body: some View {
        
        VStack(alignment: .leading) {
            HStack {
                Image("NurseLeft")
                    .resizable()
                    .scaledToFit()
                    .clipShape(Circle())
                    .frame(width: 100, height: 100)
                
                let dialogue = viewModel.ostomy.steps[viewModel.currentStepIndex].dialogues[viewModel.currentDialogueIndex]
                
                //Text(dialogue)
                    //.multilineTextAlignment(.leading)
                TypingTextView(fullText: dialogue, trigger: viewModel.currentDialogueIndex)
                    .frame(width: 400, height: 100)
                    .padding(.top, 40)
            }
        }
    }
}
