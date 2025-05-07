/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
Descriptions of the video collections that the app presents.
*/

import SwiftUI

let listSteps = [Steps.first, Steps.second, Steps.third, Steps.fourth, Steps.fifth, Steps.sixth, Steps.seventh, Steps.eighth, Steps.ninth]

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
    
    var explanation: String {
        switch self {
        case .first: "Pulling directly can damage the skin and cause pain or irritation. A spray remover dissolves the adhesive gently, protecting the skin."
        case .second: "Soaps contain substances that can leave residue and irritate the skin or reduce the adhesion of the plaque. Warm water is sufficient for effective and gentle cleaning."
        case .third: "People often think a tighter fit is safer. But cutting the hole too small can compress the stoma, causing ulcers or circulation issues. The adhesive should adhere as closely to the skin as possible, leaving only 1-2 mm of tolerance. A hole that is too large leaves the skin exposed to waste, causing irritation."
        case .fourth: "The paste or ring fills in folds and depressions, ensuring a better hold and preventing leaks."
        case .fifth: "Applying pressure helps activate the adhesive and ensures better adhesion to the skin."
        case .sixth: "Changing too often can irritate the skin. It is important to follow a regular schedule, also considering the type of bag and the patient's needs."
        case .seventh: "Perfume can irritate your skin and mask a serious problem. An unusual odor may indicate a leak or the need to change it."
        case .eighth: "The peristomal skin should be monitored. Signs of irritation can worsen without timely intervention."
        case .ninth: "Proper hand hygiene is essential to prevent infections and ensure patient safety."
        }
    }
}
