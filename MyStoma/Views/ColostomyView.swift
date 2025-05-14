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
            .onChanged { value in
                // let entity = value.entity
                
                // Convert 2D drag translation to 3D movement
                /*let movement = value.convert(CGVector(dx: value.value.translation.width,
                                                      dy: value.value.translation.height), from: .local, to: .scene)

                // Apply the movement to the entity
                entity.position += SIMD3<Float>(Float(movement.x), 0, Float(movement.y))*/
            }
    }
    
    
    var body: some View {
        #if os(iPadOS)
        ZStack {
            VStack {
                //Spacer()
                
                /*Image("Union")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: 300, maxHeight: 300)*/
                
                
                
                RealityView { content in
                    content.camera = .virtual
                    
                    if let body = try? await ModelEntity(named: "StomaBody") {
                        
                        body.components.set(InputTargetComponent())
                        
                        body.position = [0, -1.2, 1.3]
                        content.add(body)
                    }
                }
                .gesture(DragGesture())
                
                //Spacer()
                
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
        .overlay(alignment: .topTrailing) {
            ChatBotOverlay(steps: colostomySteps)
                .environmentObject(viewModel)
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.bottom, 200)
                .padding(.trailing, 16)
        }
        .padding()
        .navigationTitle("Colostomy")
        #endif
    }
}

#Preview {
    NavigationStack {
        ColostomyView()
    }
}
