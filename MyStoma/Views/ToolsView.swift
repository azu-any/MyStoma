import SwiftUI

struct ToolsView: View {

    @State private var selectedItem: InfoItem?

    var body: some View {
        ScrollView {
            ItemGridView(
                items: items,
                selectedItem: $selectedItem
            )
            .padding(30)
        }
        .navigationTitle("Health Info")
        .sheet(item: $selectedItem) { item in
            
            VStack(spacing: 20) {
                Text(item.title)
                    .font(.largeTitle)
                    .bold()
                Text(item.description)
                    .font(.body)
                    .padding()
                
                Spacer()
            }
            .padding()
        }
    }
}

#Preview {
    ToolsView()
}
