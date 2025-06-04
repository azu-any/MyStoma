import SwiftUI
import UniformTypeIdentifiers

typealias PlatformImage = UIImage

struct InventoryItem: Identifiable, Codable, Hashable {
    var id: UUID = UUID()
    var nameKey: String
    var imageName: String
    
    var name: LocalizedStringResource {
        LocalizedStringResource(stringLiteral: nameKey)
    }
    
    init(id: UUID = UUID(), nameKey: String, imageName: String) {
        self.id = id
        self.nameKey = nameKey
        self.imageName = imageName
    }
}

extension UTType {
    static var exampleInventory = UTType(exportedAs: "visionchilla.MyStoma.inventory") //com.example.inventory
}

extension InventoryItem: Transferable {
    static var transferRepresentation: some TransferRepresentation {
        CodableRepresentation(contentType: .exampleInventory)
    }
}
