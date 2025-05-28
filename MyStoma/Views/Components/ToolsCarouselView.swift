//
//  ToolsCarouselView.swift
//  MyStoma
//
//  Created by Martha Mendoza Alfaro on 28/05/25.
//


import SwiftUI

struct ToolsCarouselView: View {
    @State private var selectedCategory: StomaCategory? = nil
    let categories = [nil] + StomaCategory.allCases

    @State private var showCategoryPicker: Bool = false
    @State var selectedItem: InfoItem?

    var filteredItems: [InfoItem] {
        items.filter { selectedCategory == nil || $0.categories.contains(selectedCategory!) }
    }

    var body: some View {
        VStack {
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

            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(filteredItems) { item in
                        /*InfoItemCardView(
                            title: item.title,
                            subtitle: "", // Not used
                            imageName: "", // Not used
                            imageModal: item.modelName,
                            description: item.description,
                            navView: {
                                ItemView(selectedItem: item)
                            }
                        )*/
                        /*/.onTapGesture {
                            selectedItem = item
                        }*/
                        //.padding()
                    }
                }
                .padding(.horizontal)
            }
        }
        .navigationTitle("Tools")
        .sheet(item: $selectedItem) { item in
            ItemView(selectedItem: item)
        }
    }
}

#Preview {
    ToolsCarouselView()
}
