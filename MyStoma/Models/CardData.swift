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
            navView: AnyView(ColostomyView()),
            description: "A colostomy is a type of bowel stoma where part of the colon (large intestine) is brought out through the abdominal wall to allow stool to pass out of the body. \"Colostomy\" comes from \"colon\" and \"stoma\" (opening or mouth). \n\nTypes of colostomy \n*Temporary: to give time for a section of bowel to heal after surgery, trauma, or inflammation.\n*Permanent: when it's not possible to reconnect the bowel after resection.\n\nStoma location \nColostomies can be placed at different points in the colon, affecting stool consistency: \n*Ascending colostomy: liquid stool; less common. \n*Transverse colostomy: semi-formed stool; can be temporary or permanent. \n*Descending or sigmoid colostomy: formed or solid stool; most common and easier to manage. \n\nAppearance and management \nThe stoma looks red and moist, and has no nerve endings (so it's not painful to touch). \nStool is collected in a pouching system, which can be: \nClosed (for formed stool) \nDrainable (for liquid or semi-liquid stool) \nIt is important to protect the peristomal skin (the skin around the stoma) to avoid irritation. \n\nIn this section we are going to learn how to take change and take care of our colostomy!"
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
