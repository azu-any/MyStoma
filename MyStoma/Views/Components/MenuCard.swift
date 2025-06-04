import SwiftUI

struct MenuCard: View {
    var title: LocalizedStringResource
    var subtitle: LocalizedStringResource
    var imageName: String
    var navView: AnyView?
    @Binding var showModal: Bool

    
    init(card: CardData, showModal: Binding<Bool>) {
        self.title = card.title
        self.subtitle = card.subtitle
        self.imageName = card.imageName
        self.navView = card.navView
        self._showModal = showModal
    }
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(.title)
                .bold()
                .foregroundColor(.black)
            
            Text(subtitle)
                .font(.title2)
                .bold()
                .foregroundColor(.gray)
                .padding(.bottom, 4)
            
            Button(action: {
                withAnimation {
                    showModal.toggle()
                }
            }) {
                HStack(alignment: .center) {
                    Image(imageName)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 500, height: 300)
                        .offset(x: 110, y: -130)
                        .clipped()
                }
            }
            .padding()
            .background(
                LinearGradient(gradient: Gradient(colors: [.blue.opacity(1), .black.opacity(0)]),
                               startPoint: .leading, endPoint: .trailing)
            )
            .cornerRadius(20)
            .disabled((navView != nil) ? false : true)
            .opacity((navView != nil) ? 1.0 : 0.6)

        }
    }
}


#Preview {
    struct MenuCard_Previews: View {
        @State private var showModal = false

        var body: some View {
            MenuCard(card: CardData(type: "colostomy",
                                    title: "Colostomy",
                                    subtitle: "Colon stoma",
                                    imageName: "Untitled_Artwork 2",
                                    imageModal: "colostomyModalImage",
                                    description: "A surgically created opening from the colon to the abdominal wall.",
                                    navView: AnyView(ColostomyView()),
                                    quote: nil),
                     showModal: $showModal)
        }
    }

    return MenuCard_Previews()
}
