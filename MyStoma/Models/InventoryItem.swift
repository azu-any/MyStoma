//
//  InventoryItem.swift
//  MyStoma
//
//  Created by Azuany Mila Cerón on 13/05/25.
//
import SwiftUI
import UniformTypeIdentifiers
typealias PlatformImage = UIImage


struct InventoryItem: Identifiable, Codable, Hashable {
    var id: UUID = UUID()
    var name: String
    var imageName: String
}

extension UTType {
    static var exampleInventory = UTType(exportedAs: "com.example.inventory")
}


extension InventoryItem: Transferable {
    static var transferRepresentation: some TransferRepresentation {
        
        CodableRepresentation(contentType: .exampleInventory)

        ProxyRepresentation { item in
            item.imageName
        } importing: { value in
            InventoryItem(id: UUID(), name: "", imageName: "")
        }
        .suggestedFileName { $0.imageName }

    }
}
