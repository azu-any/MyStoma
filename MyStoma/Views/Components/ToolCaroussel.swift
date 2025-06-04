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
                HStack(spacing: 20) {
                    ForEach(items) { item in
                        InfoItemCardView(item: item)
                    }
                }
                .padding(.horizontal)
                .padding(.vertical, 4) 
            }
        }
    }
}

#Preview {
    ToolCaroussel(items: items, selectedItem: .constant(nil))
}
