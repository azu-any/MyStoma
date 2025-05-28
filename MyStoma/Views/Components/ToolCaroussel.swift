//
//  MenuCaroussel 2.swift
//  MyStoma
//
//  Created by Martha Mendoza Alfaro on 28/05/25.
//

import SwiftUI

struct ToolCaroussel: View {
    let items: [InfoItem]
    
    @Binding var selectedItem: InfoItem?
    
    private var sortedItems: [InfoItem] {
        items.sorted {String(describing: $0.title) < String(describing: $1.title)
        }
    }
    
    var body: some View {
        HStack {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(sortedItems) { item in
                        InfoItemCardView(item: item)
                        .padding()
                       
                    }
                }
                //.padding()
            }
        }
    }
}

#Preview {
    ToolCaroussel(items: items, selectedItem: .constant(nil))
}
