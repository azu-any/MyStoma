//
//  ImmersiveView.swift
//  MyStoma
//
//  Created by Azuany Mila Cerón on 29/04/25.
//

import SwiftUI
import RealityKit
import simd

struct ColostomyThirdView: View {
    
    @EnvironmentObject var viewModel: OstomyViewModel

    @State var initialPosition: SIMD3<Float>? = nil
    @State var initialRotation: simd_quatf? = nil
    @State var cleanbagEntity: Entity?
    @State var scissorsEntity: Entity?
    @State var stomasizerEntity: Entity?
    
    
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
                
                draggedEntity.position = (initialPosition ?? .zero) + movement
                
                if let initialRotation = initialRotation {
                    draggedEntity.transform.rotation = initialRotation
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
                
                if draggedEntity.name == "stomabag" {

                    if simd_distance(currentPosition, stomaTargetPosition) < threshold {
                        draggedEntity.position = stomaTargetPosition
                        if let stoma = draggedEntity.parent?.findEntity(named: "stoma") {
                            stoma.isEnabled = false
                        }
                    }
                }
                
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
                
                
                // Scissors
                let scissors = try await ModelEntity(named: "scissors")
                scissors.position = scissorsTargetPosition
                scissors.transform.scale = [0.05, 0.05, 0.05]

                // Collision shape
                scissors.components[CollisionComponent.self] = await CollisionComponent(shapes: [try ShapeResource.generateConvex(from: scissors.model!.mesh)])

                scissors.components.set(PhysicsBodyComponent(
                    massProperties: .default,
                    material: customMaterial,
                    mode: .dynamic
                ))
                
                if var physics = scissors.components[PhysicsBodyComponent.self] {
                    physics.isAffectedByGravity = false
                    scissors.components.set(physics)
                }
                
                scissors.components.set(InputTargetComponent())
                scissorsEntity = scissors
                
                // Measurement borad
                let stomasizer = try await ModelEntity(named: "StomaSizer")
                stomasizer.position = stomasizerTargetPosition
                stomasizer.transform.scale = [0.08, 0.08, 0.08]

                // Collision shape
                stomasizer.components[CollisionComponent.self] = await CollisionComponent(shapes: [try ShapeResource.generateConvex(from: stomasizer.model!.mesh)])

                stomasizer.components.set(PhysicsBodyComponent(
                    massProperties: .default,
                    material: customMaterial,
                    mode: .dynamic
                ))
                
                if var physics = stomasizer.components[PhysicsBodyComponent.self] {
                    physics.isAffectedByGravity = false
                    stomasizer.components.set(physics)
                }
                
                stomasizer.components.set(InputTargetComponent())
                stomasizerEntity = stomasizer
                
                // New stoma bag
                let cleanbag = try await ModelEntity(named: "Cleanstoma")
                cleanbag.position = cleanbagTargetPosition
                cleanbag.transform.scale = [0.2, 0.2, 0.2]

                // Collision shape
                cleanbag.components[CollisionComponent.self] = await CollisionComponent(shapes: [try ShapeResource.generateConvex(from: cleanbag.model!.mesh)])

                cleanbag.components.set(PhysicsBodyComponent(
                    massProperties: .default,
                    material: customMaterial,
                    mode: .dynamic
                ))
                
                if var physics = cleanbag.components[PhysicsBodyComponent.self] {
                    physics.isAffectedByGravity = false
                    cleanbag.components.set(physics)
                }
                
                cleanbag.components.set(InputTargetComponent())
                cleanbagEntity = cleanbag
                
                
                // Add models
                content.add(body)
                content.add(table)
                content.add(scissors)
                content.add(stomasizer)
                content.add(cleanbag)

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
    ColostomyThirdView()
        .environment(AppModel())
}
#endif

