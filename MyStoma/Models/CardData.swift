import SwiftUI

struct CardData: Identifiable {
    let id = UUID()
    let title: LocalizedStringResource
    let subtitle: LocalizedStringResource
    let imageName: String
    let description: LocalizedStringResource
}

extension CardData {
    static let sampleData: [CardData] = [
        CardData(
            title: "colostomy_title",
            subtitle: "colostomy_subtitle",
            imageName: "Untitled_Artwork",
            description: "colostomy_description"
        ),
        CardData(
            title: "ileostomy_title",
            subtitle: "ileostomy_subtitle",
            imageName: "Untitled_Artwork 2",
            description: "ileostomy_description"
        ),
        CardData(
            title: "urostomy_title",
            subtitle: "urostomy_subtitle",
            imageName: "Untitled_Artwork 3",
            description: "urostomy_description"
        )
    ]
}
