import SwiftUI

struct MenuView: View {
    @EnvironmentObject var router: NavigationRouter
    @State private var toggleRotation = false

    var body: some View {
        NavigationStack(path: $router.path) {
            VStack {
                HStack {
                    Button("", systemImage: "gearshape.fill") {
                        print("Settings")
                    }
                    .padding()
                    .font(.system(size: 50, weight: .regular, design: .default))
                    .foregroundColor(Color.blueSecond)

                    Spacer()
                }

                Image("Logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: 800)
                    .padding(.top, -60)
                    .padding(.bottom, 10)

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
                .padding(.leading, -300)
                .padding(.top, 30)

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
                .padding(.top, 30)
                .padding(.leading, -300)

                Spacer()

                CarruselView()

            }
            .padding()
            .background(Color.white)
            .onAppear {
                Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
                    toggleRotation.toggle()
                }
            }
            .overlay {
                ZStack {
                    Circle()
                        .fill(Color.bluePrimary)
                        .frame(width: 250, height: 250)
                        .overlay(
                            Circle()
                                .stroke(Color.blueSecond, lineWidth: 4)
                        )
                        .shadow(radius: 12) // Sombra opcional

                    Image("NurseRight")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(0)
                        .frame(width: 250, height: 250)
                        .clipShape(Circle())
                }
                .offset(x: 200, y: 27)
            }

            .navigationDestination(for: Route.self) { route in
                router.destination(for: route)
            }
        }
        .environmentObject(router)
    }
}

#Preview {
    MenuView().environmentObject(NavigationRouter())
}
