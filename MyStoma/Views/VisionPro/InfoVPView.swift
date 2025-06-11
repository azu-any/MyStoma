//
//  ContentView.swift
//  MyStoma
//
//  Created by Azuany Mila Cerón on 29/04/25.
//

import SwiftUI
import RealityKit


struct InfoVPView: View {
    
    @EnvironmentObject var ostomyViewModel: OstomyViewModel
    
    @Environment(AppModel.self) private var appModel

    #if os(visionOS)
    @Environment(\.dismissImmersiveSpace) private var dismissImmersiveSpace
    @Environment(\.openImmersiveSpace) private var openImmersiveSpace
    #endif

    @State var showDialogue: Bool = true
    @State var isDone: Bool = false

    var body: some View {

        VStack(alignment: .center, spacing: 25) {
            
            VStack {

                Text("Step \(ostomyViewModel.currentStepIndex + 1)")
                    .bold()
                    .font(.title)
                
                Text(ostomyViewModel.ostomy.steps[ostomyViewModel.currentStepIndex].name)
                    .font(.largeTitle)
                    .multilineTextAlignment(.center)
                    .italic()
                    .bold()
                
            }
            
            /*if showDialogue {
                DialogueView(showDialogue: $showDialogue)
                
            } else {
                QuestionView(question: viewModel.ostomy.steps[viewModel.currentStepIndex].question, answers: viewModel.ostomy.steps[viewModel.currentStepIndex].answers
                )
            }*/
            
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
            
            if ostomyViewModel.currentDialogueIndex == ostomyViewModel.ostomy.steps[ostomyViewModel.currentStepIndex].dialogues.count - 1 && ostomyViewModel.currentStepIndex < ostomyViewModel.ostomy.steps.count - 1 {
                
                Button {
                    ostomyViewModel.currentStepIndex += 1
                    ostomyViewModel.currentDialogueIndex = 0
                    ostomyViewModel.isDone = false
                    ostomyViewModel.spaceID = ColostomySpaces[ostomyViewModel.currentStepIndex].id
                    
                    #if os(visionOS)
                    Task { @MainActor in                        appModel.immersiveSpaceState = .inTransition
                        await dismissImmersiveSpace()
                        
                        appModel.immersiveSpaceState = .inTransition
                        switch await openImmersiveSpace(id: ostomyViewModel.spaceID) {
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
                    Text("Next step")
                }
                .disabled(!ostomyViewModel.isDone)
            }
            
            Spacer()
            
        }
        .padding(50)
        .onAppear {
            #if os(visionOS)
            Task { @MainActor in
                appModel.immersiveSpaceState = .inTransition
                switch await openImmersiveSpace(id: ostomyViewModel.spaceID) {
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
            Task { @MainActor in
                appModel.immersiveSpaceState = .inTransition
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


