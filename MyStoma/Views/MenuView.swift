import SwiftUI

struct MenuView: View {
    @State private var toggleRotation = false
    @StateObject var router = NavigationRouter()
    @State private var showSettingsPopover = false
    
    var body: some View {
        NavigationStack(path: $router.path) {

            VStack(alignment: .leading) {
                Text("Practice with Simulators")
                    .font(.title2)
                    .bold()
                    //.foregroundColor(.black)
                    .padding(.horizontal)

                MenuCaroussel(data: CardData.sampleData)
                
                
                Text("Connect with Stories")
                    .font(.title2)
                    .bold()
                    //.foregroundColor(.black)
                    .padding([.horizontal, .top])
                
                ToolCaroussel(items: items, selectedItem: .constant(nil))
                

                Text("Connect with Stories")
                    .font(.title2)
                    .bold()
                    //.foregroundColor(.black)
                    .padding([.horizontal, .top])

                MenuCaroussel(data: CardData.storyData)
            }
            //.background(Color.white.ignoresSafeArea())
            .onAppear {
                Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
                    toggleRotation.toggle()
                }
            }
            .navigationDestination(for: Route.self) { route in
                router.destination(for: route)
            }
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button(action: {
                        router.path.append(.tools)
                    }) {
                        Label("Tools", systemImage: "cross.case.fill")
                            .labelStyle(.titleAndIcon)
                            .foregroundColor(Color.bluePrimary)
                    }
                }
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        showSettingsPopover.toggle()
                    } label: {
                        Image(systemName: "gearshape.fill")
                    }
                    .popover(isPresented: $showSettingsPopover) {
                        AppSettingsView()
                    }
                }
            }
            //.navigationTitle("Explore & Learn")
        }
        .environmentObject(router)
        //.background(Color.white.ignoresSafeArea())
/*
            ZStack(alignment: .top) {
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
*/
    }
}


#Preview {
    MenuView()
        .environmentObject(NavigationRouter())
        .environmentObject(OstomyViewModel(ostomy: loadOstomyFromBundle() ?? defaultOstomy))
}
