//
//  InventoryViewModel.swift
//  MyStoma
//
//  Created by Azuany Mila Cerón on 13/05/25.
//

import Foundation

class InventoryViewModel: ObservableObject {
    
    @Published var items: [InventoryItem] = [
        //
        InventoryItem(name: "Waste Bag", imageName: "WasteBag"),
        InventoryItem(name: "Adhesive Remover Spray", imageName: "AdhesiveRemover")
    ]
    
    
    
    func handleBodyItems(droppedItems: [InventoryItem]) -> String {
        guard let firstItem = droppedItems.first else { return "" }
        
        if firstItem.imageName == "AdhesiveRemover" {
            items.removeAll { $0.imageName == "AdhesiveRemover" }
            items.append(InventoryItem(name: "Colostomy Bag", imageName: "StomaBag"))
            
            return "RemoveBag"
        }
        
        else if firstItem.imageName == "Cloth" {
            items.removeAll { $0.imageName == "Cloth" }
            return "Done"
        }
        
        else if firstItem.imageName == "Measure" {
            items.removeAll { $0.imageName == "Measure" }
            return "Measure"
        }
        
        else if firstItem.imageName == "Ring" {
            items.removeAll { $0.imageName == "Ring" }
            return "Ring"
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
        
        return ""
    }
}
