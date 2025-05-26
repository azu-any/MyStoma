//
//  ImmersiveView.swift
//  MyStoma
//
//  Created by Azuany Mila Cerón on 29/04/25.
//

import SwiftUI
import RealityKit
import simd


struct ColostomyFirstView: View {
    
    let customMaterial =  PhysicsMaterialResource.generate(staticFriction: 0.0, dynamicFriction: 0.0, restitution: 0.0)
    
    @EnvironmentObject var viewModel: OstomyViewModel

    @State var initialPosition: SIMD3<Float>? = nil
    @State var initialRotation: simd_quatf? = nil
    @State var wasteBagEntity: Entity? = nil
    @State var stomabagEntity: Entity? = nil
    
    /// The gesture checks whether there is a root component and adjusts the postion of the entity.
    var translationGesture: some Gesture {
        /// The gesture to move an entity.
       
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

                if draggedEntity.name == "stomabag" {
                    
                    let distance = simd_distance(currentPosition, stomaTargetPosition)
                    
                    if distance > 0.02 {
                        if let stoma = draggedEntity.parent?.findEntity(named: "stoma") {
                            stoma.isEnabled = true
                        }
                    } else {
                        if let stoma = draggedEntity.parent?.findEntity(named: "stoma") {
                            stoma.isEnabled = false
                        }
                    }
                    
                    if simd_distance(currentPosition, wasteBagEntity!.position) < 0.25 {
                        draggedEntity.isEnabled = false
                        
                        showStomaWasteBag(wasteBagEntity!, true)
                        
                        wasteBagEntity!.playAnimation(wasteBagEntity!.availableAnimations[0])

                        viewModel.isDone = true
                    }
                }
                
                else if draggedEntity.name == "bottle" {
                    if simd_distance(currentPosition, stomaTargetPosition) < 0.2  {
                        
                        draggedEntity.isEnabled = false
                        
                        stomabagEntity!.components.set(InputTargetComponent())
                        
                        //draggedEntity.playAnimation(draggedEntity.availableAnimations[0])
                        
                        
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
                
                if draggedEntity.name == "stomabag" {
                    if simd_distance(currentPosition, stomaTargetPosition) < threshold {
                        draggedEntity.position = stomaTargetPosition
                        if let stoma = draggedEntity.parent?.findEntity(named: "stoma") {
                            stoma.isEnabled = false
                        }
                    } else if simd_distance(currentPosition, wasteBagEntity!.position) < 0.25 {
                        draggedEntity.isEnabled = false
                        viewModel.isDone = true
                    }
                }
                
                else if draggedEntity == wasteBagEntity {
                    if isObjectNearTableSurface(itemPosition: draggedEntity.position) {
                        
                        draggedEntity.position = wasteBagTargetPosition
                        
                        rotateEntity(draggedEntity, xDegrees: -90, yDegrees: 0)
                    }
                }
                
                else if draggedEntity.name == "cleanStomabag" {
                    if isObjectNearTableSurface(itemPosition: draggedEntity.position) {
                        
                        draggedEntity.position = cleanBagPosition
                        
                        rotateEntity(draggedEntity, xDegrees: 0, yDegrees: 0)
                    }
                }
                
                else if draggedEntity.name == "bottle" {
                    if isObjectNearTableSurface(itemPosition: draggedEntity.position) {
                        
                        draggedEntity.position = bottleTargetPosition
                        
                        rotateEntity(draggedEntity, xDegrees: 0, yDegrees: 0)
                    }
                    
                    else if simd_distance(currentPosition, stomaTargetPosition) < threshold  {
                        
                        draggedEntity.isEnabled = false
                        
                        if let bag = stomabagEntity {
                            bag.components.set(InputTargetComponent())
                            
                            print("hi")
                        }
                        
                        
                        /*draggedEntity.playAnimation(AnimationResource, transitionDuration: TimeInterval, startsPaused: Bool)*/
                        
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
                    material: customMaterial,
                    mode: .dynamic
                ))
                bag.physicsBody?.isAffectedByGravity = false
                
                bag.components.set(PhysicsMotionComponent(
                    linearVelocity: .zero,
                    angularVelocity: .zero
                ))
                
                stomabagEntity = bag
                
                //bag.components.set(InputTargetComponent())
                
                
                // Waste bag
                let wasteBag = try await Entity(named: "bin")
                //wasteBag.name = "wasteBag"
                wasteBag.position = wasteBagTargetPosition
                wasteBag.transform.scale = [0.3, 0.3, 0.3]
                rotateEntity(wasteBag, xDegrees: -90, yDegrees: 0)
                
                showStomaWasteBag(wasteBag, false)
                printHierarchy(of: wasteBag)
                                
                // Collision shape
                if let vertEntity = wasteBag.findEntity(named: "Vert") {
                    
                    
                    if let vertModelEntity = vertEntity.children.first(where: { $0.name == "Vert" }) as? ModelEntity {
                                                
                        
                        vertModelEntity.components[CollisionComponent.self] = await CollisionComponent(
                            shapes: [try ShapeResource.generateConvex(from: vertModelEntity.model!.mesh)]
                        )
                        
                        vertModelEntity.components.set(PhysicsBodyComponent(
                            massProperties: .default,
                            material: customMaterial,
                            mode: .dynamic
                        ))
                        
                        if var physics = vertModelEntity.components[PhysicsBodyComponent.self] {
                            physics.isAffectedByGravity = false
                            wasteBag.components.set(physics)
                        }
                        
                        vertModelEntity.components.set(PhysicsMotionComponent(
                            linearVelocity: .zero,
                            angularVelocity: .zero
                        ))
                        
                    }
                }
                
                wasteBag.components.set(InputTargetComponent())
                
                wasteBagEntity = wasteBag
                
                
                // Bottle
                let bottle = try await ModelEntity(named: "Bottle")
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
                
                
                // Add models
                content.add(body)
                content.add(table)
                content.add(bag)
                content.add(bottle)
                content.add(wasteBag)
            } catch {
                print("Failed to load model: \(error)")
            }
        } placeholder: {
            VStack(alignment: .center) {
                    ProgressView("Loading...")
                        .progressViewStyle(CircularProgressViewStyle())
                        .scaleEffect(2)
                    
            }
        }
        .gesture(translationGesture)
        
    }
}

#if os(visionOS)
#Preview(immersionStyle: .mixed) {
    ColostomyFirstView()
        .environment(AppModel())
}
#endif



func printHierarchy(of entity: Entity, indent: String = "") {
    print("\(indent)- \(entity.name) [\(type(of: entity))]")
    for child in entity.children {
        printHierarchy(of: child, indent: indent + "  ")
    }
}



func showStomaWasteBag(_ wasteBag: Entity, _ isShowing: Bool) {
    
    print("Searching for models in \(wasteBag.name)...")
    
    if let tap = wasteBag.findEntity(named: "Cube_001_001") {
        tap.isEnabled = isShowing
    }
    
    if let tap2 = wasteBag.findEntity(named: "Cube_002") {
        
        tap2.isEnabled = isShowing
    }
    
    if let tap3 = wasteBag.findEntity(named: "Cube_003") {
        
        tap3.isEnabled = isShowing
    }
}
