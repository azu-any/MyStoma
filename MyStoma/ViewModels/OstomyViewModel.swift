//
//  OstomyViewModel.swift
//  MyStoma
//
//  Created by Azuany Mila Cerón on 08/05/25.
//


import SwiftUI


class OstomyViewModel: ObservableObject {
    @Published var ostomy: Ostomy
    //@Published var inventoryVM: InventoryViewModel
    //let inventoryVM = InventoryViewModel()

    @Published var currentStepIndex: Int = 0
    @Published var currentDialogueIndex: Int = 0
    @Published var isDone: Bool = false
    @Published var showInventory: Bool = false
    @Published var spaceID: String = ColostomySpace.first.id
    @Published var viewState: OstomyViewState = .dialogue
    
    @Published var items: [InventoryItem] = []
    
    func handleBodyItems(droppedItems: [InventoryItem]) -> String {
        guard let firstItem = droppedItems.first else { return "" }
        
        if firstItem.imageName == "AdhesiveRemover" {
            print("done")
            self.items.removeAll { $0.imageName == "AdhesiveRemover" }
            items.append(InventoryItem(nameKey: "Colostomy Bag", imageName: "StomaBag"))
            return "RemoveBag"
        }
        
        else if firstItem.imageName == "WetCloth" {
            items.removeAll { $0.imageName == "WetCloth" }
            return "Done"
        }
        
        else if firstItem.imageName == "Measure" {
            items.removeAll { $0.imageName == "Measure" }
            items.append(InventoryItem(nameKey: "Scissors", imageName: "Scissors"))
            items.append(InventoryItem(nameKey: "New Stoma Bag", imageName: "Cleanstomabag"))
            return "Measure"
        }
        
        else if firstItem.imageName == "Ring" {
            items.removeAll { $0.imageName == "Ring" }
            return "Ring"
        }
        
        else if firstItem.imageName == "Cutstomabag" {
            items.removeAll { $0.imageName == "Cutstomabag" }
            return "Cutstomabag"
        }
        
        
        return ""
    }
    
    func handleMaterialItems(droppedItems: [InventoryItem]) -> String {
        guard let firstItem = droppedItems.first else {
            return ""
        }
        
        if firstItem.imageName == "StomaBag" {
            items.removeAll { $0.imageName == "StomaBag" }
            return "TrashBag"
        }
        
        else if firstItem.imageName == "Scissors" {
            items.removeAll { $0.imageName == "Scissors" }
            items.removeAll { $0.imageName == "Cleanstomabag" }
            items.append(InventoryItem(nameKey: "Cut Stoma Bag", imageName: "Cutstomabag-Nointeraction"))
            return "Scissors"
        }
        
        else if firstItem.imageName == "Water" {
            items.removeAll { $0.imageName == "Water" }
            items.removeAll { $0.imageName == "Cloth" }
            items.append(InventoryItem(nameKey: "Wet cloth", imageName: "WetCloth"))
        }
        
        return ""
    }


    init(ostomy: Ostomy) {
        self.ostomy = ostomy
    }

    var currentStep: Step {
        ostomy.steps[currentStepIndex]
    }

    func advanceDialogue() {
            if currentDialogueIndex < currentStep.dialogues.count - 1 {
                currentDialogueIndex += 1
                if currentDialogueIndex == currentStep.timeQuestion + 1{
                    viewState = .question
                } else if currentDialogueIndex == currentStep.timePractice + 1 {
                    if !showInventory {
                        items.removeAll()
                        items.append(contentsOf: ColostomySpaces[currentStepIndex].items)
                        showInventory.toggle()
                    }
                }
            } else if currentStepIndex == ostomy.steps.count - 1 {
                viewState = .end
            }  else {
                viewState = .dialogue
            }
        }

    func goToNextStep() {
        if currentStepIndex < ostomy.steps.count - 1 {
            currentStepIndex += 1
            currentDialogueIndex = 0
            viewState = .dialogue
            isDone = false
            showInventory = false
        }
    }
    
    func restartTutorial() {
        currentStepIndex = 0
        currentDialogueIndex = 0
        isDone = false
        showInventory = false
        viewState = .dialogue
    }
    
    func advanceOrFinish() {
        items.removeAll()
        
        if isLastDialogueInStep {
            if isLastStep {
                viewState = .end
            } else {
                goToNextStep()
            }
        }
    }
}


extension OstomyViewModel {
    var isLastDialogueInStep: Bool {
        currentDialogueIndex == currentStep.dialogues.count - 1
    }
    
    var isLastStep: Bool {
        currentStepIndex == ostomy.steps.count - 1
    }
}
