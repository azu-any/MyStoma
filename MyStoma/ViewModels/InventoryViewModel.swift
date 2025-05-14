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
        InventoryItem(name: "Colostomy Bag", imageName: "StomaBag"),
        InventoryItem(name: "Colostomy Bag", imageName: "StomaBag")
    ]
}
