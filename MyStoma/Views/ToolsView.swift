import SwiftUI

struct ToolsView: View {

    @State private var selectedCategory: StomaCategory? = nil
    let categories = [nil] + StomaCategory.allCases

    @State private var showCategoryPicker: Bool = false
    @State var selectedItem: InfoItem?

    var body: some View {
        HStack {
            Spacer()
            Button {
                showCategoryPicker.toggle()
            } label: {
                Image(systemName: "slider.horizontal.3")
                    .imageScale(.large)
            }
            .popover(isPresented: $showCategoryPicker) {
                VStack(alignment: .leading) {
                    Text("Choose Category")
                        .font(.headline)
                        .padding(.bottom, 5)
                    
                    Picker("Category", selection: $selectedCategory) {
                        Text("All").tag(StomaCategory?.none)
                        ForEach(StomaCategory.allCases) { category in
                            Text(category.rawValue.capitalized).tag(Optional(category))
                        }
                    }
                    .pickerStyle(.inline)
                }
                .padding()
                .frame(width: 250)
        }
        }
        .padding()

        ScrollView {
            ItemGridView(
                items: items.filter { selectedCategory == nil || $0.categories.contains(selectedCategory!) },
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
