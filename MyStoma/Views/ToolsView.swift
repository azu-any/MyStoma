import SwiftUI

struct ToolsView: View {

    @State var selectedItem: InfoItem?

    var body: some View {
        ScrollView {
            ItemGridView(
                items: items,
                selectedItem: $selectedItem
            )
            .padding(30)
        }
        .navigationTitle("Tools")
        .sheet(item: $selectedItem) { item in
            ItemView(selectedItem: item)
        }
    }
}

#Preview {
    ToolsView()
}
