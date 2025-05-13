//
//  ContentView.swift
//  MyStoma
//
//  Created by Azuany Mila Cerón on 29/04/25.
//

import SwiftUI
import RealityKit
import RealityKitContent


struct InfoVPView: View {
    
    @State private var index: Int = 0
    @State private var dialogueIndex: Int = 0
    @StateObject var viewModel = OstomyViewModel(ostomy: loadOstomyFromBundle() ?? defaultOstomy)
    
    @Environment(AppModel.self) private var appModel

    @Environment(\.dismissImmersiveSpace) private var dismissImmersiveSpace
    @Environment(\.openImmersiveSpace) private var openImmersiveSpace
    
    @State var showDialogue: Bool = true

    var body: some View {

        VStack(alignment: .center, spacing: 25) {
            
            HStack {
                Text("Step \(index+1): \(viewModel.ostomy.steps[index].name)")
                    .font(.title)

                Spacer()
                
                Text("\(index+1)/\(viewModel.ostomy.steps.count)")
                    .font(.title)
            }
            
            if showDialogue {
                
                let dialogue = $viewModel.ostomy.steps[index].dialogues[dialogueIndex]
                
                DialogueView(dialogue: dialogue.wrappedValue, dialogueIndex: $dialogueIndex)
                
                HStack {
                    Spacer()
                    Button {
                        dialogueIndex -= 1
                    } label: {
                        Image(systemName: "chevron.left")
                    }
                    .buttonStyle(.plain)
                    .disabled(!canGoBack(index: dialogueIndex))
                    
                    
                    Button {
                        if viewModel.ostomy.steps[index].timeQuestion == dialogueIndex {
                            showDialogue.toggle()
                        }
                        dialogueIndex += 1
                    } label: {
                        Image(systemName: "chevron.right")
                    }
                    .buttonStyle(.plain)
                    .disabled(!canGoForward(index: dialogueIndex, count: viewModel.ostomy.steps[index].dialogues.count))

                }
            } else {
                QuestionVPView(question: viewModel.ostomy.steps[index].question, answers: viewModel.ostomy.steps[index].answers,
                    showDialogue: $showDialogue
                )
            }
            
            if dialogueIndex == viewModel.ostomy.steps[index].dialogues.count - 1 && index < viewModel.ostomy.steps.count - 1 {
                
                Button {
                    index += 1
                    dialogueIndex = 0
                } label: {
                    Text("Continue")
                }
            }
            
        }
        .frame(width: 500)
        .padding(50)
        .onAppear {
            Task { @MainActor in
                switch appModel.immersiveSpaceState {
                    case .open:
                        appModel.immersiveSpaceState = .inTransition
                        await dismissImmersiveSpace()
                        // Don't set immersiveSpaceState to .closed because there
                        // are multiple paths to ImmersiveView.onDisappear().
                        // Only set .closed in ImmersiveView.onDisappear().

                    case .closed:
                        appModel.immersiveSpaceState = .inTransition
                        switch await openImmersiveSpace(id: appModel.immersiveSpaceID) {
                            case .opened:
                                // Don't set immersiveSpaceState to .open because there
                                // may be multiple paths to ImmersiveView.onAppear().
                                // Only set .open in ImmersiveView.onAppear().
                                break

                            case .userCancelled, .error:
                                // On error, we need to mark the immersive space
                                // as closed because it failed to open.
                                fallthrough
                            @unknown default:
                                // On unknown response, assume space did not open.
                                appModel.immersiveSpaceState = .closed
                        }

                    case .inTransition:
                        // This case should not ever happen because button is disabled for this case.
                        break
                }
            }
        }
    }
}


#Preview(windowStyle: .automatic) {
    InfoVPView()
        .environment(AppModel())
    }

