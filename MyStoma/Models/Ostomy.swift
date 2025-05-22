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
