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
                                data: item
                            )

                        } else if item.type == "story" {
                            StoryView(
                                data: item
                            )

                        }
                    }
                }
                .padding(.horizontal)
                .padding(.vertical, 4) 
            }
        }
    }
}

#Preview {
    MenuCaroussel(data: CardData.sampleData)
}

