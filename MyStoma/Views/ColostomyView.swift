import SwiftUI


import SwiftUI
import RealityKit


struct ColostomyView: View {
    
    @EnvironmentObject var ostomyViewModel: OstomyViewModel
    
    @State var showRestart: Bool = false
    @State private var currentAngle: Float = 0.0
    @State private var modelEntity: Entity? = nil
    @State private var bagEntity: Entity? = nil
    @State private var stomaEntity: Entity? = nil
    @State private var stomaSizerEntity: Entity? = nil
    @State private var pasteEntity: Entity? = nil

    
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
            
            Image("room-bg")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea(.all, edges: .bottom)
                .opacity(0.8)
            
            
            HStack(spacing: 10) {
                RealityView { content in
                    content.camera = .virtual
                    
                    let wrapper = Entity()
                    wrapper.setPosition([0, -1.2, 1.3], relativeTo: nil)
                    
                    if let body = try? await Entity(named: "StomaBody") {
                        
                        body.components.set(InputTargetComponent())
                        
                        let texture = try? await TextureResource(named: "DarkColor")
                        
                        // Load and apply texture
                        if let texture = try? await TextureResource.load(named: "DarkColor") {
                            if var modelComponent = body.components[ModelComponent.self] as? ModelComponent {
                                if var material = modelComponent.materials.first as? SimpleMaterial {
                                                
                                    /*/ ✅ Use MaterialParameters.Texture instead of Texture()
                                    material.baseColor = .init(
                                        texture: MaterialParameters.Texture(resource: texture)
                                    )
                                    
                                    modelComponent.materials = [material]
                                    body.components[ModelComponent.self] = modelComponent*/
                                }
                            }
                        }

                        // Apply it to the model's material
                        /*if var material = body.model?.materials.first as? SimpleMaterial {
                            material.baseColor = .texture(Texture(resource: texture))
                            body.model?.materials = [material]
                        }*/
                        /*if let modelComponent = body.components[ModelComponent.self] as? ModelComponent {
                            // Now you can access or modify the model properties
                            if var material = modelComponent.mesh.materials.first as? SimpleMaterial {
                                material.baseColor = .texture(Texture(resource: "DarkColor"))
                                modelComponent.mesh.materials = [material]

                                // Re-assign the updated model component back
                                modelEntity?.components[ModelComponent.self] = modelComponent
                            }
                        }*/
                        
                        if let stoma = body.findEntity(named: "Human_Stomach") {
                            stoma.name = "stoma"
                            stomaEntity = stoma
                            stomaEntity?.isEnabled = false
                        }
                        
                        wrapper.addChild(body)
                    }
                    
                    if let bag = try? await ModelEntity(named: "stomabag") {
                        bag.scale = [0.2, 0.2, 0.2]
                        bag.position = [0.057, 1.03, 0.195]
                        rotateEntity(bag, xDegrees: -90, yDegrees: 20)
                        wrapper.addChild(bag)
                        bagEntity = bag
                    }
                    
                    if let stomaSizer = try? await ModelEntity(named: "StomaSizer") {
                        stomaSizer.scale = [0.105, 0.105, 0.105]
                        stomaSizer.position = [0.11, 1.02, 0.175]
                        rotateEntity(stomaSizer, xDegrees: -90, yDegrees: 20)
                        wrapper.addChild(stomaSizer)
                        stomaSizerEntity = stomaSizer
                        stomaSizerEntity?.isEnabled = false
                    }
                    
                    if let paste = try? await ModelEntity(named: "Paste") {
                        paste.scale = [0.03, 0.03, 0.03]
                        paste.position = [0.068, 1.048, 0.19]
                        rotateEntity(paste, xDegrees: -90, yDegrees: 22)
                        wrapper.addChild(paste)
                        pasteEntity = paste
                        pasteEntity?.isEnabled = false
                    }
                        
                    modelEntity = wrapper
                    content.add(wrapper)
                }
                .ignoresSafeArea(edges: .bottom)
                .padding(.leading)
                .frame(width: 450)
                .gesture(translationGesture)
                .dropDestination(for: InventoryItem.self) { droppedItems, index in
                    let result = ostomyViewModel.handleBodyItems(droppedItems: droppedItems)
                    
                    print(result)
                    
                    if result == "RemoveBag" {
                        if let bag = bagEntity {
                            bag.isEnabled = false
                            stomaEntity?.isEnabled = true
                            return true
                        }
                    }
                    else if result == "Done" {
                        ostomyViewModel.isDone = true
                    }
                    else if result == "Measure" {
                        stomaSizerEntity?.isEnabled = true
                    }
                    else if result == "Ring" {
                        pasteEntity?.isEnabled = true
                        ostomyViewModel.isDone = true
                    }
                    else if result == "Cutstomabag" {
                        bagEntity?.isEnabled = true
                        stomaEntity?.isEnabled = false
                        ostomyViewModel.isDone = true
                    }
                    
                    return false
                }
                
                ZStack(alignment: .top) {
                    
                    Image("chart-bg")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    
                    VStack {
                        
                        ChartNurseView()
                            .edgesIgnoringSafeArea([.top])
                        
                        switch ostomyViewModel.viewState {
                        case .dialogue:
                            ChatBotOverlay()
                            .environmentObject(ostomyViewModel)
                            
                            Spacer()

                            if ostomyViewModel.showInventory && !ostomyViewModel.items.isEmpty {
                                InventoryItemsView(stomaSizerEntity: stomaSizerEntity)
                                    .environmentObject(ostomyViewModel)
                            }
                            
                            DialogueControlsView()
                                .environmentObject(ostomyViewModel)
                            
                        case .question:
                            QuestionView(question: ostomyViewModel.ostomy.steps[ostomyViewModel.currentStepIndex].question, answers: ostomyViewModel.ostomy.steps[ostomyViewModel.currentStepIndex].answers)
                                .environmentObject(ostomyViewModel)
                                .padding()
                            
                        case .end:
                            Spacer()
                            Text("Congratulations!")
                                .bold()
                                .padding()
                            Text("You have completed the colostomy tutorial.")
                            Spacer()
                        }
                        
                    }
                    .padding(.top, 150)
                    .padding(.horizontal, 125)
                    .padding(.bottom, 20)
                }
            }
        }
        .navigationTitle("Colostomy")
        .onDisappear {
            ostomyViewModel.restartTutorial()

        }
        .toolbar {
            
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    showRestart = true
                } label: {
                    Label("Restart", systemImage: "arrow.clockwise")
                }
                .alert("Restart tutorial", isPresented: $showRestart) {
                    Button("Cancel", role: .cancel) { }
                    Button("Restart", role: .destructive, action: restartTutorial)
                } message: {
                    Text("Are you sure you want to restart the tutorial? Your current progress will be lost.")
                }
            }
        }
        
    #endif
    }
    
    func restartTutorial() {
        ostomyViewModel.restartTutorial()
    }
}

#Preview {
    NavigationStack {
        ColostomyView()
            .environmentObject(OstomyViewModel(ostomy: loadOstomyFromBundle() ?? defaultOstomy))
    }
}


