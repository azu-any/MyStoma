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
        }
        .environmentObject(router)
    }
}


#Preview {
    MenuView()
        .environmentObject(NavigationRouter())
        .environmentObject(OstomyViewModel(ostomy: loadOstomyFromBundle() ?? defaultOstomy))
}
