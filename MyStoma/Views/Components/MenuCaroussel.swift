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
                            description: item.description,
                            navView: item.navView,
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
