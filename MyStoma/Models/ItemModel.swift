//
//  ItemModel.swift
//  MyStoma
//
//  Created by Azuany Mila Cerón on 10/06/25.
//

import SwiftUI

struct ItemDetail {
    let id = UUID()
    let item: InfoItem
}

class ItemModel: ObservableObject {
    @Published var selectedItem: ItemDetail?
}
