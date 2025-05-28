import SwiftUI


import SwiftUI
import RealityKit


struct Colostomy2View: View {
    
    @EnvironmentObject var ostomyViewModel: OstomyViewModel
    

    @State var showRestart: Bool = false
    @State private var currentAngle: Float = 0.0
    @State private var modelEntity: Entity? = nil
    @State private var bagEntity: Entity? = nil
    @State private var stomaEntity: Entity? = nil
    @State private var stomaSizerEntity: Entity? = nil
    @State private var pasteEntity: Entity? = nil
    @State private var bottleEntity: Entity? = nil

    
    var translationGesture: some Gesture {
        DragGesture()
            .onChanged { value in
                // Convert drag to horizontal angle
                let delta = Float(value.translation.width)
                let angle = currentAngle + delta * 0.01  // Sensitivity

                /*if let model = modelEntity {
                    model.transform.rotation = simd_quatf(angle: angle, axis: [0, 1, 0])
                } else*/ if let bottle = bottleEntity {
                    bottle.position.x += delta
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
                .opacity(0.5)
            
            
            HStack(spacing: 10) {
                RealityView { content in
                    content.camera = .virtual
                    
                    //
                    let wrapper = Entity()
                    wrapper.setPosition([-0.3, -1.2, 1.3], relativeTo: nil)
                    
                    if let body = try? await Entity(named: "StomaBody") {
                        
                        body.components.set(InputTargetComponent())
                        
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
                    
                    // EQUIPMENT
                    
                    
                    // Bottle
                    if let bottle = try? await ModelEntity(named: "Bottle") {
                        bottle.name = "bottle"
                        bottle.position = [0.4, -0.2, 1.3]
                        bottle.scale = [0.04, 0.04, 0.04]

                        // Add Input Target for interaction
                        bottle.components.set(InputTargetComponent())

                        // Only add physics & collision if we can get the mesh
                        if let modelComponent = bottle.components[ModelComponent.self] {
                            do {
                                let mesh = modelComponent.mesh
                                // Generate convex shape safely
                                if let convexShape = try? await ShapeResource.generateConvex(from: mesh) {
                                    let collision = CollisionComponent(shapes: [convexShape])
                                    bottle.components[CollisionComponent.self] = collision

                                    // Set Physics Body
                                    var physics = PhysicsBodyComponent(
                                        massProperties: .default,
                                        material: customMaterial,
                                        mode: .dynamic
                                    )
                                    physics.isAffectedByGravity = false
                                    bottle.components.set(physics)

                             } else {
                                 print("Failed to generate convex shape")
                             }
                             // Set Physics Body
                             let physics = PhysicsBodyComponent(
                                 massProperties: .default,
                                 material: customMaterial,
                                 mode: .dynamic
                             )
                             bottle.components.set(physics)

                             // Modify physics properties
                             if var physicsBody = bottle.components[PhysicsBodyComponent.self] {
                                 physicsBody.isAffectedByGravity = false
                                 bottle.components.set(physicsBody)
                             }

                            }
                        }
                        
                        bottleEntity = bottle
                        content.add(bottle)
                    }
                    
                    
                    content.add(wrapper)
                    
                }
                .ignoresSafeArea(edges: .bottom)
                .padding(.leading)
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
                .overlay(alignment: .topTrailing) {
                    
                    ZStack(alignment: .center) {
                        
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
                        .padding(.top, 100)
                        .padding(.horizontal, 20)
                        .padding(.trailing, 50)
                        .padding(.bottom, 20)
                        .border(Color.red, width: 1)
                    }
                    #if os(iOS)
                    .frame(width: UIScreen.main.bounds.width * 0.4,
                           height: UIScreen.main.bounds.height * 0.3)
                #endif
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


