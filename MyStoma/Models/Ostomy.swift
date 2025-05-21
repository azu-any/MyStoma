/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
Descriptions of the video collections that the app presents.
*/

import SwiftUI

struct Ostomy: Codable {
    var name: String
    var steps: [Step]
    var scene: String
    
    init(name: String, steps: [Step], scene: String) {
        self.name = name
        self.steps = steps
        self.scene = scene
    }
}

enum ColostomySpace {
    case first
    case second
    case third
    case fourth
    case fifth
    case sixth
    case seventh
    case eighth
    case ninth
    
    
    var id: String {
        switch self {
        case .first: "ColostomyFirstSpace"
        case .second: "ColostomySecondSpace"
        case .third: "ColostomyThirdSpace"
        case .fourth: "ColostomyFourthSpace"
        case .fifth: "ColostomyFifthSpace"
        case .sixth: "ColostomySixthSpace"
        case .seventh: "ColostomySeventhSpace"
        case .eighth: "ColostomyEighthSpace"
        case .ninth: "ColostomyNinthSpace"
        }
    }
}


let  ColostomySpaces = [ColostomySpace.first, ColostomySpace.second]

let defaultOstomy = Ostomy(
    name: "Default Ostomy",
    steps: [
        Step(
            id: 1,
            name: "Welcome Step",
            dialogues: ["Welcome to the tutorial."],
            question: "Are you ready to begin?",
            answers: ["Yes", "No"],
            timeQuestion: 1
        )
    ],
    scene: "DefaultScene"
)
