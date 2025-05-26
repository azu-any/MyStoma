import SwiftUI

struct ItemGridView: View {
    let items: [InfoItem]
    @Binding var selectedItem: InfoItem?

    
    let columns = Array(repeating: GridItem(.flexible(), spacing: 10), count: 6)

    private var sortedItems: [InfoItem] {
        items.sorted { $0.title < $1.title }
    }

    var body: some View {
        
        LazyVGrid(columns: columns, spacing: 10) {
            
            ForEach(sortedItems) { item in
                Button(action: {
                    selectedItem = item
                }, label: {
                    Text(item.title)
                        .multilineTextAlignment(.center)
                })
                .padding()
                .frame(width: 180, height: 180)
                .buttonStyle(InfoButtonStyle(color: Color.bluePrimary))
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
            InfoItem(
                title: "Medical Waste Bag",
                description: "Used to safely dispose of used stoma bags, wipes, and other contaminated materials."
            ),
            InfoItem(
                title: "Wipes/Absorbent Cloths",
                description: "Alcohol-free, used to clean and dry the skin around the stoma before applying a new bag."
            ),
            InfoItem(
                title: "Curved Scissors",
                description: "Used to cut the skin barrier to fit the stoma if using a cut-to-size system."
            ),
            InfoItem(
                title: "One-Piece Drainable Stoma Bag",
                description: "A combined pouch and barrier that collects output and can be emptied without removal."
            ),
            InfoItem(
                title: "Modeling Paste/Barrier Ring",
                description: "Applied around the stoma to fill skin creases, prevent leaks, and protect skin."
            ),
            InfoItem(
                title: "Adhesive Spray/Remover",
                description: "Spray for better adhesion or to gently remove the barrier without skin irritation."
            ),
            InfoItem(
                title: "?",
                description: "?"
            ),
            InfoItem(
                title: "?",
                description: "?")
        ], selectedItem: .constant(nil))
    }
}
