/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
Descriptions of the video collections that the app presents.
*/

import SwiftUI

final class Ostomy: Identifiable {
    var id = UUID()
    var name: String
    var steps: [Step]
    var scene: String
    
    init(name: String, steps: [Step], scene: String) {
        self.name = name
        self.steps = steps
        self.scene = scene
    }
}
