//
//  ImmersiveView.swift
//  MyStoma
//
//  Created by Azuany Mila Cerón on 29/04/25.
//

import SwiftUI
import RealityKit
import simd


struct ItemVRView: View {
    
    @EnvironmentObject var itemModel: ItemModel

    @State var initialPosition: SIMD3<Float>? = nil
    @State var initialRotation: simd_quatf? = nil
    
    var translationGesture: some Gesture {
       
        DragGesture()
        #if os(visionOS)
            .targetedToAnyEntity()
            .onChanged({ value in
                /// The entity that the< drag gesture targets.
                let draggedEntity = value.entity

                if initialPosition == nil {
                    initialPosition = draggedEntity.position
                    initialRotation = draggedEntity.transform.rotation
                }

                let movement = value.convert(value.translation3D, from: .global, to: .scene)
                
                draggedEntity.position = (initialPosition ?? .zero) + movement
                
                let currentPosition = draggedEntity.position(relativeTo: nil)

            })
            .onEnded({ value in
                
                let draggedEntity = value.entity
                let currentPosition = draggedEntity.position(relativeTo: nil)
                
                // Reset the `initialPosition` back to `nil` when the gesture ends.
                initialPosition = nil
                initialRotation = nil
                
                draggedEntity.components.set(PhysicsMotionComponent(
                    linearVelocity: .zero,
                    angularVelocity: .zero
                ))
        })
    #endif
    }
    
    
    var body: some View {
        RealityView { content in
            do {
                
                if let selectedItem = itemModel.selectedItem?.item , let model = try? await ModelEntity(named: selectedItem.modelName){
                                        
                    model.components.set(InputTargetComponent())
                    model.position = selectedItem.modelPosition
                    model.transform.scale = selectedItem.modelScale
                    
                    if let degrees = selectedItem.modelRotation {
                        rotateEntity(model, xDegrees: degrees[0], yDegrees: degrees[1], zDegrees: degrees[2])
                    }
                    
                    model.generateCollisionShapes(recursive: true)
                    
                    let wrapper = Entity()
                    wrapper.addChild(model)
                    //wrapper.components.set(InputTargetComponent())
                    wrapper.position = [0, 1, -1.6]
                    content.add(wrapper)
                    
                }
            }
        } placeholder: {
            HStack {
                Spacer()
                ProgressView()
                Spacer()
            }
        }
        .gesture(translationGesture)
        
    }
}
