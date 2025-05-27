import SwiftUI

struct CardData: Identifiable {
    let id = UUID()
    let type: String
    let title: LocalizedStringResource
    let subtitle: LocalizedStringResource
    let imageName: String
    let imageModal: String
    let description: LocalizedStringResource
    var navView: AnyView?
    let quote: LocalizedStringResource?
    
    
    init(
        type: String,
        title: LocalizedStringResource,
        subtitle: LocalizedStringResource,
        imageName: String,
        imageModal: String,
        description: LocalizedStringResource,
        navView: AnyView? = nil,
        quote: LocalizedStringResource? = nil
    ) {
        self.type = type
        self.title = title
        self.subtitle = subtitle
        self.imageName = imageName
        self.imageModal = imageModal
        self.description = description
        self.navView = navView
        self.quote = quote
    }

}

extension CardData {
    static let sampleData: [CardData] = [
        CardData(
            type: "content",
            title: "Colostomy",
            subtitle: "COLON STOMA",
            imageName: "Colostomia",
            imageModal: "Untitled_Artwork",
            description: "A colostomy brings part of the colon to the surface of the belly to pass stool. The stool is usually formed or semi-formed, depending on where the stoma is placed. A closed or drainable bag collects it. The stoma is red and moist but doesn’t hurt to touch.",
            navView: AnyView(ColostomyView())
        ),
        CardData(
            type: "content",
            title: "Ileostomy",
            subtitle: "SMALL INTESTINE STOMA",
            imageName: "Ileostomia",
            imageModal: "Untitled_Artwork 2",
            description: "An ileostomy brings the end of the small intestine through the belly. The stool is more liquid and comes out often. It needs a drainable pouch. It’s usually needed when the colon can’t be used."
        ),
        CardData(
            type: "content",
            title: "Urostomy",
            subtitle: "BLADDER STOMA",
            imageName: "Urostomia",
            imageModal: "Untitled_Artwork 3",
            description: "A urostomy helps urine exit the body through a stoma made from a small piece of intestine. Urine flows into a drainable bag. It’s needed when the bladder is damaged or removed."
        )
    ]
    
    static let storyData: [CardData] = [
        CardData(
            type: "story",
            title: "Living with a Stoma",
            subtitle: "Martha Mendoza",
            imageName: "NurseLeft",
            imageModal: "Untitled_Artwork 3",
            description: "After my surgery, I thought my life was over. The stoma bag felt like a punishment. But little by little, I learned tricks—like how to wear loose tops, or plan ahead when going out. One day, my bag popped in the middle of a date. I panicked, but he just laughed and helped me clean up. That’s when I realized: this thing doesn’t define me. I’m still me—funny, kind, and strong. And honestly? I’ve never felt more alive.",
            navView: AnyView(ColostomyView()),
            quote: "My stoma is a constant reminder of what I’ve lost. But it’s also a symbol of my strength."
        ),
        CardData(
            type: "story",
            title: "Feeling Invisible",
            subtitle: "Anna Paola",
            imageName: "NurseLeft",
            imageModal: "Untitled_Artwork 3",
            description: "At first, no one looked me in the eye. I felt like I’d disappeared after getting my ileostomy. I stopped going out, even to the park. Then one day, I picked up a paintbrush and started painting how I felt—blurry, grey, hidden. But slowly, color returned to my canvas, and to me. A gallery offered to show my art. At the opening, someone said, “Your work made me feel seen.” That’s when I knew: I’m not invisible. I just had to find new ways to be visible.",
            quote: "I had difficulties everyday, but it seemed that for the rest of the world I was still the same."
            
        ),
        CardData(
            type: "story",
            title: "Keep Doing Sports",
            subtitle: "Francesco Pogliare",
            imageName: "NurseLeft",
            imageModal: "Untitled_Artwork 3",
            description: "Soccer was my life, and after my urostomy, I thought it was gone. I was scared to move too much, to get tackled, to leak. But my coach said, “Come back. We’ll figure it out.” I trained slow. I tried different bags. The first match back, I was terrified. Then I scored. My team lifted me in the air, and I cried like a baby. I still have my urostomy, but now I also have my confidence, my team, and my game back.",
            quote: "I couldn't let my urostomy change my love for sports and change who I am."
        )
    ]
}
