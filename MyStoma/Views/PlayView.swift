import SwiftUI

struct PlayView: View {
    @EnvironmentObject var viewModel: OstomyViewModel
    @EnvironmentObject var router: NavigationRouter
    @State private var selectedItem: InfoItem?

    var body: some View {
        VStack {

            HStack(spacing: 50) {
                Button {
                    selectedItem = .init(title: "Colostomy", description: "")
                } label: {
                    Text("Colostomy")
                        .font(.title)
                        .bold()
                }
                .frame(width: 450, height: 450)
                .buttonStyle(InfoButtonStyle())
                
                Button {
                    
                } label: {
                    HStack {
                        Image(systemName: "lock.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 25, height: 25)
                        
                        Text("Ileostomy")
                            .font(.title)
                            .bold()
                    }
                }
                .frame(width: 450, height: 450)
                .buttonStyle(InfoButtonStyle(color: .secondary.opacity(0.9)))
            }
            .onChange(of: selectedItem, initial: false) {
                if selectedItem != nil {
                    router.path.append(.colostomy)
                }
            }
        }
        .navigationTitle("Make your selection")
    }
}

#Preview {
    PlayView()
        .environmentObject(NavigationRouter())
        .environmentObject(OstomyViewModel(ostomy: defaultOstomy))
}
