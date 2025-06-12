//
//  ImmersiveView.swift
//  MyStoma
//
//  Created by Azuany Mila Cerón on 29/04/25.
//

import SwiftUI
import RealityKit
import simd

struct ColostomySecondView: View {
    
    @EnvironmentObject var viewModel: OstomyViewModel

    @State var initialPosition: SIMD3<Float>? = nil
    @State var initialRotation: simd_quatf? = nil
    @State var waterBottle: Entity?
    @State var clothEntity: Entity?
    
    
    /// The gesture checks whether there is a root component and adjusts the postion of the entity.
    var translationGesture: some Gesture {
        /// The gesture to move an entity.
        DragGesture()
            #if os(visionOS)
            .targetedToAnyEntity()
            .onChanged({ value in
                /// The entity that the drag gesture targets.
                let draggedEntity = value.entity

                if initialPosition == nil {
                    initialPosition = draggedEntity.position
                    initialRotation = draggedEntity.transform.rotation
                }

                let movement = value.convert(value.translation3D, from: .global, to: .scene)
                
                let currentPosition = draggedEntity.position(relativeTo: nil)
                
                draggedEntity.position = (initialPosition ?? .zero) + movement
                
                if let initialRotation = initialRotation {
                    draggedEntity.transform.rotation = initialRotation
                }
                
                if let water = waterBottle, let cloth = clothEntity {
                    
                    let distance = simd_distance(water.position, cloth.position)
                    
                    if distance < 0.1 {
                        water.isEnabled = false
                        cloth.components.set(InputTargetComponent())
                    }
                }
                
                if let clothEntity = clothEntity {
                    let distance = simd_distance(clothEntity.position, stomaTargetPosition)
                    
                    if distance < 0.1 {
                        clothEntity.isEnabled = false
                        viewModel.isDone = true
                    }
                }

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
                
                // Body
                let body = try await Entity(named: "StomaBody")
                body.position = [1.0, 0, -1.5]
                rotateEntity(body, xDegrees: -90, yDegrees: -30)
                
                // Collision shape
                if let bodyModel = body.findEntity(named: "m_ca01_skeleton") as? ModelEntity {
                    
                    if let m = bodyModel.model {
                        
                        body.components[CollisionComponent.self] = await CollisionComponent(shapes: [try ShapeResource.generateConvex(from: m.mesh)])
                    }
                }
                
                body.components.set(PhysicsBodyComponent(
                    massProperties: .default,
                    material: .default,
                    mode: .static
                ))
                
                
                // Stoma
                /*let stoma = body.findEntity(named: "Human_Stomach")
                stoma!.isEnabled = false
                stoma!.name = "stoma"*/
                
                
                // Table
                let table = try await ModelEntity(named: "table")
                table.name = "table"
                table.position = tablePosition 
                rotateEntity(table, xDegrees: 0, yDegrees: 90)
                table.transform.scale = [0.009, 0.009, 0.009]
                
                // Collision shape
                table.components[CollisionComponent.self] = await CollisionComponent(shapes: [try ShapeResource.generateConvex(from: table.model!.mesh)])
                
                table.components.set(PhysicsBodyComponent(
                    massProperties: .default,
                    material: .default,
                    mode: .static
                ))
                
                
                // Cloth
                let cloth = try await ModelEntity(named: "Cloth")
                cloth.name = "cloth"
                cloth.position = clothTargetPosition
                cloth.transform.scale = [0.04, 0.04, 0.04]
                rotateEntity(cloth, xDegrees: 0, yDegrees: 0)

                // Collision shape
                cloth.components[CollisionComponent.self] = await CollisionComponent(shapes: [try ShapeResource.generateConvex(from: cloth.model!.mesh)])

                cloth.components.set(PhysicsBodyComponent(
                    massProperties: .default,
                    material: customMaterial,
                    mode: .dynamic
                ))
                
                if var physics = cloth.components[PhysicsBodyComponent.self] {
                    physics.isAffectedByGravity = false
                    cloth.components.set(physics)
                }
                clothEntity = cloth
                
                
                // Water
                let bottle = try await ModelEntity(named: "BottleWater")
                bottle.name = "bottle"
                bottle.position = bottleTargetPosition
                bottle.transform.scale = [0.04, 0.04, 0.04]

                // Collision shape
                bottle.components[CollisionComponent.self] = await CollisionComponent(shapes: [try ShapeResource.generateConvex(from: bottle.model!.mesh)])

                bottle.components.set(PhysicsBodyComponent(
                    massProperties: .default,
                    material: customMaterial,
                    mode: .dynamic
                ))
                
                if var physics = bottle.components[PhysicsBodyComponent.self] {
                    physics.isAffectedByGravity = false
                    bottle.components.set(physics)
                }
                
                bottle.components.set(InputTargetComponent())
                waterBottle = bottle
                
                // Add models
                content.add(body)
                content.add(table)
                content.add(bottle)
                content.add(cloth)

            } catch {
                print("Failed to load model: \(error)")
            }
        } placeholder: {
            ProgressView()
        }
        .gesture(translationGesture)
        
    }
}

#if os(visionOS)
#Preview(immersionStyle: .mixed) {
    ColostomySecondView()
        .environment(AppModel())
}
#endif

