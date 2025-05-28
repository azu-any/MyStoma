//
//  InventoryItemsView.swift
//  MyStoma
//
//  Created by Azuany Mila Cerón on 28/05/25.
//
import SwiftUI
import RealityKit


struct InventoryItemsView: View {
    @EnvironmentObject var ostomyViewModel: OstomyViewModel
    var stomaSizerEntity: Entity?

    var body: some View {
        VStack {
            Text("Tap and hold to drag items")
                .font(.caption)
                .foregroundStyle(.secondary)
            HStack(spacing: 16) {
                ForEach(ostomyViewModel.items) { item in
                    
                    VStack {
                        Image(item.imageName)
                            .resizable()
                            .scaledToFit()
                            .padding(10)
                            .frame(width: 100, height: 100)
                            .draggable(item) {
                                Image(item.imageName)
                            }
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(8)
                            .dropDestination(for: InventoryItem.self) { droppedItems, index in
                                let result = ostomyViewModel.handleMaterialItems(droppedItems: droppedItems)
                                
                                if result == "TrashBag" {
                                    ostomyViewModel.isDone = true
                                    return true
                                }
                                
                                else if result == "Scissors" {
                                    stomaSizerEntity?.isEnabled = false
                                    ostomyViewModel.isDone = true
                                }
                                return false
                            }
                            .padding([.top, .horizontal], 5)
                        
                        Text(item.name)
                            .multilineTextAlignment(.center)
                            .frame(width: 110, height: 40)
                            .font(.caption)
                    }
                }
            }
        }
    }
}
