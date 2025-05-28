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
    let modelName: String
    let categories: [StomaCategory]
    let modelPosition: SIMD3<Float>
    let modelScale: SIMD3<Float>
    let modelRotation: SIMD3<Float>

    init(
        title: LocalizedStringResource,
        description: LocalizedStringResource,
        modelName: String = "",
        categories: [StomaCategory] = [],
        modelPosition: SIMD3<Float> = [0, 0, 0],
        modelScale: SIMD3<Float> = [1, 1, 1],
        modelRotation: SIMD3<Float> = [0, 0, 0]
    ) {
        self.title = title
        self.description = description
        self.modelName = modelName
        self.categories = categories
        self.modelPosition = modelPosition
        self.modelScale = modelScale
        self.modelRotation = modelRotation
    }
}



let items: [InfoItem] = [
    /*InfoItem(
        title: "infoitem_stomabag_title",
        description: "infoitem_stomabag_description",
        modelName: "stomabag",
        categories: [.colostomy],
        modelPosition: [0, 0.5, 0],
        modelScale: [2, 2, 2]
    ),*/
    InfoItem(
        title: "infoitem_adhesivespray_title",
        description: "infoitem_adhesivespray_description",
        modelName: "Bottle",
        categories: [.colostomy, .ileostomy, .urostomy],
        modelPosition: [0, -0.6, 0],
        modelScale: [0.4, 0.4, 0.4]
    ),
    InfoItem(
        title: "infoitem_wastebag_title",
        description: "infoitem_wastebag_description",
        modelName: "WasteBag",
        categories: [.colostomy, .ileostomy, .urostomy],
        modelPosition: [0, 0.1, 0],
        modelScale: [2, 2, 2]
    ),
    InfoItem(
        title: "infoitem_wipes_title",
        description: "infoitem_wipes_description",
        modelName: "Cloth",
        categories: [.colostomy, .ileostomy, .urostomy],
        modelPosition: [0, -0.2, 0],
        modelScale: [0.4, 0.4, 0.4],
        modelRotation: [0,0,0]
    ),
    InfoItem(
        title: "infoitem_scissors_title",
        description: "infoitem_scissors_description",
        modelName: "scissors",
        categories: [.colostomy, .ileostomy, .urostomy],
        modelPosition: [0, -0.3, 0],
        modelScale: [0.6, 0.6, 0.6]
    ),
    InfoItem(
        title: "infoitem_onepiecebag_title",
        description: "infoitem_onepiecebag_description",
        modelName: "Cleanstoma",
        categories: [.colostomy, .ileostomy, .urostomy],
        modelPosition: [0, 0.5, 0],
        modelScale: [1.9, 1.9, 1.9]
    ),
    InfoItem(
        title: "infoitem_barrierring_title",
        description: "infoitem_barrierring_description",
        modelName: "Paste",
        categories: [.colostomy, .ileostomy, .urostomy],
        modelPosition: [0, 0.3, 0],
        modelScale: [0.4, 0.4, 0.4]
    ),
]

extension InfoItem {
    static let sampleItems: [InfoItem] = items
}
