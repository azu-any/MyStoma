/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
Descriptions of the video collections that the app presents.
*/

import SwiftUI

struct Step: Codable, Identifiable {
    var id: Int
    var name: String
    var dialogues: [String]
    var question: String
    var answers: [String]
    var timeQuestion: Int
    var timePractice: Int
    
    init(id: Int, name: String, dialogues: [String], question: String, answers: [String], timeQuestion: Int, timePractice: Int) {
        self.id = id
        self.name = name
        self.dialogues = dialogues
        self.question = question
        self.answers = answers
        self.timeQuestion = timeQuestion
        self.timePractice = timePractice
    }
    
}
