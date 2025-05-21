import SwiftUI

struct MenuView: View {
    //@EnvironmentObject var router: NavigationRouter
    @State private var toggleRotation = false
    @StateObject var router = NavigationRouter()
    
    var body: some View {
        NavigationStack(path: $router.path) {
            VStack {
                HStack {
                    Image (systemName: "cross.case.fill")
                        .padding()
                        .font(.system(size: 40))
                        .foregroundColor(Color.bluePrimary)
                    
                    Spacer()
                    
                    Image (systemName: "gearshape.fill")
                        .padding()
                        .font(.system(size: 40))
                        .foregroundColor(Color.bluePrimary)
                }
                
                MenuCaroussel()
                
                VStack(alignment: .leading) {
                    HStack {
                        Text("Stories")
                            .font(.title)
                            .bold()
                        Spacer()
                    }
                }
                
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(0..<10) { index in
                            Text("")
                        }.frame(width: 320, height: 200)
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(30)
                    }
                }
                
                
            }
            .ignoresSafeArea()
            .edgesIgnoringSafeArea(.all)
            .padding()
            .padding(.top, 100)
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
        .environmentObject(router)
    }
}

#Preview {
    MenuView()
        .environmentObject(NavigationRouter())
        .environmentObject(OstomyViewModel(ostomy: loadOstomyFromBundle() ?? defaultOstomy)
        )
}
