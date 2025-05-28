import Foundation

class InventoryViewModel: ObservableObject {
    
    @Published var items: [InventoryItem] = []
    
    func handleBodyItems(droppedItems: [InventoryItem]) -> String {
        guard let firstItem = droppedItems.first else { return "" }
        
        if firstItem.imageName == "AdhesiveRemover" {
            items.removeAll { $0.imageName == "AdhesiveRemover" }
            items.append(InventoryItem(nameKey: "Colostomy Bag", imageName: "StomaBag"))
            
            return "RemoveBag"
        }
        
        else if firstItem.imageName == "Cloth" {
            items.removeAll { $0.imageName == "Cloth" }
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
            items.append(InventoryItem(nameKey: "Cut Stoma Bag", imageName: "Cutstomabag"))

            return "Scissors"
        }
        
        return ""
    }
}
