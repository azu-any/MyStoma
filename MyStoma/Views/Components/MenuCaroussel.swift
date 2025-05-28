import SwiftUI

struct MenuCaroussel: View {
    let data: [CardData]
    
    var body: some View {
        HStack {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 25) {
                    ForEach(data) { item in
                        if item.type == "content" {
                            ContentViewIpad(
                                title: item.title,
                                subtitle: item.subtitle,
                                imageName: item.imageName,
                                imageModal: item.imageModal,
                                description: item.description,
                                navView: item.navView
                            )

                        } else if item.type == "story" {
                            StoryView(
                                title: item.title,
                                subtitle: item.subtitle,
                                imageName: item.imageName,
                                imageModal: item.imageModal,
                                description: item.description,
                                quote: item.quote
                            )

                        }
                    }
                }
                //.padding()
            }
        }
    }
}

#Preview {
    MenuCaroussel(data: CardData.storyData)
}

