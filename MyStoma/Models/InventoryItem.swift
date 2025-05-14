//
//  InventoryItem.swift
//  MyStoma
//
//  Created by Azuany Mila Cerón on 13/05/25.
//
import Foundation

struct InventoryItem: Identifiable {
    var id: UUID = UUID()
    var name: String
    var imageName: String
}
