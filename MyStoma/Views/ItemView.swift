//
//  ItemView.swift
//  MyStoma
//
//  Created by Azuany Mila Cerón on 14/05/25.
//

import SwiftUI
import RealityKit

struct ItemView: View {
    
    var selectedItem: InfoItem
    @State private var modelEntity: Entity? = nil
    @State private var currentAngle: Float = 0.0

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            
            VStack(spacing: 20) {
                Text(selectedItem.title)
                    .font(.title)
                    .bold()
                
                Text(selectedItem.description)
                    .font(.body)
            }
            .padding()
            
            #if os(iOS)
            RealityView { content in
                content.camera = .virtual
                
                if let model = try? await ModelEntity(named: selectedItem.modelName) {
                    
                    model.components.set(InputTargetComponent())
                    model.position = selectedItem.modelPosition
                    model.transform.scale = selectedItem.modelScale
                    
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

#Preview {
    ToolsView()
}
