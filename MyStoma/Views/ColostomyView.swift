import SwiftUI


import SwiftUI
import RealityKit


struct ColostomyView: View {

    @State private var modelEntity: Entity? = nil
    @State private var bagEntity: Entity? = nil
    @State private var stomaEntity: Entity? = nil
    @State private var stomaSizerEntity: Entity? = nil
    @State private var currentAngle: Float = 0.0
    
    @State var showDialogue: Bool = true
    @State var showInventory: Bool = false
    @State var showEnd: Bool = false
        
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
            HStack(spacing: 50) {
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
                    
                    // TODO: Add barrier ring
                    /*if let stomaSizer = try? await ModelEntity(named: "StomaSizer") {
                        stomaSizer.scale = [0.105, 0.105, 0.105]
                        stomaSizer.position = [0.11, 1.02, 0.175]
                        rotateEntity(stomaSizer, xDegrees: -90, yDegrees: 20)
                        wrapper.addChild(stomaSizer)
                        stomaSizerEntity = stomaSizer
                        stomaSizerEntity?.isEnabled = false
                    }*/
                        
                    modelEntity = wrapper
                    content.add(wrapper)
                }
                .frame(width: 450)
                .gesture(translationGesture)
                .dropDestination(for: InventoryItem.self) { droppedItems, index in
                    let result = viewModel.handleBodyItems(droppedItems: droppedItems)
                    
                    if result == "RemoveBag" {
                        if let bag = bagEntity{
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
                        //ostomyViewModel.isDone = true
                    }
                    else if result == "Ring" {
                        // TODO: Add Ring to AR view
                        ostomyViewModel.isDone = true
                    }
                    else if result == "Cutstomabag" {
                        bagEntity?.isEnabled = true
                        stomaEntity?.isEnabled = false
                        ostomyViewModel.isDone = true
                    }
                    
                    return false
                }
                
                ZStack {
                    
                    RoundedRectangle(cornerRadius: 20)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .foregroundColor(.blue.opacity(0.2))
                        .padding(30)
                        .padding(.top, 10)
                        .overlay(alignment: .top) {
                            
                            ZStack {
                                RoundedRectangle(cornerRadius: 20)
                                    .foregroundColor(.blue)
                                
                                VStack {
                                    Text("Step \(ostomyViewModel.currentStepIndex + 1)")
                                        .font(.title3)
                                        .foregroundStyle(.white)
                                        .bold()
                                    
                                    Text("\(ostomyViewModel.ostomy.steps[ostomyViewModel.currentStepIndex].name)")
                                        .font(.title3)
                                        .foregroundStyle(.white)
                                }
                                .padding()
                            }
                            .frame(width: 300, height: 100)
                            .offset(y: -15)
                        }
                        .overlay(alignment: .topTrailing) {
                            Image("NurseRight")
                                .resizable()
                                .frame(width: 60, height: 60)
                                .clipShape(Circle())
                                .overlay(Circle().stroke(Color.white, lineWidth: 2))
                                .shadow(radius: 4)
                                .offset(x: -40, y: 50)
                        }

                    
                    VStack {
                        
                        ZStack {
                            RoundedRectangle(cornerRadius: 20)
                                //.frame(width: 400, height: 200)
                                .frame(maxWidth: .infinity, maxHeight: 250)
                                .padding(.horizontal, 60)
                                .padding(.top, 40)
                                .foregroundColor(.white)
                            
                            if showDialogue {
                                ChatBotOverlay(
                                    showDialogue: $showDialogue,
                                    showEnd: $showEnd,
                                    showInventory: $showInventory)
                                    .environmentObject(ostomyViewModel)
                                    .environmentObject(viewModel)
                                    .frame(maxWidth: .infinity, maxHeight: 240)
                                    .padding(.horizontal, 65)
                                    .padding(.vertical, 40)
                                    .padding(.top, 40)
                            } else {
                                
                                if showEnd {
                                    Text("Congratulations!")
                                    Text("You have completed the colostomy tutorial")
                                } else {
                                    QuestionView(question: ostomyViewModel.ostomy.steps[ostomyViewModel.currentStepIndex].question, answers: ostomyViewModel.ostomy.steps[ostomyViewModel.currentStepIndex].answers,
                                                 showDialogue: $showDialogue
                                    )
                                    .frame(maxWidth: .infinity, maxHeight: 180)
                                    .padding(.horizontal, 65)
                                    .padding(.vertical, 40)
                                    .padding(.top, 40)
                                }
                            }
                        }
                        
                        if showInventory {
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
                                                .draggable(item) {
                                                    Image(item.imageName)
                                                }
                                                .background(Color.gray.opacity(0.2))
                                                .cornerRadius(8)
                                                .dropDestination(for: InventoryItem.self) { droppedItems, index in
                                                    let result = viewModel.handleMaterialItems(droppedItems: droppedItems)
                                                    
                                                    if result == "TrashBag" {
                                                        ostomyViewModel.isDone = true
                                                        return true
                                                    }
                                                    
                                                    else if result == "Scissors" {
                                                        stomaSizerEntity?.isEnabled = false
                                                        ostomyViewModel.isDone = true
                                                        
                                                    }
                                                    
                                                    return false
                                                }
                                                .padding([.top, .horizontal], 5)
                                            
                                            
                                            Text(item.name)
                                                .multilineTextAlignment(.center)
                                                .frame(width: 100, height: 40)
                                                .font(.caption)
                                        }
                                    }
                                }
                                .padding(.horizontal)
                            }
                            .scrollBounceBehavior(.basedOnSize)
                            .frame(height: 150)
                            .padding()
                            .cornerRadius(20)
                            .padding()
                        
                        }
                    }
                    .frame(width: 550)
                }
            }
            
        }
        .padding()
        .navigationTitle("Colostomy")
        .onDisappear {
            ostomyViewModel.currentDialogueIndex = 0
        }
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

