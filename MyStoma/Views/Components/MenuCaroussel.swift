import SwiftUI

struct MenuCaroussel: View {
    let data: [CardData]
    
    var body: some View {
        HStack {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(data) { item in
                        if item.type == "content" {
                            ContentViewIpad(
                                data: item
                                /*title: item.title,
                                subtitle: item.subtitle,
                                imageName: item.imageName,
                                imageModal: item.imageModal,
                                description: item.description,
                                navView: item.navView*/
                            )
                            .padding()
                        } else if item.type == "story" {
                            StoryView(
                                data: item
                                /*title: item.title,
                                subtitle: item.subtitle,
                                imageName: item.imageName,
                                imageModal: item.imageModal,
                                description: item.description,
                                quote: item.quote*/
                            )
                            .padding()
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

