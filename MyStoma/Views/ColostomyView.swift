import SwiftUI


import SwiftUI
import RealityKit


struct ColostomyView: View {

    @State private var modelEntity: Entity? = nil
    @State private var bagEntity: Entity? = nil
    @State private var stomaEntity: Entity? = nil
    @State private var currentAngle: Float = 0.0
        
    @StateObject private var viewModel = InventoryViewModel()
    @EnvironmentObject var ostomyViewModel: OstomyViewModel
    
    var translationGesture: some Gesture {
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
    }
    
    
    var body: some View {
        #if os(iOS)
        ZStack {
            VStack {
                
                RealityView { content in
                    content.camera = .virtual
                    
                    let wrapper = Entity()
                    wrapper.setPosition([0, -1.2, 1.3], relativeTo: nil)
                    
                    if let body = try? await Entity(named: "StomaBody") {
                        
                       //body.position = [0, -1.2, 1.3]
                        body.components.set(InputTargetComponent())
                        
                        if let stoma = body.findEntity(named: "Human_Stomach") {
                            stoma.name = "stoma"
                            stomaEntity = stoma
                        }
                        
                        wrapper.addChild(body)
                    }
                    
                    if let bag = try? await ModelEntity(named: "stomabag") {
                        bag.isEnabled = false
                        bag.scale = [0.2, 0.2, 0.2]
                        bag.position = [0.055, 1.04, 0.195]
                        rotateEntity(bag, xDegrees: -90, yDegrees: 20)
                        wrapper.addChild(bag)
                        bagEntity = bag
                    }
                        
                    modelEntity = wrapper
                    content.add(wrapper)
                }
                .frame(width: 600)
                .gesture(translationGesture)
                .dropDestination(for: InventoryItem.self) { droppedItems, index in
                    viewModel.handleDroppedItems(droppedItems: droppedItems)
                    if let bag = bagEntity{
                        bag.isEnabled = true
                        stomaEntity?.isEnabled = false
                    }
                    return true
                }
                
                ScrollView(.horizontal, showsIndicators: false) {
                    
                    Spacer()
                        .containerRelativeFrame(.horizontal)
                    
                    HStack(alignment: .center, spacing: 16) {
                                                
                        ForEach(viewModel.items) { item in
                            VStack {
                                Image(item.imageName)
                                    .resizable()
                                    .scaledToFit()
                                    .padding(10)
                                    .frame(width: 100, height: 100)
                                    .background(Color.white)//.opacity(0.2))
                                    .cornerRadius(8)
                                    .padding([.top, .horizontal], 5)
                                    .draggable(item) {
                                        Image(item.imageName)
                                    }
                                
                                Text(item.name)
                                    .multilineTextAlignment(.center)
                                    .frame(width: 100, height: 40)
                                    .font(.caption)
                                    .foregroundColor(.white)
                            }
                        }
                    }
                    .padding(.horizontal)
                }
                .scrollBounceBehavior(.basedOnSize)
                .frame(height: 150)
                .padding()
                .background(Color.bluePrimary)
                .cornerRadius(20)
                .padding()
            }
        }
        .overlay(alignment: .topTrailing) {
            ChatBotOverlay()
                .environmentObject(ostomyViewModel)
                .frame(maxWidth: 500, maxHeight: 500,alignment: .topTrailing)
        }
        .allowsHitTesting(true)
        .padding()
        .navigationTitle("Colostomy")
        #endif
    }
}

#Preview {
    NavigationStack {
        ColostomyView()
            .environmentObject(OstomyViewModel(ostomy: loadOstomyFromBundle() ?? defaultOstomy)
            )

    }
}
