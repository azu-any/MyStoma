import SwiftUI

struct ContentViewIpad: View {
    var title: String
    var subtitle: String
    var imageName: String
    var navView: AnyView?
    var description: String

    @State private var showModal = false

    var body: some View {
        ZStack {
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
            .sheet(isPresented: $showModal) {
                WindowView(isPresented: $showModal, title: title, description: description, navView: navView)
                    .frame(width: UIScreen.main.bounds.width * 2/3,
                           height: UIScreen.main.bounds.height * 2/3)
                    .transition(.scale)
                
            }
        }
    }
}
