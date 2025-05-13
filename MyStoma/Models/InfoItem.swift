import SwiftUI

struct InfoItem: Identifiable, Equatable {
    let id = UUID()
    let title: String
    let description: String
}
