import SwiftUI

struct CardData: Identifiable {
    var id = UUID()
    var title: String
    var subtitle: String
    var imageName: String
    var imageModal: String
    var navView: AnyView?
    let description: String
}

extension CardData {
    static let sampleData: [CardData] = [
        CardData(
            title: "Colostomy",
            subtitle: "COLON STOMA",
            imageName: "Colostomy",
            imageModal: "Untitled_Artwork",
            navView: AnyView(ColostomyView()),
            description: "A colostomy brings part of the colon to the surface of the belly to pass stool. The stool is usually formed or semi-formed, depending on where the stoma is placed. A closed or drainable bag collects it. The stoma is red and moist but doesn’t hurt to touch."
        ),
        CardData(
            title: "Ileostomy",
            subtitle: "SMALL INTESTINE STOMA",
            imageName: "Ileostomy",
            imageModal: "Untitled_Artwork 2",
            description: "An ileostomy brings the end of the small intestine through the belly. The stool is more liquid and comes out often. It needs a drainable pouch. It’s usually needed when the colon can’t be used."
        ),
        CardData(
            title: "Urostomy",
            subtitle: "BLADDER STOMA",
            imageName: "Urostomy",
            imageModal: "Untitled_Artwork 3",
            description: "A urostomy helps urine exit the body through a stoma made from a small piece of intestine. Urine flows into a drainable bag. It’s needed when the bladder is damaged or removed."
        )
    ]
    
    static let storyData: [CardData] = [
        CardData(
            title: "Living with a Stoma",
            subtitle: "BY MARTHA MENDOZA",
            imageName: "Untitled_Artwork",
            imageModal: "Untitled_Artwork 3",
            navView: AnyView(ColostomyView()),
            description: "After my surgery, I thought my life was over. The stoma bag felt like a punishment. But little by little, I learned tricks—like how to wear loose tops, or plan ahead when going out. One day, my bag popped in the middle of a date. I panicked, but he just laughed and helped me clean up. That’s when I realized: this thing doesn’t define me. I’m still me—funny, kind, and strong. And honestly? I’ve never felt more alive."
        ),
        CardData(
            title: "Feeling Invisible",
            subtitle: "BY ANNA PAOLA",
            imageName: "Untitled_Artwork 2",
            imageModal: "Untitled_Artwork 3",
            description: "At first, no one looked me in the eye. I felt like I’d disappeared after getting my ileostomy. I stopped going out, even to the park. Then one day, I picked up a paintbrush and started painting how I felt—blurry, grey, hidden. But slowly, color returned to my canvas, and to me. A gallery offered to show my art. At the opening, someone said, “Your work made me feel seen.” That’s when I knew: I’m not invisible. I just had to find new ways to be visible."
        ),
        CardData(
            title: "Keep Doing Sports",
            subtitle: "BY FRANCESCO POGLIARE",
            imageName: "Untitled_Artwork 3",
            imageModal: "Untitled_Artwork 3",
            description: "Soccer was my life, and after my urostomy, I thought it was gone. I was scared to move too much, to get tackled, to leak. But my coach said, “Come back. We’ll figure it out.” I trained slow. I tried different bags. The first match back, I was terrified. Then I scored. My team lifted me in the air, and I cried like a baby. I still have my urostomy, but now I also have my confidence, my team, and my game back."
        )
    ]
}
