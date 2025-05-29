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

                    VStack(alignment: .leading, spacing: 4) {
                        Text(data.subtitle)
                            .font(.title)
                            .bold()
                            .foregroundColor(.white)
                            .lineLimit(1)
                            .minimumScaleFactor(0.5)
                            .padding(.bottom, 4)
                            .padding(.top, 120)

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
                            gradient: Gradient(stops: [
                                .init(color: Color.clear, location: 0.0),
                                .init(color: Color.bluePrimary.opacity(0.6), location: 0.5),
                                .init(color: Color.blueSecondaryColor.opacity(0.8), location: 1.0)
                            ]),
                            startPoint: .topTrailing,
                            endPoint: .bottomLeading
                        )
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
                )
            }
            .background(
                LinearGradient(gradient: Gradient(colors: [.bluePrimary.opacity(0.6), .black.opacity(0)]),
                               startPoint: .leading, endPoint: .trailing)
            )
            .cornerRadius(25)
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
        #endif
        .shadow(color: .black.opacity(0.2), radius: 4, x: 0, y: 0)
    }
}

struct CustomModalView: View {
    @EnvironmentObject var router: NavigationRouter
    @Environment(\.dismiss) var dismiss
    @Binding var isPresented: Bool
    let data: CardData
    
    var body: some View {
        ZStack {
            // Full screen glassmorphism background
            Rectangle()
                .opacity(0)
                .overlay(
                    // Glass grain effect
                    Rectangle()
                        .fill(
                            RadialGradient(
                                gradient: Gradient(stops: [
                                    .init(color: Color.white.opacity(0.1), location: 0.0),
                                    .init(color: Color.clear, location: 0.3),
                                    .init(color: Color.white.opacity(0.05), location: 0.6),
                                    .init(color: Color.clear, location: 1.0)
                                ]),
                                center: .topLeading,
                                startRadius: 0,
                                endRadius: 800
                            )
                        )
                        .overlay(
                            // Additional glass texture
                            Rectangle()
                                .fill(
                                    LinearGradient(
                                        gradient: Gradient(stops: [
                                            .init(color: Color.white.opacity(0.08), location: 0.0),
                                            .init(color: Color.clear, location: 0.2),
                                            .init(color: Color.white.opacity(0.04), location: 0.4),
                                            .init(color: Color.clear, location: 0.6),
                                            .init(color: Color.white.opacity(0.06), location: 0.8),
                                            .init(color: Color.clear, location: 1.0)
                                        ]),
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    )
                                )
                        )
                )
                .ignoresSafeArea(.all)
            
            // Modal content with custom frame
            ZStack {
                // Background for the modal content with glassmorphism
                RoundedRectangle(cornerRadius: 25)
                    .fill(.regularMaterial)
                    .environment(\.colorScheme, .dark)
                    .overlay(
                        RoundedRectangle(cornerRadius: 25)  // ← Changed from 20 to 25
                            .stroke(
                                LinearGradient(
                                    gradient: Gradient(stops: [
                                        .init(color: Color.white.opacity(0.2), location: 0.0),
                                        .init(color: Color.white.opacity(0.1), location: 0.5),
                                        .init(color: Color.clear, location: 1.0)
                                    ]),
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                ),
                                lineWidth: 1
                            )
                    )
                    .shadow(color: .black.opacity(0.3), radius: 20, x: 0, y: 10)
                
                // Content
                HStack(alignment: .top, spacing: 0) {
                    // Image section
                    ZStack {
                        Rectangle()
                            .fill(Color.blueSecondaryColor.opacity(0.2))
                        
                        Image(data.imageModal)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .clipped()
                        
                        LinearGradient(
                            gradient: Gradient(colors: [Color.bluePrimary.opacity(0.4), Color.clear]),
                            startPoint: .bottom,
                            endPoint: .top
                        )
                    }
                    .frame(maxWidth: .infinity)
                    .clipShape(
                        UnevenRoundedRectangle(
                            topLeadingRadius: 20,
                            bottomLeadingRadius: 20,
                            bottomTrailingRadius: 0,
                            topTrailingRadius: 0
                        )
                    )
                    
                    // Text content section
                    VStack(alignment: .leading, spacing: 20) {
                        ScrollView {
                            VStack(alignment: .leading, spacing: 30) {
                                Text(data.title)
                                    .font(.largeTitle)
                                    .bold()
                                    .foregroundColor(.primary)
                                
                                Text(data.description)
                                    .font(.body)
                                    .multilineTextAlignment(.leading)
                                    .foregroundColor(.primary)
                                
                                Spacer(minLength: 80) // Space for button
                            }
                            .padding(.top, 40)
                            .padding(.horizontal, 30)
                        }
                        .scrollIndicators(.hidden)
                    }
                    .frame(maxWidth: .infinity)
                }
                .clipShape(RoundedRectangle(cornerRadius: 25))
            }
            .frame(
                width: min(UIScreen.main.bounds.width , 800),
                height: min(UIScreen.main.bounds.height, 600)
            )
            .overlay(alignment: .topTrailing) {
                // Close button with glassmorphism
                Button(action: { dismiss() }) {
                    Image(systemName: "xmark.circle.fill")
                        .font(.title2)
                        .foregroundColor(.secondary)
                        .background(
                            Circle()
                                .fill(.regularMaterial)
                                .overlay(
                                    Circle()
                                        .stroke(Color.white.opacity(0.2), lineWidth: 1)
                                )
                        )
                }
                .padding(15)
            }
            .overlay(alignment: .bottomTrailing) {
                // Start button with glassmorphism
                Button {
                    dismiss()
                    router.path.append(.colostomy)
                } label: {
                    Text("Start")
                        .fontWeight(.semibold)
                        .padding(.horizontal, 30)
                        .padding(.vertical, 12)
                        .foregroundColor(.white)
                        .background(
                            RoundedRectangle(cornerRadius: 25)
                                .fill(.regularMaterial)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 25)
                                        .fill(
                                            LinearGradient(
                                                gradient: Gradient(colors: [
                                                    Color.blue.opacity(0.8),
                                                    Color.blue.opacity(0.6)
                                                ]),
                                                startPoint: .topLeading,
                                                endPoint: .bottomTrailing
                                            )
                                        )
                                )
                                .overlay(
                                    RoundedRectangle(cornerRadius: 25)
                                        .stroke(Color.white.opacity(0.3), lineWidth: 1)
                                )
                        )
                }
                .padding(.bottom, 30)
                .padding(.trailing, 30)
                .disabled(data.navView == nil)
            }
        }
    }
}

/*
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
                    HStack(alignment: .center) {
                        Image(data.imageName)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            #if os(iOS)
                            .frame(width: UIScreen.main.bounds.width * 0.3,
                                   height: UIScreen.main.bounds.width * 0.17) //.4, .24
                            .clipped()
                            #endif
                    }

                    VStack(alignment: .leading, spacing: 4) {
                        Text(data.subtitle)
                            .font(.title)
                            .bold()
                            .foregroundColor(.white)
                            .lineLimit(1)
                            .minimumScaleFactor(0.5)
                            .padding(.bottom, 4)
                            .padding(.top, 120)

                        Text(data.title)
                            .font(.title)
                            .bold()
                            .foregroundColor(.white)
                            //.lineLimit(1)
                            //.minimumScaleFactor(0.5)
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
            WindowView(isPresented: $showModal, data: data)
            #if os(iOS)
                .ignoresSafeArea()
                .frame(width: UIScreen.main.bounds.width * 2/3, height: UIScreen.main.bounds.height * 2/3)
                .transition(.scale)
                //.presentationDetents([.fraction(1.0)])
                //.presentationDetents([.large])
                //.presentationDragIndicator(.hidden)
            #endif
        }
        .ignoresSafeArea()
        .padding()

        #if os(iOS)
        .frame(maxWidth: UIScreen.main.bounds.width * 0.3, maxHeight: UIScreen.main.bounds.width * 0.17)
        #endif
        .shadow(color: .black.opacity(0.2), radius: 4, x: 0, y: 0)
    }
}

*/
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

