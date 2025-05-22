import SwiftUI

struct MenuCard: View {
    var title: String
    var subtitle: String
    var imageName: String
    
    @Binding var showModal: Bool
    
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
        }
    }
}

struct MenuCard_Previews: PreviewProvider {
    @State static var showModal = false
    
    static var previews: some View {
        MenuCard(title: "Colostomy",
                 subtitle: "Colon stoma",
                 imageName: "colostomyImage",
                 showModal: $showModal)
    }
}
