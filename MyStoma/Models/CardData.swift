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
            description: "In this section you will learn what a colostomy is, how it works and what aspects are important to know in daily life. \n\nA colostomy is a surgical opening on the abdomen, called a stoma, that allows feces to exit the colon to the outside of the body, where they are collected in a special adhesive bag. \n\nIt can be temporary or permanent, depending on the clinical condition. The feces no longer pass through the anus but through the stoma, into a bag. \n\nNow that you have a basic understanding, you're ready to begin. \n\nClick on the buttons and let's start this journey together!",
            navView: AnyView(ColostomyView()),
            disabledSection: false
        ),
        CardData(
            type: "content",
            title: "Ileostomy",
            subtitle: "SMALL INTESTINE STOMA",
            imageName: "ileostomia2",
            imageModal: "Untitled_Artwork 2",
            description: "Coming Soon!",
            disabledSection: true
         
//                "In this section you will learn what an ileostomy is, how it functions and what you need to know for your daily routine. \n\nAn ileostomy is a surgically created opening in the abdomen, called a stoma, that diverts the flow of intestinal waste from the small intestine directly to the outside of the body, where it is collected in a specialized adhesive pouch. \n\nThis procedure can be either temporary or permanent, based on your specific medical needs. The waste no longer travels through the large intestine and rectum but exits through the stoma into a collection bag. Because the output comes from the small intestine, it tends to be more liquid and frequent than other types of ostomies. \n\nNow that you have a basic understanding, you're ready to begin. \n\nClick on the buttons and let's start this journey together!"
        ),
        CardData(
            type: "content",
            title: "Urostomy",
            subtitle: "BLADDER STOMA",
            imageName: "urostomia2",
            imageModal: "Untitled_Artwork 3",
            description: "Coming Soon!",
            disabledSection: true
           
//                "In this section you will learn what a urostomy is, how it functions and what you need to know for managing it in your daily life. \n\nA urostomy is a surgically created opening in the abdomen, called a stoma, that redirects urine from the kidneys directly to the outside of the body, where it is collected in a specialized adhesive pouch system. \n\nThis procedure is usually permanent and is performed when the bladder cannot function properly or needs to be removed. The urine no longer flows through the bladder but exits continuously through the stoma into a collection bag. Since urine production is constant, urostomy bags typically need to be emptied more frequently and often include a drainage tap for easy emptying. \n\nNow that you have a basic understanding, you're ready to begin. \n\nClick on the buttons and let's start this journey together!"
        )
    ]
    
    static let storyData: [CardData] = [
        CardData(
            type: "story",
            title: "One Stoma, Two Miracles",
            subtitle: "Patrizia Nazzarro",
            imageName: "NurseLeft",
            imageModal: "NurseLeft",
            description: """
Elena was 28 when she was diagnosed with inflammatory bowel disease that required an ileostomy. Two years later, she and her husband Marco decided to try for a baby. "I was terrified at first," Elena says. "I thought the stoma would keep me from being a normal mother."

**The Discovery of Pregnancy**  
When Elena found out she was pregnant, her first thought was about her stoma. "I rushed to my stoma doctor," she recalls with a smile. "I needed to know what to expect for the next nine months."

**First Trimester: Adjustment and Nausea**  
During the first few months, Elena had to deal with the classic morning sickness, complicated by the management of the stoma.

*Practical advice from the first trimester:*
- Always keep dry crackers and water on hand to manage nausea  
- Switch your collection system in the evening, when nausea is less intense  
- Use smaller bags during the day for greater comfort  
- Check with your medical team regularly to monitor hydration

**Second Trimester: Growth and Adjustments**  
As her belly grew, Elena began to notice changes in the position of her stoma. "My stoma doctor explained to me that this was normal," she says. "The skin was stretching and the stoma was moving slightly."

*Practical advice from the second trimester:*
- Use more flexible bases that adapt to the changes in the body  
- Invest in support belts specifically for ostomates during pregnancy  
- Apply barrier creams to protect more sensitive skin  
- Document changes with photos to help your medical team

**Third Trimester: Preparing for Birth**  
In the last few months, Elena prepared for birth with a focus on stoma care. "I prepared a special hospital bag with all the necessary supplies," she explains.

*Practical tips for the third trimester and birth:*
- Prepare an extra supply of hospital supplies (pads, bags, accessories)  
- Inform all hospital staff that you have a stoma  
- Choose a hospital with experience in managing ostomy patients  
- Position the bag so that it does not interfere with fetal monitoring

**Birth and Beyond**  
Elena gave birth to little Sofia naturally without any complications. "During labor, the stoma did not cause any problems," she says excitedly. "On the contrary, the medical staff were very knowledgeable and made me feel completely at ease."

**Breastfeeding and New Life**  
After giving birth, Elena was able to breastfeed without difficulty. "The best position for me was lying on my side," she explains. "That way I avoided pressure on the stoma and Sofia was able to latch on well."

*Practical breastfeeding tips:*
- Experiment with different positions to find the most comfortable one  
- Use support pillows to avoid pressure on the stoma  
- Stay well hydrated to support milk production  
- Do not hesitate to seek help from experienced lactation consultants

**Final Thoughts**  
Today Sofia is three years old and Elena is pregnant with her second child. "My stoma has never stopped me from being the mother I wanted to be," Elena concludes. "In fact, it has taught me to be stronger and more resilient. My children will grow up knowing that diversity is normal and that love knows no obstacles."
""",
            navView: AnyView(ColostomyView()),
            quote: "My stoma is a constant reminder of what I’ve lost. But it’s also a symbol of my strength."
        ),
        CardData(
            type: "story",
            title: "First Dive Into Hope",
            subtitle: "Patrizia Nazzarro",
            imageName: "NurseLeft",
            imageModal: "NurseLeft",
            description: """
When Luca discovered he had to live with a stoma, the world seemed to stop. He had just experienced one of the most intense moments of his life — the birth of his first child — and immediately afterwards he found himself facing a new, completely unexpected reality. A stoma. A difficult word, a radical change, a wound that seemed to be more of a wound to the soul than to the body.

"I thought my active life was over," he says today. And yet, what seemed like a limitation has turned into one of the greatest — and most beautiful — challenges of his life.

**Accept, Understand, Start Over**  
At the beginning, like many, there were moments of fear and uncertainty:

- How will I dress?  
- Will I be able to swim, go to the beach?  
- Will people notice?  
- Will I be able to hug my son without fear?  

Over time, Luca has learned that a stoma is not the end, but a new beginning. It is not a sign of weakness, but a demonstration of survival and adaptation. With the right medical support, good nursing guidance and a lot of inner strength, he has discovered that life can be lived to the fullest, even with a bag.

**Technique, Routine and Freedom**  
Luca has learned to manage his stoma day after day. Here are some of the tips he has made his own and that he shares with those who are starting this journey:

-  Choose the right bag for you. There are different types: one-piece, two-piece, with filter, transparent or opaque. Your stoma nurse will help you find the one that best suits your lifestyle.  
-  Prepare a kit to always carry with you. A small beauty case with a spare bag, wipes, plasters, scissors, and a bag for waste. It makes you feel more secure wherever you are.  
-  Respect your skin. Use delicate products for cleaning and, if necessary, protective barriers to avoid irritation.  
-  Be patient with yourself. The first changes may seem complicated, but with practice they will become routine.  
-  Move. Live. Train. After talking to his doctor, Luca gradually returned to the pool. With a wetsuit and waterproof devices, he discovered that he could still swim, just like before. Better than before.  
-  Face fears with words. Talk about them with those close to you. Often, fear is more in our heads than in the eyes of others.

**The English Channel Feat**  
Three years after his operation, Luca swam across the English Channel. Almost 14 hours in freezing water, without being able to stop.  
"Every stroke was a way of saying: I am not just my body. I am my strength, my will, my desire to live."  
That day, on the French coast, not just an athlete arrived. A new, rebuilt man arrived.

**Support That Makes a Difference**  
Luca has now founded an association that helps those who live with a stoma, offers advice, tells true stories, distributes guides and proposes group and sports meetings.  
He has created a network that unites those who have already done this journey with those who are starting now.

_Remember: you are not alone._  
Every day, thousands of people live, work, love, travel, play sports, and enjoy life with a stoma.

**Luca's Message**  
"We are not broken. We are rebuilt. And often, stronger than before."

 **First Steps for You**

1. Trust your stoma therapist. He will guide you through the most delicate days and teach you specific techniques.  
2. Inform those close to you. Even a little support can make a big difference.  
3. Find your routine. After a few weeks, management will become automatic.  
4. Don't give up on what you love. Ask how to adapt, but don't stop dreaming.  
5. Join a patient network. Sharing experiences is the best medicine for the soul.
""",
            quote: "The sea had not abandoned me… it was I who had to learn to return to it."
            
        ),
        CardData(
            type: "story",
            title: "From Stoma Care to Clinics",
            subtitle: "Giuseppe Fama, Stomatherapist",
            imageName: "NurseLeft",
            imageModal: "NurseLeft",
            description: """
If you’ve just had a stoma or are preparing for surgery, you might feel overwhelmed and unsure where to turn. That’s where the stoma care clinic comes in. It’s a specialized service led by trained stoma care nurses who will guide you step by step, helping you adjust, learn, and regain your independence.

Support begins right after surgery, often while you're still in the hospital. But the real journey starts after you're home, especially in the first month, when your stoma changes shape and you face many new challenges. These clinics welcome everyone, even if your surgery was done elsewhere, and they're there for you for life.

In follow up visits, you’ll learn how to care for your stoma daily, keeping your skin healthy, changing appliances correctly, and choosing the right products. You'll also learn how to spot and manage problems like leaks, irritation, or changes in your stoma.

You won’t be alone. Alongside the nurse, specialists like gastroenterologists, nutritionists, psychologists, or oncologists may support your care.

If anything feels wrong, pain, color changes, or fever, don’t wait. The clinic is your lifeline. It's not just a medical service, but a key part of living well with a stoma.
""",
            quote: "Everything You Need to Know About Getting Professional Support for Your Stoma Journey"
        )
    ]
}
