import SwiftUI


struct ContentViewIpad: View {
    
    let data: CardData
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

                    VStack(alignment: .leading, spacing: 4) {
                        /*Text(data.subtitle)
                            .font(.title)
                            .bold()
                            .foregroundColor(.white)
                            .lineLimit(1)
                            .minimumScaleFactor(0.5)
                            .padding(.bottom, 4)
                            .padding(.top, 120)*/

                        Text(data.title)
                            .font(.title)
                            .bold()
                            .foregroundColor(.white)
                            .multilineTextAlignment(.leading)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.bottom, 10)
                    }
                    .padding()
                    #if os(iOS)
                    .frame(maxWidth: UIScreen.main.bounds.width * 0.3, maxHeight: UIScreen.main.bounds.width * 0.17)
                    #endif
                    .background(
                        LinearGradient(
                            /*gradient: Gradient(colors: [.bluePrimary, .bluePrimary.opacity(0.5)]),*/
                            gradient: Gradient(stops: [
                                .init(color: .bluePrimary, location: 0.0),
                                .init(color: .bluePrimary.opacity(0.6), location: 0.5),
                                .init(color: .bluePrimary.opacity(0.2), location: 1.0)
                                ]),
                            startPoint: .leading, endPoint: .trailing
                            
                            
                            /*gradient: Gradient(stops: [
                                //.init(color: Color.clear, location: 0.0),
                                .init(color: Color.blueSecondary.opacity(0.6), location: 0.5),
                                .init(color: Color.bluePrimaryColor.opacity(0.8), location: 1.0)
                            ]),
                            startPoint: .leading,
                            endPoint: .topTrailing
                             */
                        )
                    )
                    
                    
                    HStack(alignment: .center) {
                        Image(data.imageName)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            #if os(iOS)
                            .frame(width: UIScreen.main.bounds.width * 0.3,
                                   height: UIScreen.main.bounds.width * 0.17)
                            .clipped()
                            #endif
                    }
                    
                }
                /*.background(
                    LinearGradient(
                        gradient: Gradient(stops: [
                            .init(color: Color.blueSecondaryColor.opacity(0.8), location: 0.0),
                            .init(color: Color.bluePrimaryColor.opacity(0.0), location: 0.5),
                            .init(color: Color.bluePrimaryColor.opacity(0.0), location: 1.0)
                        ]),
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )*/
            }
            /*.background(
                LinearGradient(gradient: Gradient(colors: [.bluePrimary.opacity(0.6), .black.opacity(0)]),
                               startPoint: .leading, endPoint: .trailing)
            )*/
            .cornerRadius(20)
            .scaleEffect(animateTap ? 0.95 : 1.0)
            .animation(.spring(duration: 0.7), value: animateTap)
        }
        .sheet(isPresented: $showModal) {
            CustomModalView(isPresented: $showModal, data: data)
                .presentationDetents([.large])
                .presentationDragIndicator(.hidden)
                .presentationBackground(.clear)
        }
        .padding()
        #if os(iOS)
        .frame(maxWidth: UIScreen.main.bounds.width * 0.3, maxHeight: UIScreen.main.bounds.width * 0.17)
        .shadow(color: .black.opacity(0.2), radius: 2, x: 0, y: 0)
        #endif
    }
}


#Preview {
    ContentViewIpad(
        data: CardData(
            type: "content",
            title: "Colostomy l",
            subtitle: "Colon Stoma",
            imageName: "Colostomy",
            imageModal: "Untitled_Artwork",
            description: "This is a preview of the colostomy content for demonstration purposes.",
            navView: AnyView(Text("Next View"))
        )
    )
}


