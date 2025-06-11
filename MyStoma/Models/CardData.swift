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
    var disabledSection: Bool
    
    
    init(
        type: String,
        title: LocalizedStringResource,
        subtitle: LocalizedStringResource,
        imageName: String,
        imageModal: String,
        description: LocalizedStringResource,
        navView: AnyView? = nil,
        quote: LocalizedStringResource? = nil,
        disabledSection: Bool = false
    ) {
        self.type = type
        self.title = title
        self.subtitle = subtitle
        self.imageName = imageName
        self.imageModal = imageModal
        self.description = description
        self.navView = navView
        self.quote = quote
        self.disabledSection = disabledSection
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
            description: "In this section you will learn what a colostomy is, how it works and what aspects are important to know in daily life. \n\nA **colostomy** is a surgical opening on the abdomen, called a **stoma**, that allows feces to exit the colon to the outside of the body, where they are collected in a special adhesive bag. \n\nIt can be temporary or permanent, depending on the clinical condition. The feces no longer pass through the anus but through the stoma, into a bag. \n\nNow that you have a basic understanding, you're ready to begin. \n\n**Let's start this journey together!**",
            navView: AnyView(ColostomyView()),
            disabledSection: false
        ),
        /*CardData(
            type: "content",
            title: "Ileostomy",
            subtitle: "SMALL INTESTINE STOMA",
            imageName: "ileostomia2",
            imageModal: "Untitled_Artwork 2",
            description: "Coming Soon!",
            disabledSection: true
                        "In this section you will learn what an ileostomy is, how it functions and what you need to know for your daily routine. \n\nAn ileostomy is a surgically created opening in the abdomen, called a stoma, that diverts the flow of intestinal waste from the small intestine directly to the outside of the body, where it is collected in a specialized adhesive pouch. \n\nThis procedure can be either temporary or permanent, based on your specific medical needs. The waste no longer travels through the large intestine and rectum but exits through the stoma into a collection bag. Because the output comes from the small intestine, it tends to be more liquid and frequent than other types of ostomies. \n\nNow that you have a basic understanding, you're ready to begin. \n\nClick on the buttons and let's start this journey together!"
        ),
        CardData(
            type: "content",
            title: "Urostomy",
            subtitle: "BLADDER STOMA",
            imageName: "urostomia2",
            imageModal: "Untitled_Artwork 3",
            description: "Coming Soon!",
            disabledSection: true
                           "In this section you will learn what a urostomy is, how it functions and what you need to know for managing it in your daily life. \n\nA urostomy is a surgically created opening in the abdomen, called a stoma, that redirects urine from the kidneys directly to the outside of the body, where it is collected in a specialized adhesive pouch system. \n\nThis procedure is usually permanent and is performed when the bladder cannot function properly or needs to be removed. The urine no longer flows through the bladder but exits continuously through the stoma into a collection bag. Since urine production is constant, urostomy bags typically need to be emptied more frequently and often include a drainage tap for easy emptying. \n\nNow that you have a basic understanding, you're ready to begin. \n\nClick on the buttons and let's start this journey together!"
        )*/
    ]
    
    static let storyData: [CardData] = [
        CardData(
            type: "story",
            title: "A New Life Inside and Out",
            subtitle: "Patrizia Nazzarro",
            imageName: "story22",
            imageModal: "story2",
            description: """
*"There's this assumption that if you have a stoma you won't be able to have a baby,"* says Holly Fleet, 28, who faced pregnancy after an emergency ileostomy in 2021. 
The reality is very different: the vast majority of women with stomas can conceive and experience completely normal pregnancies. Stomas don't affect fertility, so conception occurs without additional problems.

**First Trimester: Managing Nausea**
During the first months, morning sickness requires specific strategies. Keep dry crackers and water always within reach to manage discomfort. 
It's preferable to change the collection system in the evening when nausea is less intense, and use smaller bags during the day for greater comfort. Hydration control becomes fundamental and requires regular medical monitoring.

**Second and Third Trimester: Physical Adaptations**
As the belly grows, stoma size may increase but will return to normal after delivery. Use more flexible baseplates that adapt to body changes and invest in support belts specific for pregnant ostomates. The stoma may disappear from view as the belly grows, so using a mirror becomes helpful. Apply barrier creams to protect more sensitive skin and document changes with photos to help the medical team.

**Delivery and Breastfeeding**
Most women deliver without stoma-related complications. It's essential to prepare extra hospital supplies and inform all healthcare staff about the stoma presence. 
During breastfeeding, experimenting with different positions helps find the most comfortable one. Often the side-lying position avoids pressure on the stoma while maintaining good baby latch.

Having a stoma is not an obstacle to motherhood. With proper preparation and medical support, every woman can fully experience pregnancy and parenthood, often discovering unexpected strength and resilience.
""",
            navView: AnyView(ColostomyView()),
            quote: "A stoma doesn't stop the rhythm of life — every woman can be a mother, strong and whole, just as she is."
        ),
        CardData(
            type: "story",
            title: "First Dive Into Hope",
            subtitle: "Patrizia Nazzarro",
            imageName: "story1",
            imageModal: "story1",
            description: """
Gill Castle, a 44-year-old woman living with an ileostomy since 2011, developed a structured approach to overcome the challenges of swimming with a stoma. After years of leaks, she found success using convex bags, which offered better adhesion and security. She trained gradually in the North Sea, increasing exposure to tough conditions.

On September 12, 2023, Gill swam solo across the English Channel in 13 hours and 53 minutes, covering 21 nautical miles. Her stoma appliance remained perfectly sealed, proving it’s possible to swim at high levels with the right preparation.

**Practical Tips for Swimming with a Stoma**
Use high-adhesion convex pouches. Apply a barrier spray or protective film 30 minutes before entering water. Change the pouch no more than 2 hours before activity to ensure optimal adhesion. For extra security, use a stoma support belt, especially for long sessions. Always inspect the wafer seal and carry a spare kit.

**Medical Guidelines and Cautions**
Wait at least 6–8 weeks post-surgery before swimming to allow full healing. Avoid highly chlorinated or dirty water that may irritate peristomal skin. Swimming is not advised during active skin infections, severe stenosis, or significant prolapse. Start with short 30-minute sessions, increasing gradually.

A stoma is not a barrier to aquatic sports. With proper equipment, planning, and gradual reintroduction, swimming remains safe and empowering. Gill Castle’s example proves that strength is not the absence of change, but the courage to face it and swim through it.
""",
            quote: "The sea had not abandoned me… it was I who had to learn to return to it."
            
        ),
        CardData(
            type: "story",
            title: "From Stoma Care to Clinics",
            subtitle: "Giuseppe Fama, Stomatherapist",
            imageName: "story33",
            imageModal: "story3",
            description: """
If you've just received a stoma, the specialized clinic becomes your primary ally. Here you'll find specialized nurses who guide you step by step toward independence. You're not alone in this journey: these centers exist specifically to support you in transitioning to normal life.

**When to Access the Service**
You can contact the clinic immediately after surgery, during the critical first month when the stoma changes shape and size, and for life whenever you need help. The service is open to all stoma patients, regardless of where you had your surgery.

**What You'll Learn**
During visits you'll learn daily management: perfect hygiene to keep skin healthy, when and how to change baseplates and pouches, which collection system suits you best. You'll learn to recognize and prevent problems like skin irritation, leaks from poor adhesion, stoma changes, and bowel blockages.

**The Support Team**
The stoma care nurse will be your main reference, but you can also access a gastroenterologist for digestive problems, nutritionist to adapt your diet, psychologist for free emotional support, and oncologist if needed.

**Warning Signs**
Contact the clinic immediately if the stoma becomes dark or black, you have severe continuous pain, haven't had a bowel movement for over 24 hours, have high fever with chills, or surrounding skin is very red and painful. Call within 24 hours for significant color changes, frequent leaks, persistent irritations, or urgent questions.
The stoma care clinic is your most important ally. Don't hesitate to use this service: it's made specifically for you and will help you discover that your stoma isn't an obstacle, but a solution to continue living life fully.
""",
            quote: "Everything You Need to Know About Getting Professional Support for Your Stoma Journey"
        )
    ]
}
