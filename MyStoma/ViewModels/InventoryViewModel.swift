//
//  InventoryViewModel.swift
//  MyStoma
//
//  Created by Azuany Mila Cerón on 13/05/25.
//

import Foundation

class InventoryViewModel: ObservableObject {
    
    @Published var items: [InventoryItem] = [
        InventoryItem(name: "Colostomy Bag", imageName: "StomaBag"),
        InventoryItem(name: "Waste Bag", imageName: "WasteBag"),
        InventoryItem(name: "Adhesive Remover Spray", imageName: "AdhesiveRemover")
    ]
    
    
    
    func handleDroppedItems(droppedItems: [InventoryItem]) {
        guard let firstItem = droppedItems.first else {
            return
        }
        
        if firstItem.imageName == "StomaBag" {
            items.remove(at: 0)
        }
    }
}
