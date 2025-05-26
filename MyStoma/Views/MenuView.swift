import SwiftUI

struct MenuView: View {
    @State private var toggleRotation = false
    @StateObject var router = NavigationRouter()

    var body: some View {
        NavigationStack(path: $router.path) {
            ZStack(alignment: .top) {
                ScrollView {
                    VStack(spacing: 20) {
                        Spacer().frame(height: 75)

                        MenuCaroussel()

                        VStack(alignment: .leading) {
                            Text("Stories")
                                .font(.title)
                                .bold()
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.horizontal)
                        }

                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 16) {
                                ForEach(0..<10) { _ in
                                    RoundedRectangle(cornerRadius: 30)
                                        .fill(Color.gray.opacity(0.2))
                                        .frame(width: 320, height: 200)
                                }
                            }
                            .padding(.horizontal)
                        }
                    }
                    .padding(.bottom, 30)
                }

                // BARRA SUPERIOR FIJA
                HStack {
                    Image(systemName: "cross.case.fill")
                        .font(.system(size: 40))
                        .foregroundColor(Color.bluePrimary)

                    Spacer()

                    Image(systemName: "gearshape.fill")
                        .font(.system(size: 40))
                        .foregroundColor(Color.bluePrimary)
                }
                .padding(.horizontal)
                .padding(.top, 50)
            }
            .ignoresSafeArea()
            .background(Color.white)

            .onAppear {
                Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
                    toggleRotation.toggle()
                }
            }

            .navigationDestination(for: Route.self) { route in
                router.destination(for: route)
            }
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
        .environmentObject(OstomyViewModel(ostomy: loadOstomyFromBundle() ?? defaultOstomy))
}
