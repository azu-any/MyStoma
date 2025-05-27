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
                .ignoresSafeArea(edges: .bottom)
                .padding(.leading)
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
                
                ZStack(alignment: .center) {
                    
                    Image("chart-bg")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    
                    VStack {
                        
                        ChartNurseView()
                            .edgesIgnoringSafeArea([.top])
                                                        
                        if showDialogue {
                            ChatBotOverlay(
                                showDialogue: $showDialogue,
                                showEnd: $showEnd,
                                showInventory: $showInventory)
                                .environmentObject(ostomyViewModel)
                                .environmentObject(viewModel)
                        } else {
                            
                            if showEnd {
                                Text("Congratulations!")
                                Text("You have completed the colostomy tutorial")
                            } else {
                                QuestionView(question: ostomyViewModel.ostomy.steps[ostomyViewModel.currentStepIndex].question, answers: ostomyViewModel.ostomy.steps[ostomyViewModel.currentStepIndex].answers,
                                             showDialogue: $showDialogue
                                )
                                .padding()
                            }
                        }
                        
                        Spacer()
                        
                        if showInventory {
                            
                            VStack {
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
                                .padding()
                                
                            }
                        
                        }
                        
                        if showDialogue {
                            
                            
                            HStack {
                                
                                Button {
                                    ostomyViewModel.currentDialogueIndex -= 1
                                } label: {
                                    Image(systemName: "chevron.left.circle.fill")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 30, height: 30)
                                }
                                .disabled(!canGoBack(index: ostomyViewModel.currentDialogueIndex))
                                
                                Spacer()
                                
                                
                                if ostomyViewModel.currentStepIndex == ostomyViewModel.ostomy.steps.count - 1 {
                                    Button {
                                        showEnd = true
                                    } label: {
                                        Text("End")
                                    }
                                    .disabled(!ostomyViewModel.isDone)
                                }
                                
                                else if ostomyViewModel.currentDialogueIndex == ostomyViewModel.ostomy.steps[ostomyViewModel.currentStepIndex].dialogues.count - 1 {
                                    Button {
                                        ostomyViewModel.currentStepIndex += 1
                                        ostomyViewModel.currentDialogueIndex = 0
                                        ostomyViewModel.isDone = false
                                        showInventory = false
                                        ostomyViewModel.spaceID = ColostomySpaces[ostomyViewModel.currentStepIndex].id
                                        
                                        viewModel.items.removeAll()
                                        
                                    } label: {
                                        Text("Next step")
                                    }
                                    .disabled(!ostomyViewModel.isDone)
                                }
                                
                                Spacer()
                                
                                
                                Button {
                                    if ostomyViewModel.ostomy.steps[ostomyViewModel.currentStepIndex].timeQuestion == ostomyViewModel.currentDialogueIndex {
                                        showDialogue.toggle()
                                        
                                    }
                                    
                                    else if !showInventory && ostomyViewModel.currentDialogueIndex >= ostomyViewModel.ostomy.steps[ostomyViewModel.currentStepIndex].timePractice {
                                        
                                        showInventory = true
                                        viewModel.items.append(contentsOf: ColostomySpaces[ostomyViewModel.currentStepIndex].items)
                                        
                                    }
                                    ostomyViewModel.currentDialogueIndex += 1
                                } label: {
                                    Image(systemName: "chevron.right.circle.fill")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 30, height: 30)
                                }
                                .disabled(!canGoForward(index: ostomyViewModel.currentDialogueIndex, count: ostomyViewModel.ostomy.steps[ostomyViewModel.currentStepIndex].dialogues.count))
                            }
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


struct ChartNurseView: View {
    
    @EnvironmentObject var ostomyViewModel: OstomyViewModel

    var body : some View {
        HStack (spacing: 12) {
            Image("NurseLeft")
                .resizable()
                .frame(width: 120, height: 120)
                .offset(y: 4)
                .background {
                    Rectangle()
                      .foregroundColor(.clear)
                      .frame(width: 124, height: 124)
                      .background(Color(red: 0.19, green: 0.28, blue: 0.34))
                      .cornerRadius(20)
                      .overlay(
                        RoundedRectangle(cornerRadius: 20)
                          .inset(by: 0.5)
                          .stroke(Color(red: 0.42, green: 0.6, blue: 0.74), lineWidth: 1)
                      )
                      .offset(y: 2)
                }

            
            
            VStack(spacing: 12) {
                Text("Step \(ostomyViewModel.currentStepIndex + 1)")
                    .foregroundStyle(.white)
                    .italic()
                    .bold()
                    .frame(width: 240, height: 25)
                    .background {
                        Rectangle()
                            .foregroundColor(.clear)
                            .background(Color(red: 0.42, green: 0.6, blue: 0.74))
                            .cornerRadius(20)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .inset(by: 0.5)
                                    .stroke(Color(red: 0.42, green: 0.6, blue: 0.74), lineWidth: 1)
                            )
                    }
                
                Text(ostomyViewModel.ostomy.steps[ostomyViewModel.currentStepIndex].name)
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.white)
                    .italic()
                    .bold()
                    .frame(width: 240, height: 80)
                    .background {
                        Rectangle()
                            .foregroundColor(.clear)
                            .background(Color(red: 0.42, green: 0.6, blue: 0.74))
                            .cornerRadius(20)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .inset(by: 0.5)
                                    .stroke(Color(red: 0.42, green: 0.6, blue: 0.74), lineWidth: 1)
                            )
                    }
            }
            
            
        }
    }
}
