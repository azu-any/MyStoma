import SwiftUI

struct ContentViewIpad: View {

    let title: LocalizedStringResource
    let subtitle: LocalizedStringResource
    let imageName: String
    let imageModal: String
    let description: LocalizedStringResource
    var navView: AnyView?

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
                            .aspectRatio(contentMode: .fill)
                            .frame(width: UIScreen.main.bounds.width * 0.4,
                                   height: UIScreen.main.bounds.width * 0.24)
                            .clipped()
                    }

                    VStack(alignment: .leading, spacing: 4) {
                        Text(subtitle)
                            .font(.largeTitle)
                            .bold()
                            .foregroundColor(.white)
                            .lineLimit(1)
                            .minimumScaleFactor(0.5)
                            .padding(.bottom, 4)
                            .padding(.top, 150)

                        Text(title)
                            .font(.largeTitle)
                            .bold()
                            .foregroundColor(.white)
                            //.lineLimit(1)
                            //.minimumScaleFactor(0.5)
                            .multilineTextAlignment(.leading)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.bottom, 10)
                    }
                    .padding()
                    //.frame(maxWidth: .infinity, alignment: .leading)
                    .frame(maxWidth: UIScreen.main.bounds.width * 0.4, maxHeight: UIScreen.main.bounds.width * 0.24)
                    .background(
                        LinearGradient(
                            gradient: Gradient(stops: [
                                .init(color: Color.clear, location: 0.0),
                                .init(color: Color.bluePrimary.opacity(0.6), location: 0.5),
                                .init(color: Color.blueSecondaryColor.opacity(0.8), location: 1.0)
                            ]),
                            startPoint: .topTrailing,
                            endPoint: .bottomLeading
                        )
                        //LinearGradient(gradient: Gradient(colors: [Color.clear, .blue.opacity(0.6)]), startPoint: .top, endPoint: .bottom)
                    )
                    
                }
                .background(
                    LinearGradient(
                        gradient: Gradient(stops: [
                            .init(color: Color.white.opacity(0.8), location: 0.0),
                            .init(color: Color.bluePrimary.opacity(0.0), location: 0.5),
                            .init(color: Color.blue.opacity(0.0), location: 1.0)
                        ]),
                        startPoint: .top,
                        endPoint: .leading
                    )
                    //LinearGradient(gradient: Gradient(colors: [Color.clear, .blue.opacity(0.6)]), startPoint: .top, endPoint: .bottom)
                )

            }
            
            .background(
                LinearGradient(gradient: Gradient(colors: [.bluePrimary.opacity(0.6), .black.opacity(0)]),
                               startPoint: .leading, endPoint: .trailing)
            )
            
            .cornerRadius(20)
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
        .frame(maxWidth: UIScreen.main.bounds.width * 0.4, maxHeight: UIScreen.main.bounds.width * 0.24)
        .shadow(color: .black.opacity(0.2), radius: 4, x: 0, y: 0)
    }
}


#Preview {
    ContentViewIpad(
        title: "Colostomy l",
        subtitle: "Colon Stoma",
        imageName: "Colostomy",
        imageModal: "Untitled_Artwork",
        description: "This is a preview of the colostomy content for demonstration purposes.",
        navView: AnyView(Text("Next View"))
    )
}

