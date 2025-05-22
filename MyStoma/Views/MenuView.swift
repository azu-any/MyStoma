import SwiftUI

struct MenuView: View {
    //@EnvironmentObject var router: NavigationRouter
    @State private var toggleRotation = false
    @StateObject var router = NavigationRouter()
    
    var body: some View {
        NavigationStack(path: $router.path) {
            ScrollView {
                VStack(alignment: .leading) {
                    HStack {
                        
                        NavigationLink {
                            ToolsView()
                        } label: {
                            Image (systemName: "cross.case.fill")
                                .padding()
                                .font(.system(size: 40))
                                .foregroundColor(Color.bluePrimary)
                        }
                        
                        Spacer()
                        
                        NavigationLink {
                            SettingsView()
                        } label: {
                            Image (systemName: "gearshape.fill")
                                .padding()
                                .font(.system(size: 40))
                                .foregroundColor(Color.bluePrimary)
                        }
                    }
                    
                    MenuCaroussel()
                    
                    VStack(alignment: .leading) {
                        
                        Text("Stories")
                            .font(.title)
                            .bold()
                        
                        ScrollView(.horizontal) {
                            HStack (spacing: 20) {
                                ForEach(stories) { story in
                                    Image(story.imageName)
                                        .resizable()
                                        .scaledToFit()
                                }.frame(width: 320, height: 200)
                                    .background(Color.gray.opacity(0.2))
                                    .cornerRadius(30)
                            }
                        }
                    }
                    .padding(.leading)
                }
                .ignoresSafeArea()
                .edgesIgnoringSafeArea(.all)
                .padding()
                .background(Color.white)
                .onAppear {
                    Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
                        toggleRotation.toggle()
                    }
                }
                
                .navigationDestination(for: Route.self) { route in
                    router.destination(for: route)
                }
            }
            .navigationBarHidden(true)
        }
        .environmentObject(router)
    }
}

#Preview {
    MenuView()
        .environmentObject(NavigationRouter())
        .environmentObject(OstomyViewModel(ostomy: loadOstomyFromBundle() ?? defaultOstomy)
        )
}
