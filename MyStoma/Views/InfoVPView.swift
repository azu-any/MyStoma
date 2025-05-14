//
//  ContentView.swift
//  MyStoma
//
//  Created by Azuany Mila Cerón on 29/04/25.
//

import SwiftUI
import RealityKit


struct InfoVPView: View {
    
    @EnvironmentObject var viewModel: OstomyViewModel
    
    @Environment(AppModel.self) private var appModel

#if os(visionOS)
    @Environment(\.dismissImmersiveSpace) private var dismissImmersiveSpace
    @Environment(\.openImmersiveSpace) private var openImmersiveSpace
    #endif

    @State var showDialogue: Bool = true
    @State var isDone: Bool = false

    var body: some View {

        VStack(alignment: .center, spacing: 25) {
            
            HStack {
                Text("Step \(viewModel.currentStepIndex + 1): \(viewModel.ostomy.steps[viewModel.currentStepIndex].name)")
                    .font(.title)

                Spacer()
                
                Text("\(viewModel.currentStepIndex + 1)/\(viewModel.ostomy.steps.count)")
                    .font(.title)
            }
            
            if showDialogue {
                DialogueView(showDialogue: $showDialogue)
                
            } else {
                QuestionVPView(question: viewModel.ostomy.steps[viewModel.currentStepIndex].question, answers: viewModel.ostomy.steps[viewModel.currentStepIndex].answers,
                    showDialogue: $showDialogue
                )
            }
            
            if viewModel.currentDialogueIndex == viewModel.ostomy.steps[viewModel.currentStepIndex].dialogues.count - 1 && viewModel.currentStepIndex < viewModel.ostomy.steps.count - 1 {
                
                Button {
                    viewModel.currentStepIndex += 1
                    viewModel.currentDialogueIndex = 0
                    viewModel.isDone = false
                    viewModel.spaceID = ColostomySpaces[viewModel.currentStepIndex].id
                    
                    #if os(visionOS)
                    Task { @MainActor in                        appModel.immersiveSpaceState = .inTransition
                        await dismissImmersiveSpace()
                        
                        appModel.immersiveSpaceState = .inTransition
                        switch await openImmersiveSpace(id: viewModel.spaceID) {
                        case .opened:
                            break
                            
                        case .userCancelled, .error:
                            fallthrough
                            
                        @unknown default:
                            appModel.immersiveSpaceState = .closed
                        }
                    }
                    #endif
                    
                } label: {
                    Text("Continue")
                }
                .disabled(!viewModel.isDone)
            }
            
        }
        .frame(width: 500)
        .padding(50)
        .onAppear {
            #if os(visionOS)
            Task { @MainActor in
                appModel.immersiveSpaceState = .inTransition
                switch await openImmersiveSpace(id: viewModel.spaceID) {
                case .opened:
                    break
                    
                case .userCancelled, .error:
                    fallthrough
                    
                @unknown default:
                    appModel.immersiveSpaceState = .closed
                }
            }
            #endif
        }
        .onDisappear {
            #if os(visionOS)
            Task { @MainActor in                        appModel.immersiveSpaceState = .inTransition
                await dismissImmersiveSpace()
            }
            #endif
        }
    }
}

#if os(visionOS)
#Preview(windowStyle: .automatic) {
    InfoVPView()
        .environment(AppModel())
        .environmentObject(OstomyViewModel(ostomy: defaultOstomy))
}
#endif


