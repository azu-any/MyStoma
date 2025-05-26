import SwiftUI

struct ContentViewIpad: View {
    var title: String
    var subtitle: String
    var imageName: String
    var imageModal: String
    var navView: AnyView?
    var description: String

    @State private var animateTap = false
    @State private var showModal = false
    
    var body: some View {
        ZStack {
            Button(action: {
                animateTap = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    showModal = true
                    animateTap = false
                }
            }) {
                ZStack {
                    HStack(alignment: .center) {
                        Image(imageName)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: UIScreen.main.bounds.width * 0.3,
                                   height: UIScreen.main.bounds.width * 0.17)
                            .clipped()
                    }

                    VStack(alignment: .leading, spacing: 4) {
                        Text(subtitle)
                            .font(.title)
                            .bold()
                            .foregroundColor(.white)
                            .lineLimit(1)
                            .minimumScaleFactor(0.5)
                            .padding(.bottom, 4)
                            .padding(.top, 120)

                        Text(title)
                            .font(.title)
                            .bold()
                            .foregroundColor(.white)
                            .lineLimit(1)
                            .minimumScaleFactor(0.5)
                            .multilineTextAlignment(.leading)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .padding()
                    //.frame(maxWidth: .infinity, alignment: .leading)
                    .frame(maxWidth: UIScreen.main.bounds.width * 0.3, maxHeight: UIScreen.main.bounds.width * 0.17)
                    .background(
                        LinearGradient(gradient: Gradient(colors: [Color.clear, .blue.opacity(0.8)]),
                                       startPoint: .top, endPoint: .bottom)
                    )
                }
            }
            
            .background(
                LinearGradient(gradient: Gradient(colors: [.blue.opacity(1), .black.opacity(0)]),
                               startPoint: .leading, endPoint: .trailing)
            )
            .cornerRadius(30)
            .scaleEffect(animateTap ? 0.95 : 1.0)
            .animation(.spring(duration: 0.7), value: animateTap)
        }
        .sheet(isPresented: $showModal) {
            WindowView(isPresented: $showModal, title: title, description: description, navView: navView)
                .frame(width: UIScreen.main.bounds.width * 2/3,
                       height: UIScreen.main.bounds.height * 2/3)
                .transition(.scale)
        }
        .padding()
        .frame(maxWidth: UIScreen.main.bounds.width * 0.3, maxHeight: UIScreen.main.bounds.width * 0.17)
    }
}

#Preview {
    ContentViewIpad(
        title: "Colostomy l",
        subtitle: "Colon Stoma",
        imageName: "Colostomy",
        imageModal: "Untitled_Artwork",
        navView: AnyView(Text("Next View")),
        description: "This is a preview of the colostomy content for demonstration purposes."
    )
}
