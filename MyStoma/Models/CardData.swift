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
            description: "In this section you will learn what a colostomy is, how it works and what aspects are important to know in daily life. A colostomy is a surgical opening on the abdomen, called a stoma, that allows feces to exit the colon to the outside of the body, where they are collected in a special adhesive bag. It can be temporary or permanent, depending on the clinical condition. The feces no longer pass through the anus but through the stoma, into a bag. Now that you have a basic understanding, you're ready to begin. Click on the buttons and let's start this journey together!",
            navView: AnyView(ColostomyView())
        ),
        CardData(
            type: "content",
            title: "Ileostomy",
            subtitle: "SMALL INTESTINE STOMA",
            imageName: "Ileostomia",
            imageModal: "Untitled_Artwork 2",
            description: "In this section you will learn what an ileostomy is, how it functions and what you need to know for your daily routine. An ileostomy is a surgically created opening in the abdomen, called a stoma, that diverts the flow of intestinal waste from the small intestine directly to the outside of the body, where it is collected in a specialized adhesive pouch. This procedure can be either temporary or permanent, based on your specific medical needs. The waste no longer travels through the large intestine and rectum but exits through the stoma into a collection bag. Because the output comes from the small intestine, it tends to be more liquid and frequent than other types of ostomies. Now that you have a basic understanding, you're ready to begin. Click on the buttons and let's start this journey together!"
        ),
        CardData(
            type: "content",
            title: "Urostomy",
            subtitle: "BLADDER STOMA",
            imageName: "Urostomia",
            imageModal: "Untitled_Artwork 3",
            description: "In this section you will learn what a urostomy is, how it functions and what you need to know for managing it in your daily life. A urostomy is a surgically created opening in the abdomen, called a stoma, that redirects urine from the kidneys directly to the outside of the body, where it is collected in a specialized adhesive pouch system. This procedure is usually permanent and is performed when the bladder cannot function properly or needs to be removed. The urine no longer flows through the bladder but exits continuously through the stoma into a collection bag. Since urine production is constant, urostomy bags typically need to be emptied more frequently and often include a drainage tap for easy emptying. Now that you have a basic understanding, you're ready to begin. Click on the buttons and let's start this journey together!"
        )
    ]
    
    static let storyData: [CardData] = [
        CardData(
            type: "story",
            title: "Living with a Stoma",
            subtitle: "Martha Mendoza",
            imageName: "NurseLeft",
            imageModal: "NurseLeft",
            description: "After my surgery, I thought my life was over. The stoma bag felt like a punishment. But little by little, I learned tricks—like how to wear loose tops, or plan ahead when going out. One day, my bag popped in the middle of a date. I panicked, but he just laughed and helped me clean up. That’s when I realized: this thing doesn’t define me. I’m still me—funny, kind, and strong. And honestly? I’ve never felt more alive.",
            navView: AnyView(ColostomyView()),
            quote: "My stoma is a constant reminder of what I’ve lost. But it’s also a symbol of my strength."
        ),
        CardData(
            type: "story",
            title: "Feeling Invisible",
            subtitle: "Anna Paola",
            imageName: "NurseLeft",
            imageModal: "NurseLeft",
            description: "At first, no one looked me in the eye. I felt like I’d disappeared after getting my ileostomy. I stopped going out, even to the park. Then one day, I picked up a paintbrush and started painting how I felt—blurry, grey, hidden. But slowly, color returned to my canvas, and to me. A gallery offered to show my art. At the opening, someone said, “Your work made me feel seen.” That’s when I knew: I’m not invisible. I just had to find new ways to be visible.",
            quote: "I had difficulties everyday, but it seemed that for the rest of the world I was still the same."
            
        ),
        CardData(
            type: "story",
            title: "Keep Doing Sports",
            subtitle: "Francesco Pogliare",
            imageName: "NurseLeft",
            imageModal: "NurseLeft",
            description: "Soccer was my life, and after my urostomy, I thought it was gone. I was scared to move too much, to get tackled, to leak. But my coach said, “Come back. We’ll figure it out.” I trained slow. I tried different bags. The first match back, I was terrified. Then I scored. My team lifted me in the air, and I cried like a baby. I still have my urostomy, but now I also have my confidence, my team, and my game back.",
            quote: "I couldn't let my urostomy change my love for sports and change who I am."
        )
    ]
}
