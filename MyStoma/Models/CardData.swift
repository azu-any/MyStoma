import SwiftUI

struct CardData: Identifiable {
    var id = UUID()
    var title: String
    var subtitle: String
    var imageName: String
    var navView: AnyView?
    let description: String
}

extension CardData {
    static let sampleData: [CardData] = [
        CardData(
            title: "Colostomy",
            subtitle: "Colon stoma",
            imageName: "Untitled_Artwork",
            description: "This procedure involves creating a stoma by bringing the colon to the surface of the abdomen. It allows waste to be diverted outside of the body, often in cases of bowel disease or injury."
        ),
        CardData(
            title: "Ileostomy",
            subtitle: "Small intestine",
            imageName: "Untitled_Artwork 2",
            description: "An ileostomy is a surgical opening constructed by bringing the end or loop of the small intestine (the ileum) out onto the surface of the skin. It allows waste to exit the body bypassing the colon."
        ),
        CardData(
            title: "Urostomy",
            subtitle: "Bladder",
            imageName: "Untitled_Artwork 3",
            description: "A urostomy is a surgical procedure that creates an opening for the urinary system to divert urine away from a diseased or damaged bladder."
        )
    ]
}
