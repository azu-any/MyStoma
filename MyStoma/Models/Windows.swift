/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
Descriptions of the video collections that the app presents.
*/

import SwiftUI

/// Descriptions of the video collections that the app presents.
enum Windows: Int, Equatable, Hashable, Identifiable, CaseIterable {
    case menu = 1000
    case model = 1001
    case info = 1002
    case materials = 1003
  
    
    var id: String {
        switch self {
        case .menu: "Menu"
        case .model: "Model"
        case .info: "Info"
        case .materials: "Materials"
        }
    }
}
