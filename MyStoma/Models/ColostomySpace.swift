import SwiftUI

enum ColostomySpace {
    case first
    case second
    case third
    case fourth
    case fifth
    case sixth
    case seventh
    case eighth
    case ninth
    
    var id: String {
        switch self {
        case .first: return "ColostomyFirstSpace"
        case .second: return "ColostomySecondSpace"
        case .third: return "ColostomyThirdSpace"
        case .fourth: return "ColostomyFourthSpace"
        case .fifth: return "ColostomyFifthSpace"
        case .sixth: return "ColostomySixthSpace"
        case .seventh: return "ColostomySeventhSpace"
        case .eighth: return "ColostomyEighthSpace"
        case .ninth: return "ColostomyNinthSpace"
        }
    }
    
    var items: [InventoryItem] {
        switch self {
        case .first:
            return [
                InventoryItem(nameKey: "Waste Bag", imageName: "WasteBag"),
                InventoryItem(nameKey: "Adhesive Remover Spray", imageName: "AdhesiveRemover")
            ]
        case .second:
            return [
                InventoryItem(nameKey: "Water", imageName: "Water"),
                InventoryItem(nameKey: "Cloth", imageName: "Cloth")
            ]
        case .third:
            return [
                InventoryItem(nameKey: "Stoma Measurement Board", imageName: "Measure")
            ]
        case .fourth:
            return [
                InventoryItem(nameKey: "Barrier ring", imageName: "Ring")
            ]
        case .fifth:
            return [
                InventoryItem(nameKey: "Cut Stoma Bag", imageName: "Cutstomabag")
            ]
        case .sixth, .seventh, .eighth, .ninth:
            return []
        }
    }
}

let ColostomySpaces = [
    ColostomySpace.first, ColostomySpace.second, ColostomySpace.third,
    ColostomySpace.fourth, ColostomySpace.fifth, ColostomySpace.sixth,
    ColostomySpace.seventh, ColostomySpace.eighth, ColostomySpace.ninth
]
