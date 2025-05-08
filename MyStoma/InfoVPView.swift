//
//  ContentView.swift
//  MyStoma
//
//  Created by Azuany Mila Cerón on 29/04/25.
//

import SwiftUI
import RealityKit
import RealityKitContent

let dialogues: [String] = [
    "Hi! I'm Anna, your virtual stoma care nurse. Welcome to StomaDida.",
    "I'll be here to guide you step by step through all the procedures needed to take care of your stoma easily and safely."
]


struct InfoVPView: View {
    
    @State private var index: Int = 0
    @StateObject var viewModel = OstomyViewModel(ostomy: loadOstomyFromBundle() ?? defaultOstomy)
    
    @Environment(AppModel.self) private var appModel

    @Environment(\.dismissImmersiveSpace) private var dismissImmersiveSpace
    @Environment(\.openImmersiveSpace) private var openImmersiveSpace
    
    @State var showDialogue: Bool = true

    var body: some View {

        VStack(alignment: .leading, spacing: 25) {
            
            HStack {
                Text("Step \(index+1): \(colostomySteps[index].name)")
                    .font(.title)

                Spacer()
                
                Text("\(index+1)/\(colostomySteps.count)")
                    .font(.title)
            }
            
            if showDialogue {
                
                let dialogue = $viewModel.ostomy.steps[0].dialogues[index]
                
                DialogueView(dialogue: dialogue.wrappedValue, dialogueIndex: $index)
                
                HStack {
                    Spacer()
                    Button {
                        index = decreaseIndex(currentIndex: index)
                    } label: {
                        Image(systemName: "chevron.left")
                    }
                    .buttonStyle(.plain)
                    
                    Button {
                        index = increaseIndex(currentIndex: index, count: viewModel.ostomy.steps[0].dialogues.count)
                    } label: {
                        Image(systemName: "chevron.right")
                    }
                    .buttonStyle(.plain)

                }
            } else {
                QuestionVPView(index: index)
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

func increaseIndex(currentIndex: Int, count: Int) -> Int {
    var index = currentIndex
    if currentIndex < count - 1 {
        index += 1
    }
    return index
}


func decreaseIndex(currentIndex: Int) -> Int {
    var index = currentIndex
    if currentIndex > 0 {
        index -= 1
    }
    return index
}


struct QuestionVPView: View {
    
    var index: Int

    var body: some View {

        VStack(alignment: .leading, spacing: 20) {
            
            Text(colostomySteps[index].question)
            
            let columns = [
                GridItem(.flexible()),
                GridItem(.flexible())
            ]

            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(colostomySteps[index].answers, id: \.self) { answer in
                    Button {
                        
                    } label: {
                        Text(answer)
                            .multilineTextAlignment(.center)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(.regularMaterial)
                            .cornerRadius(10)
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding()

        }
    }
}


#Preview(windowStyle: .automatic) {
    InfoVPView()
        .environment(AppModel())
    }

