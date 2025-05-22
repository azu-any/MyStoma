import Foundation
import SwiftUI

struct MenuCaroussel: View {
    let data: [CardData] = [
        CardData(title: "Colostomy", subtitle: "Colon stoma", imageName: "Untitled_Artwork"),
        CardData(title: "Ileostomy", subtitle: "Small intestine", imageName: "Untitled_Artwork 2"),
        CardData(title: "Urostomy", subtitle: "Blader", imageName: "Untitled_Artwork 3")
    ]
    
    var body: some View {
        HStack {
            ScrollView(.horizontal) {
                HStack {
                    ForEach(data) { item in
                        MenuCard(title: item.title, subtitle: item.subtitle, imageName: item.imageName)
                    }
                    .padding()
                }
                .padding()
            }
        }
    }
}

#Preview {
    MenuCaroussel()
}
