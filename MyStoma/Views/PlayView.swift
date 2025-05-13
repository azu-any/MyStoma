import SwiftUI

struct PlayView: View {
    @EnvironmentObject var router: NavigationRouter
    @State private var selectedItem: InfoItem?

    var body: some View {
        VStack {
            ItemGridView(
                items: [
                    InfoItem(title: "Colostomy", description: ""),
                    InfoItem(title: "Ileostomy", description: ""),
                ],
                selectedItem: $selectedItem
            )
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
    PlayView().environmentObject(NavigationRouter())
}
