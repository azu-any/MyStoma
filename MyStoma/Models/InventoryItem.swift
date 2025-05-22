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
        
        /*DataRepresentation(contentType: .vCard) { item in
         try item.toVCardData()
         } importing: { data in
         try await parseVCardData(data)
         }
         .suggestedFileName { $0.fullName }*/
        
        // Enables exporting the `phoneNumber` string as a proxy for the entire `Contact`.
        ProxyRepresentation { item in
            item.imageName
        } importing: { value in
            InventoryItem(id: UUID(), name: "", imageName: "")
        }
        .suggestedFileName { $0.imageName }

    }

    func handleDroppedItems(droppedItems: [InventoryItem], index: Int? = nil) {
        guard droppedItems.first != nil else {
            return
        }
        // If the ID of the first contact exists in the contacts list,
        // move the contact from its current position to the new index.
        // If no index is specified, insert the contact at the end of the list.
        /*if let existingIndex = contacts.firstIndex(where: { $0.id == firstContact.id }) {
            let indexSet = IndexSet(integer: existingIndex)
            contacts.move(fromOffsets: indexSet, toOffset: index ?? contacts.endIndex)
        } else {
            contacts.insert(firstContact, at: index ?? contacts.endIndex)
        }*/
    }
    
    /*static func parseVCardData(_ data: Data) async throws -> Contact {
        let contacts = try await CNContactVCardSerialization.contacts(
            with: data
        )
        
        guard let contact = contacts.first else {
            throw NSError(domain: "ContactImportError", code: 1, userInfo: [NSLocalizedDescriptionKey: "Invalid vCard data."])
        }
        
        let phoneNumber = contact.phoneNumbers.first?.value.stringValue ?? ""
        let email = contact.emailAddresses.first?.value as String?
        let thumbNail: Data? = contact.imageData
        return Contact(
            id: contact.id.uuidString,
            givenName: contact.givenName,
            familyName: contact.familyName,
            thumbNail: thumbNail,
            phoneNumber: phoneNumber,
            email: email,
            videoURL: nil
        )
    }*/
}
