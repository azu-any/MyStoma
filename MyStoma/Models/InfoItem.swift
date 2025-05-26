import SwiftUI
import simd

enum StomaCategory: String, CaseIterable, Identifiable, Codable {
    case colostomy
    case ileostomy
    case urostomy
    case unknown

    var id: String { self.rawValue }
}

struct InfoItem: Identifiable, Equatable {
    let id = UUID()
    let title: String
    let description: String
    let modelName: String
    let categories: [StomaCategory]
    let modelPosition: SIMD3<Float>
    let modelScale: SIMD3<Float>
    
    init(title: String, description: String, modelName: String = "", categories: [StomaCategory] = [], modelPosition: SIMD3<Float> = [0, 0, 0], modelScale: SIMD3<Float> = [1, 1, 1]) {
        self.title = title
        self.description = description
        self.modelName = modelName
        self.categories = categories
        self.modelPosition = modelPosition
        self.modelScale = modelScale
    }
}


let items: [InfoItem] = [
    InfoItem(
        title: "Stoma Bag",
        description: "Also called an ostomy pouch, it is a medical device that collects waste from the body after certain types of surgery where part of the intestines or urinary system is diverted through an opening in the abdomen called a stoma.",
        modelName: "stomabag",
        categories: [.colostomy],
        modelPosition: [0, 0.5, 0],
        modelScale: [2, 2, 2]
    ),
    InfoItem(
        title: "Adhesive Remover Spray",
        description: "A gentle adhesive remover spray designed to effortlessly lift stoma bags and medical adhesives from the skin, reducing discomfort and protecting sensitive areas during appliance changes.",
        modelName: "Bottle",
        categories: [.colostomy],
        modelPosition: [0, -0.8, 0],
        modelScale: [0.5, 0.5, 0.5]
    ),
    InfoItem(
        title: "Medical Waste Bag",
        description: "Used to safely dispose of used stoma bags, wipes, and other contaminated materials.",
        modelName: "WasteBag",
        categories: [.colostomy],
        modelPosition: [0, -0.7, 0],
        modelScale: [0.7, 0.7, 0.7]
    ),
    InfoItem(
        title: "Wipes/Absorbent Cloths",
        description: "Alcohol-free, used to clean and dry the skin around the stoma before applying a new bag.",
        modelName: "Cloth",
        categories: [.colostomy]
    ),
    InfoItem(
        title: "Curved Scissors",
        description: "Used to cut the skin barrier to fit the stoma if using a cut-to-size system.",
        modelName: "Scissors",
        categories: [.colostomy]
    ),
    InfoItem(
        title: "One-Piece Drainable Stoma Bag",
        description: "A combined pouch and barrier that collects output and can be emptied without removal.",
        modelName: "stomabag",
        categories: [.colostomy]
    ),
    InfoItem(
        title: "Modeling Paste/Barrier Ring",
        description: "Applied around the stoma to fill skin creases, prevent leaks, and protect skin.",
        modelName: "Ring",
        categories: [.colostomy]
    ),
    InfoItem(
        title: "Adhesive Spray/Remover",
        description: "Spray for better adhesion or to gently remove the barrier without skin irritation.",
        modelName: "AdhesiveRemover",
        categories: [.colostomy]
    ),
    InfoItem(
        title: "?",
        description: "?",
        modelName: "WasteBag",
        categories: [.colostomy]
    ),
    InfoItem(
        title: "?",
        description: "?",
        modelName: "WasteBag",
        categories: [.colostomy]
    ),
]
