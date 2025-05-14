import SwiftUI


import SwiftUI
import RealityKit


struct ColostomyView: View {
    
    @State var initialPosition: SIMD3<Float>? = nil
    @State var initialRotation: simd_quatf? = nil
    
    @ObservedObject private var viewModel = InventoryViewModel()
    
    
    let colostomySteps = [
        "Step 1: Wash your hands thoroughly.",
        "Step 2: Gather all necessary supplies.",
        "Step 3: Gently remove the used pouch.",
        "Step 4: Clean the stoma and surrounding skin.",
        "Step 5: Apply a new pouch securely.",
        "Step 6: Dispose of used materials and wash hands again."
    ]
    
    var translationGesture: some Gesture {
        DragGesture()
            .targetedToAnyEntity()
            .onChanged({ value in
                /// The entity that the drag gesture targets.
                let draggedEntity = value.entity

                if initialPosition == nil {
                    initialPosition = draggedEntity.position
                    initialRotation = draggedEntity.transform.rotation
                }

                /*let movement = value.convert(value.translation3D, from: .global, to: .scene)
                
                draggedEntity.position = (initialPosition ?? .zero) + movement
                
                if let initialRotation = initialRotation {
                    draggedEntity.transform.rotation = initialRotation
                }*/

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
                
                else if draggedEntity.name == "cleanStomabag" {
                    if isObjectNearTableSurface(itemPosition: draggedEntity.position) {
                        
                        draggedEntity.position = cleanBagPosition
                        
                        rotateEntity(draggedEntity, xDegrees: 0, yDegrees: 0)
                    }
                }
                
            })
    }
    
    
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                
                /*Image("Union")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: 300, maxHeight: 300)*/
                
                RealityView { content in
                    content.camera = .virtual
                    
                    if let body = try? await ModelEntity(named: "StomaBody") {
                        
                        body.components.set(InputTargetComponent())
                        content.add(body)
                    }
                }
                .gesture(DragGesture())
                
                Spacer()
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 16) {
                        ForEach(viewModel.items) { item in
                            VStack {
                                Image(item.imageName)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 100, height: 100)
                                    .background(Color.white.opacity(0.2))
                                    .cornerRadius(8)
                                Text(item.name)
                                    .font(.caption)
                                    .foregroundColor(.white)
                            }
                        }
                    }
                    .padding(.horizontal)
                }
                .padding()
                .background(Color.bluePrimary)
                .cornerRadius(20)
                .padding()
            }
        }
        .overlay(
            ChatBotOverlay(steps: colostomySteps)
                .environmentObject(viewModel)
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.bottom, 200)
                .padding(.trailing, 16), alignment: .leading
        )
        .padding()
        .navigationTitle("Colostomy")
    }
}

#Preview {
    ColostomyView()
}
