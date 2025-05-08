/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
Descriptions of the video collections that the app presents.
*/

import SwiftUI

let colostomySteps = [Steps.first, Steps.second, Steps.third, Steps.fourth, Steps.fifth, Steps.sixth, Steps.seventh, Steps.eighth, Steps.ninth]

/// Descriptions of the video collections that the app presents.
enum Steps: Int, Equatable, Hashable, Identifiable, CaseIterable {
    case first
    case second
    case third
    case fourth
    case fifth
    case sixth
    case seventh
    case eighth
    case ninth
  
    var id: Int {
        switch self {
        case .first: 1
        case .second: 2
        case .third: 3
        case .fourth: 4
        case .fifth: 5
        case .sixth: 6
        case .seventh: 7
        case .eighth: 8
        case .ninth: 9
        }
    }
    
    var name: String {
        switch self {
        case .first: "Removing the pouch"
        case .second: "Cleaning the stoma"
        case .third: "Measuring your stoma"
        case .fourth: "Skin protection"
        case .fifth: "Applying the plate"
        case .sixth: "Frequency of changing the bag"
        case .seventh: "Check for odors"
        case .eighth: "Recognize complications"
        case .ninth: "Hand hygiene"
        }
    }
    
    var dialogues: [String] {
        switch self {
        case .first: ["Let's start with the first step: bag removal.",
                      "First, let's go over all the materials you'll need: your new bag, cleaning wipes, and a disposal bag.",
                      "To remove your current bag, stretch your skin with one hand and gently peel the plaque from top to bottom.",
                      "This helps reduce discomfort and protects your skin from overstretching.",
                      "Many people wonder what the best way to remove the adhesive plaque from their skin is.",
                      "Let's see if you can answer this question..."]
        case .second: ["Only warm water or saline", "Scented or antibacterial soaps"]
        case .third: ["29–30 mm, to leave a minimal margin", "25 mm, so it grips better and prevents leakage"]
        case .fourth: ["Modeling paste or barrier ring", "No aid, it sticks anyway "]
        case .fifth: ["At least 1-2 minutes", "No time, it sticks on its own"]
        case .sixth: ["Every 3-5 days or as directed by a professional", "Several times a day, as soon as it feels uncomfortable"]
        case .seventh: ["Check the fit and decide whether to replace it", "Spray perfume on the pouch"]
        case .eighth: ["Contact the stoma nurse", "Ignore it, it's normal"]
        case .ninth: ["Before and after each procedure", "Only at the end"]
        }
    }
    
    
    var question: String {
        switch self {
        case .first: "What is best to use to make plaque removal easier?"
        case .second: "What is best to clean the skin around the stoma?"
        case .third: "Your stoma measures 28 mm. How big do you cut the hole in the adhesive?"
        case .fourth: "You have an irregular peristomal area. What do you use?"
        case .fifth: "How long should you hold the plate down for good adhesion?"
        case .sixth: "How often is it recommended to change the bag/system?"
        case .seventh: "You notice a bad smell from your pouch. What do you do?"
        case .eighth: "You notice redness, itching, or pain around your stoma. What do you do?"
        case .ninth: "When do you wash your hands during the procedure?"
        }
    }
    
    var answers: [String] {
        switch self {
        case .first: ["A spray remover or an adhesive wipe", "Pulling the plaque directly with your hands"]
        case .second: ["Only warm water or saline", "Scented or antibacterial soaps"]
        case .third: ["29–30 mm, to leave a minimal margin", "25 mm, so it grips better and prevents leakage"]
        case .fourth: ["Modeling paste or barrier ring", "No aid, it sticks anyway "]
        case .fifth: ["At least 1-2 minutes", "No time, it sticks on its own"]
        case .sixth: ["Every 3-5 days or as directed by a professional", "Several times a day, as soon as it feels uncomfortable"]
        case .seventh: ["Check the fit and decide whether to replace it", "Spray perfume on the pouch"]
        case .eighth: ["Contact the stoma nurse", "Ignore it, it's normal"]
        case .ninth: ["Before and after each procedure", "Only at the end"]
        }
    }
    
    var explanation: [String] {
        switch self {
        case .first: ["Exactly!",
                      "Using a spray remover or an adhesive wipe is much gentler on the skin.",
                      "These products dissolve the adhesive, making it easier to remove without causing trauma to the skin.",
                      "Pulling directly can damage the skin and cause pain or irritation.",
                      "A spray remover dissolves the adhesive gently, protecting the skin.",
                      "It's a small measure that can make a big difference in your daily comfort."
        ]
        case .second: ["Great!",
                       "Warm water or saline is all you need. Warm water is sufficient for effective and gentle cleaning.",
                       "Soaps, especially scented or antibacterial soaps, can leave residue on the skin that interferes with the adhesion of the plate and can cause irritation.",
                       "A practical tip: use soft gauze or non-abrasive tissues for cleaning.",
                       "Pat gently instead of scrubbing, and be sure to dry the skin thoroughly before applying the new plate.",
                       "Dry skin ensures better adhesion of the system."
        ]
        case .third: ["You answered correctly!",
                      "If your stoma measures 28 mm, the hole in the baseplate should be 29–30 mm, leaving only a small margin of 1–2 mm around the stoma.",
                      "It is a common misconception that a smaller hole will prevent leakage, but in reality it can damage the stoma, causing ulcers or circulatory problems.",
                      "On the other hand, a hole that is too large will leave too much skin exposed to secretions, causing irritation.",
                      "Remember that accurate measurement is key to optimal comfort and to preventing skin problems.",
                      "If you have difficulty measuring your stoma yourself, do not hesitate to ask a family member for help or contact your stoma care nurse."
        ]
        case .fourth: ["That's right!",
                       "Modeling paste or barrier ring are invaluable tools for creating a uniform surface.",
                       "These products fill in irregularities in the skin, creating a smooth base for the plate to adhere to and preventing leaks.",
                       "Modeling paste is applied directly to folds or depressions and should be left to dry for a few minutes before applying the plate.", 
                       "The barrier ring, on the other hand, can be modeled with your fingers to perfectly fit the shape of your stoma.",
                       "A tip: if you use modeling paste, slightly moisten your fingers with water to prevent the paste from sticking to your hands during application."
        ]
        case .fifth: ["Perfect!",
                      "Maintaining pressure on the plate for at least 1-2 minutes is essential to activate the adhesive and ensure an optimal hold.",
                      "The warmth of your hand helps the adhesive to blend better with the skin.",
                      "An extra tip: gently massage from the inside out of the plate, following a circular motion.",
                      "This helps eliminate any air bubbles and further improves adhesion.",
                      "Don't be afraid to press firmly, the system is designed to withstand this pressure."
        ]
        case .sixth: ["That's right!",
                      "Most systems can stay in place for 3-5 days.",
                      "Changing the system too frequently can irritate the skin, while waiting too long can cause leaks and irritation due to degradation of the adhesive.",
                      "Learn to recognize the signs that a change is needed: an itchy feeling under the plate, visible deterioration of the adhesive at the edges, or the feeling that the system is about to fall off.",
                      "Every person is different, so over time you will find your own rhythm.",
                      "Keep a journal in the early days to identify your own pattern, noting when the system is changed and if there have been any leaks or problems."]
        case .seventh: ["Exactly!",
                        "If you notice an unusual odor, the first thing to do is check that the system is well sealed.",
                        "An odor could indicate a leak or the need to change the pouch.",
                        "Never use perfume directly on the pouch or the skin around the stoma.",
                        "This can irritate the skin and mask a more serious problem that needs attention.",
                        "There are stoma deodorants that can be put in the pouch.",
                        "Also, some foods can affect the smell of stool, such as garlic, onion, some cheeses, or spices.",
                        "Tracking your diet can help you identify which foods may be causing stronger odors."]
        case .eighth: ["Great answer!",
                       "Never ignore signs such as redness, itching, or pain around the stoma.",
                       "These could be signs of dermatitis, material allergies, or a fungal infection.",
                       "Always contact your stoma nurse if you notice these changes.",
                       "Skin complications, if treated early, are usually easy to resolve.",
                       "But if ignored, they can get worse and require more intensive treatment.",
                       "Take a photo of the problem areas before contacting the nurse.",
                       "This can help better assess the situation, especially if you can't get to the office right away."]
        case .ninth: ["Great!",
                      "Thoroughly washing your hands both before and after each procedure is essential.",
                      "Before the procedure, washing prevents the introduction of bacteria into the peristomal area.",
                      "After the procedure, it prevents the spread of bacteria to other body parts or surfaces.",
                      "Use warm water and soap, rubbing for at least 20 seconds.",
                      "If you don't have access to soap and water, an alcohol-based hand sanitizer is an acceptable alternative.",
                      "Also remember to keep your nails short and clean when caring for your stoma, to further reduce the risk of scratching or infection."]
        }
    }
}
