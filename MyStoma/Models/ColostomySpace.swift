//
//  ColostomySpace.swift
//  MyStoma
//
//  Created by Azuany Mila Cerón on 21/05/25.
//


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
        case .first: [InventoryItem(name: "Waste Bag", imageName: "WasteBag"),
                      InventoryItem(name: "Adhesive Remover Spray", imageName: "AdhesiveRemover")]
        case .second: [InventoryItem(name: "Water", imageName: "Water"), InventoryItem(name: "Cloth", imageName: "Cloth")]
        case .third: [InventoryItem(name: "Stoma Measurement Board", imageName: "Measure")]
        case .fourth: [InventoryItem(name: "Barrier ring", imageName: "Ring")]
        case .fifth: [InventoryItem(name: "Cut Stoma Bag", imageName: "Cutstomabag")]
        case .sixth: []
        case .seventh: []
        case .eighth: []
        case .ninth: []
            
        }
    }
}


let  ColostomySpaces = [ColostomySpace.first, ColostomySpace.second, ColostomySpace.third, ColostomySpace.fourth, ColostomySpace.fifth, ColostomySpace.sixth, ColostomySpace.seventh, ColostomySpace.eighth, ColostomySpace.ninth]


