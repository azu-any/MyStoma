import SwiftUI


import SwiftUI
import RealityKit


struct ColostomyView: View {
    
    @State private var modelEntity: Entity? = nil
    @State private var currentAngle: Float = 0.0
        
    @ObservedObject private var viewModel = InventoryViewModel()
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
                Spacer()
                
                RealityView { content in
                    content.camera = .virtual
                    
                    if let body = try? await ModelEntity(named: "StomaBody") {
                        
                       // body.position = [0, -1.2, 1.3]
                        body.components.set(InputTargetComponent())
                        
                        let wrapper = Entity()
                        wrapper.setPosition([0, -1.2, 1.3], relativeTo: nil)
                        wrapper.addChild(body)
                        modelEntity = wrapper

                        content.add(wrapper)
                    }
                }
                .frame(width: 600)
                .gesture(translationGesture)
                
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
