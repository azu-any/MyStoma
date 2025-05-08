//
//  OstomyViewModel.swift
//  MyStoma
//
//  Created by Azuany Mila Cerón on 08/05/25.
//


import SwiftUI

class OstomyViewModel: ObservableObject {
    @Published var ostomy: Ostomy
    @Published var currentStepIndex: Int = 0
    @Published var currentDialogueIndex: Int = 0

    init(ostomy: Ostomy) {
        self.ostomy = ostomy
    }

    var currentStep: Step {
        ostomy.steps[currentStepIndex]
    }

    func advanceDialogue() {
        if currentDialogueIndex < currentStep.dialogues.count - 1 {
            currentDialogueIndex += 1
        }
    }

    func goToNextStep() {
        if currentStepIndex < ostomy.steps.count - 1 {
            currentStepIndex += 1
            currentDialogueIndex = 0
        }
    }

}
