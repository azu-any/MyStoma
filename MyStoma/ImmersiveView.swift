//
//  ImmersiveView.swift
//  MyStoma
//
//  Created by Azuany Mila Cerón on 29/04/25.
//

import SwiftUI
import RealityKit
import RealityKitContent
import simd

struct ImmersiveView: View {
    
    @State var initialPosition: SIMD3<Float>? = nil
    @State var initialRotation: simd_quatf? = nil
    
    /// The initial scale of the entity.
    //@State var initialScale: SIMD3<Float>? = nil
    
    /// The gesture checks whether there is a root component and adjusts the postion of the entity.
    var translationGesture: some Gesture {
        /// The gesture to move an entity.
        DragGesture()
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
                
                if draggedEntity.name == "stomabag" {
                    let currentPosition = draggedEntity.position(relativeTo: nil)
                    let distance = simd_distance(currentPosition, stomaTargetPosition)
                    
                    if distance > 0.1 {
                        if let stoma = draggedEntity.parent?.findEntity(named: "stoma") {
                            stoma.isEnabled = true
                        }
                    } else {
                        if let stoma = draggedEntity.parent?.findEntity(named: "stoma") {
                            stoma.isEnabled = false
                        }
                    }
                }
                
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
                
                // Only apply snapping to "stomabag"
                if draggedEntity.name == "stomabag" {

                    print("stoma")
                    let distance = simd_distance(currentPosition, stomaTargetPosition)
                    if  distance < threshold {
                        draggedEntity.position = stomaTargetPosition
                        if let stoma = draggedEntity.parent?.findEntity(named: "stoma") {
                            stoma.isEnabled = false
                        }
                    }
                }
                
                // Only apply snapping to "wasteBag"
                else if draggedEntity.name == "wasteBag" {
                    print("wasteBag")

                    if isObjectNearTableSurface(itemPosition: draggedEntity.position) {
                        
                        draggedEntity.position = wasteBagTargetPosition
                        
                        rotateEntity(draggedEntity, xDegrees: 0, yDegrees: 0)
                    }
                }
            })
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
                let stoma = body.findEntity(named: "Human_Stomach")
                stoma!.isEnabled = false
                stoma!.name = "stoma"
                
                // Table
                let table = try await ModelEntity(named: "table")
                table.name = "table"
                table.position = tablePosition 
                rotateEntity(table, xDegrees: 0, yDegrees: 90)
                table.transform.scale = [0.009, 0.009, 0.009]
                //print(table.visualBounds(relativeTo: nil))
                
                // Collision shape
                table.components[CollisionComponent.self] = await CollisionComponent(shapes: [try ShapeResource.generateConvex(from: table.model!.mesh)])
                
                table.components.set(PhysicsBodyComponent(
                    massProperties: .default,
                    material: .default,
                    mode: .static
                ))
                
                // Stoma bag
                let bag = try await ModelEntity(named: "stomabag")
                bag.name = "stomabag"
                bag.position = stomaTargetPosition
                bag.transform.scale = [0.2, 0.2, 0.2]
                rotateEntity(bag, xDegrees: -96, yDegrees: -16)
                
                // Collision shape
                bag.components[CollisionComponent.self] = await CollisionComponent(shapes: [try ShapeResource.generateConvex(from: bag.model!.mesh)])
                
                bag.components.set(PhysicsBodyComponent(
                    massProperties: .default,
                    material: .default,
                    mode: .dynamic
                ))
                bag.physicsBody?.isAffectedByGravity = false
                bag.components.set(InputTargetComponent())
                
                
                // Waste bag
                let wasteBag = try await ModelEntity(named: "WasteBag")
                wasteBag.name = "wasteBag"
                wasteBag.position = wasteBagTargetPosition
                wasteBag.transform.scale = [0.1, 0.1, 0.1]
                //rotateEntity(wasteBag, xDegrees: -90, yDegrees: 0)
                
                // Collision shape
                wasteBag.components[CollisionComponent.self] = await CollisionComponent(shapes: [try ShapeResource.generateConvex(from: wasteBag.model!.mesh)])
                
                wasteBag.components.set(PhysicsBodyComponent(
                    massProperties: .default,
                    material: .default,
                    mode: .dynamic,
                ))
                wasteBag.physicsBody?.isAffectedByGravity = false
                wasteBag.components.set(PhysicsMotionComponent(
                    linearVelocity: .zero,
                    angularVelocity: .zero
                ))

                wasteBag.components.set(InputTargetComponent())
                
                // Add models
                content.add(body)
                content.add(table)
                content.add(bag)
                content.add(wasteBag)
            } catch {
                print("Failed to load model: \(error)")
            }
        } placeholder: {
            ProgressView()
        }
        .gesture(translationGesture)
        
    }
}

#Preview(immersionStyle: .mixed) {
    ImmersiveView()
        .environment(AppModel())
}
