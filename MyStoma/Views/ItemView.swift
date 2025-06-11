//
//  ItemView.swift
//  MyStoma
//
//  Created by Azuany Mila Cerón on 14/05/25.
//

import SwiftUI
import RealityKit
import simd


struct ItemView: View {
    
    var selectedItem: InfoItem
    @State private var modelEntity: Entity? = nil
    @State private var currentAngle: Float = 0.0
    @State private var showReality = false
    
    @Environment(\.openWindow) private var openWindow
    @Environment(\.openImmersiveSpace) private var openImmersiveSpace
    @Environment(\.dismissImmersiveSpace)
        private var dismissImmersiveSpace
    
    @EnvironmentObject var itemModel: ItemModel

    @Environment(\.dismiss) var dismiss

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            
            VStack(spacing: 20) {
                Text(selectedItem.title)
                    .font(.title)
                    .bold()
                    .multilineTextAlignment(.center)
                
                Text(selectedItem.description)

            }
            .padding()
            #if os(iOS)
            .toolbar {
                ToolbarItem {
                    Button("Close", systemImage: "xmark.circle.fill") {
                        dismiss()
                    }
                }
            }
            #endif
            
            #if os(visionOS)
            .ornament(attachmentAnchor: .scene(.bottom)) {
                Button("Close", systemImage: "xmark.circle.fill") {
                    dismiss()
                }
                .glassBackgroundEffect()
            }
            .onAppear {
                Task {
                    itemModel.selectedItem = ItemDetail(item: selectedItem)

                    print("loading")
                    await openImmersiveSpace(id: "item-view")
                }
            }
            .onDisappear {
                Task {
                    await dismissImmersiveSpace()
                }
            }
            #endif
            
            
            #if os(iOS)
            RealityView { content in
                content.camera = .virtual
                
                if let model = try? await ModelEntity(named: selectedItem.modelName) {
                    
                    model.components.set(InputTargetComponent())
                    model.position = selectedItem.modelPosition
                    model.transform.scale = selectedItem.modelScale
                    
                    if let degrees = selectedItem.modelRotation {
                        rotateEntity(model, xDegrees: degrees[0], yDegrees: degrees[1], zDegrees: degrees[2])
                    }
                    
                    let wrapper = Entity()
                    wrapper.addChild(model)
                    content.add(wrapper)
                    
                    modelEntity = wrapper
                    
                }
            } placeholder: {
                HStack {
                    Spacer()
                    ProgressView()
                    Spacer()
                }
            }
            .gesture(
                DragGesture()
                    .onChanged { value in
                        // Convert drag to horizontal angle
                        let delta = Float(value.translation.width)
                        let angle = currentAngle + delta * 0.01  // Sensitivity

                        if let model = modelEntity {
                            model.transform.rotation = simd_quatf(angle: angle, axis: [0, 1, 0])
                        }
                    }
                    .onEnded { value in
                        // Store the final angle
                        currentAngle += Float(value.translation.width) * 0.01
                    }
            )
            #endif
            
        }
        .padding()
    }
    
}
