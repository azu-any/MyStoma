import SwiftUI

struct MenuView: View {
    @EnvironmentObject var router: NavigationRouter
    @State private var toggleRotation = false

    let images = ["StomaBag", "StomaBag2", "StomaBag3"]
    let rotations: [Double] = [-45, -35, 0, 35, 45]

    var body: some View {
        NavigationStack(path: $router.path) {
            VStack {
                HStack {
                    Button("", systemImage: "gearshape.fill") {
                        print("Settings")
                    }
                    .padding()
                    .font(.system(size: 50, weight: .regular, design: .default))
                    .foregroundColor(Color.white)

                    Spacer()
                }

                Image("StomaDida")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: 1000)
                    .padding(.bottom, 50)

                Button {
                    router.path.append(.play)
                } label: {
                    HStack {
                        Image(systemName: "play.fill")
                        Spacer()
                        Text("Play")
                        Spacer()
                    }
                }
                .padding()
                .font(.system(size: 50, weight: .regular, design: .default))
                .foregroundColor(.bluePrimary)
                .frame(width: 350)
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .overlay {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(.clear)
                        .stroke(Color.blueSecond, lineWidth: 4)
                }
                .padding()

                Button {
                    router.path.append(.tools)
                } label: {
                    HStack {
                        Image(systemName: "cross.case")
                        Spacer()
                        Text("Tools")
                        Spacer()
                    }
                }
                .padding()
                .font(.system(size: 50, weight: .regular, design: .default))
                .foregroundColor(.bluePrimary)
                .frame(width: 350)
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .overlay {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(.clear)
                        .stroke(Color.blueSecond, lineWidth: 4)
                }
                .padding()

                Spacer()

                InfiniteCarouselView()
            }
            .padding()
            .background(Color.bluePrimary)
            .onAppear {
                Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
                    toggleRotation.toggle()
                }
            }
            .overlay {
                Image("NurseRight")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: 400, maxHeight: 300)
                    .padding()
                    .offset(x: 450, y: 65)
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
}
