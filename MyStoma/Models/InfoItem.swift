import SwiftUI
import simd

enum StomaCategory: String, CaseIterable, Identifiable, Codable {
    case colostomy
    case ileostomy
    case urostomy

    var id: String { self.rawValue }
}

struct InfoItem: Identifiable, Equatable {
    let id = UUID()
    let title: LocalizedStringResource
    let description: LocalizedStringResource
    let imageName: String
    let modelName: String
    let categories: [StomaCategory]
    let modelPosition: SIMD3<Float>
    let modelScale: SIMD3<Float>
    let modelRotation: [Float]?

    init(
        title: LocalizedStringResource,
        description: LocalizedStringResource,
        imageName: String = "",
        modelName: String = "",
        categories: [StomaCategory] = [],
        modelPosition: SIMD3<Float> = [0, 0, 0],
        modelScale: SIMD3<Float> = [1, 1, 1],
        modelRotation: [Float]? = nil
    ) {
        self.title = title
        self.description = description
        self.imageName = imageName
        self.modelName = modelName
        self.categories = categories
        self.modelPosition = modelPosition
        self.modelScale = modelScale
        self.modelRotation = modelRotation
    }
}



let items: [InfoItem] = [
    InfoItem(
        title: "infoitem_onepiecebag_title",
        description: "infoitem_onepiecebag_description",
        imageName: "Cleanstomabag",
        modelName: "Cleanstoma",
        categories: [.colostomy, .ileostomy],
        modelPosition: [0, 0.5, 0],
        modelScale: [1.9, 1.9, 1.9]
    ),
    InfoItem(
        title: "infoitem_stomasizer_title",
        description: "infoitem_stomasizer_description",
        imageName: "Measure",
        modelName: "StomaSizer",
        categories: [.colostomy, .ileostomy, .urostomy],
        modelPosition: [0, -0.3, 0],
        modelScale: [0.8, 0.8, 0.8]
    ),
    InfoItem(
        title: "infoitem_adhesiveremover_title",
        description: "infoitem_adhesiveremover_description",
        imageName: "AdhesiveRemover",
        modelName: "Bottle",
        categories: [.colostomy, .ileostomy, .urostomy],
        modelPosition: [0, -0.6, 0],
        modelScale: [0.4, 0.4, 0.4]
    ),
    InfoItem(
        title: "infoitem_scissors_title",
        description: "infoitem_scissors_description",
        imageName: "Scissors",
        modelName: "scissors",
        categories: [.colostomy, .ileostomy, .urostomy],
        modelPosition: [0, -0.3, 0],
        modelScale: [0.6, 0.6, 0.6]
    ),
    InfoItem(
        title: "infoitem_barrierring_title",
        description: "infoitem_barrierring_description",
        imageName: "Ring",
        modelName: "Paste",
        categories: [.colostomy, .ileostomy, .urostomy],
        modelPosition: [0, 0.3, 0],
        modelScale: [0.4, 0.4, 0.4]
    ),
    InfoItem(
        title: "infoitem_wipes_title",
        description: "infoitem_wipes_description",
        imageName: "Cloth",
        modelName: "Cloth",
        categories: [.colostomy, .ileostomy, .urostomy],
        modelPosition: [0, -0.2, 0],
        modelScale: [0.4, 0.4, 0.4],
        modelRotation: [90 , 0 ,0]
    ),
    InfoItem(
        title: "infoitem_wastebag_title",
        description: "infoitem_wastebag_description",
        imageName: "WasteBag",
        modelName: "WasteBag",
        categories: [.colostomy, .ileostomy, .urostomy],
        modelPosition: [0, 0.1, 0],
        modelScale: [2, 2, 2]
    ),
]

extension InfoItem {
    static let sampleItems: [InfoItem] = items
}
