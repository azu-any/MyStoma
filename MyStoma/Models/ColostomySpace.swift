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
        case .first: "ColostomyFirstSpace"
        case .second: "ColostomySecondSpace"
        case .third: "ColostomyThirdSpace"
        case .fourth: "ColostomyFourthSpace"
        case .fifth: "ColostomyFifthSpace"
        case .sixth: "ColostomySixthSpace"
        case .seventh: "ColostomySeventhSpace"
        case .eighth: "ColostomyEighthSpace"
        case .ninth: "ColostomyNinthSpace"
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
