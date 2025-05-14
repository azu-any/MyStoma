import SwiftUI

struct InfoItem: Identifiable, Equatable {
    let id = UUID()
    let title: String
    let description: String
    let isUnlocked: Bool
    
    init(title: String, description: String, isUnlocked: Bool = false) {
        self.title = title
        self.description = description
        self.isUnlocked = isUnlocked
    }
}


let items: [InfoItem] = [
    InfoItem(
        title: "Medical Waste Bag",
        description: "Used to safely dispose of used stoma bags, wipes, and other contaminated materials.",
        isUnlocked: true
    ),
    InfoItem(
        title: "Wipes/Absorbent Cloths",
        description: "Alcohol-free, used to clean and dry the skin around the stoma before applying a new bag.",
        isUnlocked: true
    ),
    InfoItem(
        title: "Curved Scissors",
        description: "Used to cut the skin barrier to fit the stoma if using a cut-to-size system."
    ),
    InfoItem(
        title: "One-Piece Drainable Stoma Bag",
        description: "A combined pouch and barrier that collects output and can be emptied without removal."
    ),
    InfoItem(
        title: "Modeling Paste/Barrier Ring",
        description: "Applied around the stoma to fill skin creases, prevent leaks, and protect skin."
    ),
    InfoItem(
        title: "Adhesive Spray/Remover",
        description: "Spray for better adhesion or to gently remove the barrier without skin irritation."
    ),
    InfoItem(
        title: "?",
        description: "?"
    ),
    InfoItem(
        title: "?",
        description: "?"
    ),
]
