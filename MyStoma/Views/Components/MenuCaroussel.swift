import SwiftUI

struct MenuCaroussel: View {
    let data = CardData.sampleData
    
    var body: some View {
        HStack {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(data) { item in
                        ContentViewIpad(
                            title: item.title,
                            subtitle: item.subtitle,
                            imageName: item.imageName,
                            navView: item.navView,
                            description: item.description
                        )
                        .padding()
                    }
                }
                .padding()
            }
        }
    }
}

#Preview {
    MenuCaroussel()
}
