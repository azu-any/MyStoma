import SwiftUI

struct MenuView: View {
    @State private var toggleRotation = false
    @StateObject var router = NavigationRouter()
    

    
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
                    Button(action: {
                        router.path.append(.settings)
                    }) {
                        Label("Settings", systemImage: "gearshape.fill")
                            .labelStyle(.titleAndIcon)
                            .foregroundColor(Color.bluePrimary)
                    }
                }
            }
            .navigationTitle("Explore & Learn")
        }
        .environmentObject(router)
        //.background(Color.white.ignoresSafeArea())
    }
}


#Preview {
    MenuView()
        .environmentObject(NavigationRouter())
        .environmentObject(OstomyViewModel(ostomy: loadOstomyFromBundle() ?? defaultOstomy)
        )
}


