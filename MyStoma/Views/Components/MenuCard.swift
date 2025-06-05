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
                LinearGradient(gradient: Gradient(colors: [.bluePrimaryColor.opacity(1), .bluePrimaryColor.opacity(0)]),
                               startPoint: .leading, endPoint: .trailing)
            )
            .cornerRadius(20)
            .disabled((navView != nil) ? false : true)
            .opacity((navView != nil) ? 1.0 : 0.6)

        }
    }
}

/*
#Preview {
    MenuCard(card: CardData(title: "Colostomy", subtitle: "Colon stoma", imageName: "colostomyImage", navView: AnyView(ColostomyView())))

struct MenuCard_Previews: PreviewProvider {
    @State static var showModal = false
    
    static var previews: some View {
        MenuCard(title: "Colostomy",
                 subtitle: "Colon stoma",
                 imageName: "colostomyImage",
                 showModal: $showModal)
    }

*/

#Preview{
    MenuView()
}
