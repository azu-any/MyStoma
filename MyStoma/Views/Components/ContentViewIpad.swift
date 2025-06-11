import SwiftUI


struct ContentViewIpad: View {
    
    let data: CardData
    var navView: AnyView?

    @State private var animateTap = false
    @State private var showModal = false
    
    var body: some View {
        ZStack {
            Button {
                animateTap = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    showModal = true
                    animateTap = false
                }
            } label: {
                ZStack {

                    VStack(alignment: .leading, spacing: 4) {

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
                    #if os(visionOS)
                    .frame(maxWidth: 375, maxHeight: 212.5)
                    #endif
                    .background(
                        LinearGradient(
                            gradient: Gradient(stops: [
                                .init(color: .bluePrimary, location: 0.0),
                                .init(color: .bluePrimary.opacity(0.6), location: 0.5),
                                .init(color: .bluePrimary.opacity(0.2), location: 1.0)
                                ]),
                            startPoint: .leading, endPoint: .trailing
                        )
                    )
                    
                    
                    HStack(alignment: .center) {
                        Image(data.imageName)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            #if os(iOS)
                            .frame(width: UIScreen.main.bounds.width * 0.3,
                                   height: UIScreen.main.bounds.width * 0.17)
                            #endif
                            #if os(visionOS)
                            .frame(maxWidth: 375, maxHeight: 212.5)
                            #endif
                            .clipped()
                    }
                    
                }
            }
            .cornerRadius(20)
            .scaleEffect(animateTap ? 0.95 : 1.0)
            .animation(.spring(duration: 0.7), value: animateTap)
            .buttonStyle(.plain)
        }
        .sheet(isPresented: $showModal) {
            CustomModalView(isPresented: $showModal, data: data)
                .presentationDetents([.large])
                .presentationDragIndicator(.hidden)
                .presentationBackground(.clear)
        }
        #if os(iOS)
        .padding()
        .frame(maxWidth: UIScreen.main.bounds.width * 0.3, maxHeight: UIScreen.main.bounds.width * 0.17)
        #endif
        #if os(visionOS)
        .frame(maxWidth: 375, maxHeight: 212.5)
        #endif
        .shadow(color: .black.opacity(0.2), radius: 2, x: 0, y: 0)
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


