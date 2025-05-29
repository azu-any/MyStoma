import SwiftUI


struct WindowView: View {
    
    @EnvironmentObject var router: NavigationRouter
    @Environment(\.dismiss) var dismiss

    @Binding var isPresented: Bool
    
    let data: CardData
    
    //var title: LocalizedStringResource
    //var description: LocalizedStringResource
    var navView: AnyView?


    
    var body: some View {
            HStack(alignment: .top) {
                
                ZStack {
                    Rectangle()
                            .fill(Color.blueSecondaryColor.opacity(0.2))
                    
                    Image(data.imageModal)
                        .resizable()
                        //.scaledToFill()
                        .aspectRatio(contentMode: .fill)
                        .scaledToFill()
                        //.clipShape(RoundedRectangle(cornerRadius: 15))
                        .frame(maxWidth: .infinity, alignment: .center)
                    
                    LinearGradient(
                            gradient: Gradient(colors: [Color.bluePrimary.opacity(0.4), Color.clear]),
                            startPoint: .bottom,
                            endPoint: .top
                        )
                }
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
                )
            
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 40) {
                        
                        Text(data.title)
                            .font(.largeTitle)
                            .bold()
                            .padding()
                        
                        Text(data.description)
                            .font(.body)
                            .multilineTextAlignment(.leading)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Spacer()
                        
                    }
                    //.padding(.horizontal)
                }
                
                Spacer()
                
            }
            //.padding()
        
            .overlay(alignment: .bottom) {
                Button {
                    dismiss()
                    router.path.append(.colostomy)
                } label: {
                    Text("Start")
                        .fontWeight(.semibold)
                        .frame(minWidth: 100)
                        .padding()
                        .foregroundColor(.blue)
                        .background(Color.white)
                        .cornerRadius(15)
                        .overlay(
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(Color.blue, lineWidth: 2)
                        )
                }
                
                //.padding(.bottom, 20)
                //.buttonStyle(ScaleButtonStyle())
                //.padding()
                .disabled((navView != nil) ? false : true)
                
            }
            //.background(Color.blueSecondaryColor)
            .ignoresSafeArea()
            #if os(iOS)
            .frame(width: UIScreen.main.bounds.width * 2/3, height: UIScreen.main.bounds.height * 2/3)
            #endif

    }
}

struct ScaleButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}


/*struct WindowView: View {
    
    @EnvironmentObject var router: NavigationRouter
    @Environment(\.dismiss) var dismiss

    @Binding var isPresented: Bool
    
    let data: CardData
    
    //var title: LocalizedStringResource
    //var description: LocalizedStringResource
    var navView: AnyView?


    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text(data.title)
                    .font(.largeTitle)
                    .bold()
                    .padding()
                
                HStack(alignment: .top, spacing: 40) {
                    Text(data.description)
                        .font(.body)

                        .multilineTextAlignment(.leading)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Spacer()
                    
                    Image(data.imageModal)
                        .resizable()
                        .scaledToFit()
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        .frame(maxWidth: .infinity, alignment: .center)
                }
                .padding(.horizontal)
                
                Spacer()
                
            }
            .padding()
        }
        .overlay(alignment: .bottom) {
            Button {
                dismiss()
                router.path.append(.colostomy)
            } label: {
                Text("Start")
                    .fontWeight(.semibold)
                    .frame(minWidth: 100)
                    .padding()
                    .foregroundColor(.blue)
                    .background(Color.white)
                    .cornerRadius(15)
                    .overlay(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(Color.blue, lineWidth: 2)
                    )
            }
            
            .padding(.bottom, 20)
            //.buttonStyle(ScaleButtonStyle())
            .padding()
            .disabled((navView != nil) ? false : true)
            
        }
        .background(Color.white)

    }
}

struct ScaleButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}*/

struct WindowView_Previews: PreviewProvider {
    static var previews: some View {
        WindowView(
            isPresented: .constant(true),
            data: CardData(
                type: "content",
                title: "Colostomy l",
                subtitle: "Colon Stoma",
                imageName: "Colostomy",
                imageModal: "Untitled_Artwork",
                description: "In this section you will learn what a colostomy is, how it works and what aspects are important to know in daily life. A colostomy is a surgical opening on the abdomen, called a stoma, that allows feces to exit the colon to the outside of the body, where they are collected in a special adhesive bag. It can be temporary or permanent, depending on the clinical condition. The feces no longer pass through the anus but through the stoma, into a bag. Now that you have a basic understanding, you're ready to begin. Click on the buttons and let's start this journey together!",
                navView: AnyView(Text("Next View"))
            )
        )
    }
}
