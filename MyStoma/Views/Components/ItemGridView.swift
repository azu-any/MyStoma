import SwiftUI

struct ItemGridView: View {
    let items: [InfoItem]
    @Binding var selectedItem: InfoItem?

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]

    var body: some View {
        LazyVGrid(columns: columns, spacing: 20) {
            ForEach(items) { item in
                Button(action: {
                    selectedItem = item
                }, label: {
                    Text(item.title)
                })
                .buttonStyle(InfoButtonStyle())
                .frame(maxWidth: .infinity)
            }
        }
        .padding()
    }
}

struct ItemGridView_Previews: PreviewProvider {
    static var previews: some View {
        ItemGridView(items: [
            InfoItem(title: "Stoma Care", description: "Detailed info about stoma care."),
            InfoItem(title: "Nutrition", description: "Tips on what to eat and avoid."),
        ], selectedItem: .constant(nil))
    }
}
