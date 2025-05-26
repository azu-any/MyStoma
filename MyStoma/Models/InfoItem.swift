import SwiftUI
import simd

struct InfoItem: Identifiable, Equatable {
    let id = UUID()
    let title: LocalizedStringResource
    let description: LocalizedStringResource
    let modelName: String
    let modelPosition: SIMD3<Float>
    let modelScale: SIMD3<Float>
    let isUnlocked: Bool

    init(
        title: LocalizedStringResource,
        description: LocalizedStringResource,
        isUnlocked: Bool = false,
        modelName: String = "",
        modelPosition: SIMD3<Float> = [0, 0, 0],
        modelScale: SIMD3<Float> = [1, 1, 1]
    ) {
        self.title = title
        self.description = description
        self.isUnlocked = isUnlocked
        self.modelName = modelName
        self.modelPosition = modelPosition
        self.modelScale = modelScale
    }
}



let items: [InfoItem] = [
    InfoItem(
        title: "infoitem_stomabag_title",
        description: "infoitem_stomabag_description",
        isUnlocked: true,
        modelName: "stomabag",
        modelPosition: [0, 0.5, 0],
        modelScale: [2, 2, 2]
    ),
    InfoItem(
        title: "infoitem_adhesivespray_title",
        description: "infoitem_adhesivespray_description",
        isUnlocked: true,
        modelName: "Bottle",
        modelPosition: [0, -0.8, 0],
        modelScale: [0.5, 0.5, 0.5]
    ),
    InfoItem(
        title: "infoitem_wastebag_title",
        description: "infoitem_wastebag_description",
        isUnlocked: true,
        modelName: "WasteBag",
        modelPosition: [0, -0.7, 0],
        modelScale: [0.7, 0.7, 0.7]
    ),
    InfoItem(
        title: "infoitem_wipes_title",
        description: "infoitem_wipes_description",
        isUnlocked: false,
        modelName: "WasteBag"
    ),
    InfoItem(
        title: "infoitem_scissors_title",
        description: "infoitem_scissors_description",
        modelName: "WasteBag"
    ),
    InfoItem(
        title: "infoitem_onepiecebag_title",
        description: "infoitem_onepiecebag_description",
        modelName: "WasteBag"
    ),
    InfoItem(
        title: "infoitem_barrierring_title",
        description: "infoitem_barrierring_description",
        modelName: "WasteBag"
    ),
    InfoItem(
        title: "infoitem_adhesiveremover_title",
        description: "infoitem_adhesiveremover_description",
        modelName: "WasteBag"
    ),
    InfoItem(
        title: "infoitem_placeholder1_title",
        description: "infoitem_placeholder1_description",
        modelName: "WasteBag"
    ),
    InfoItem(
        title: "infoitem_placeholder2_title",
        description: "infoitem_placeholder2_description",
        modelName: "WasteBag"
    ),
]
