import SwiftUI

struct MenuCaroussel: View {
    let data: [CardData]
    
    var body: some View {
        HStack {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(data) { item in
                        ContentViewIpad(
                            title: item.title,
                            subtitle: item.subtitle,
                            imageName: item.imageName,
                            imageModal: item.imageModal,
                            navView: item.navView,
                            description: item.description
                        )
                        .padding()
                    }
                }
                //.padding()
            }
        }
    }
}

#Preview {
    MenuCaroussel(data: CardData.sampleData)
}
