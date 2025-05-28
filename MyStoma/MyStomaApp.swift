//
//  MyStomaApp.swift
//  MyStoma
//
//  Created by Azuany Mila Cerón on 29/04/25.
//

import SwiftUI

@main
struct MyStomaApp: App {

    @State private var appModel = AppModel()
    @StateObject var viewModel = OstomyViewModel(ostomy: loadOstomyFromBundle() ?? defaultOstomy)
    @StateObject var router = NavigationRouter()
    @AppStorage("useDyslexiaFont") var useDyslexiaFont: Bool = false


    var body: some Scene {
        
        // Menu
        WindowGroup() {
            ContentView()
                .environment(appModel)
                .environmentObject(viewModel)
                .environment(\.font, useDyslexiaFont ? .custom("OpenDyslexic-Regular", size: 17) : .body)

        }
        #if os(visionOS)
        .defaultSize(width: 650, height: 500)
        #endif

        #if os(visionOS)
        ImmersiveSpace(id: ColostomySpace.first.id) {
            ColostomyFirstView()
                .environment(appModel)
                .environmentObject(viewModel)
                .onAppear {
                    appModel.immersiveSpaceState = .open
                }
                .onDisappear {
                    appModel.immersiveSpaceState = .closed
                }
        }
        .immersionStyle(selection: .constant(.mixed), in: .mixed)

        ImmersiveSpace(id: ColostomySpace.second.id) {
            ColostomySecondView()
                .environment(appModel)
                .environmentObject(viewModel)
                .onAppear {
                    appModel.immersiveSpaceState = .open
                }
                .onDisappear {
                    appModel.immersiveSpaceState = .closed
                }
        }
        .immersionStyle(selection: .constant(.mixed), in: .mixed)
       
        ImmersiveSpace(id: ColostomySpace.third.id) {
            ColostomyThirdView()
                .environment(appModel)
                .environmentObject(viewModel)
                .onAppear {
                    appModel.immersiveSpaceState = .open
                }
                .onDisappear {
                    appModel.immersiveSpaceState = .closed
                }
        }
        .immersionStyle(selection: .constant(.mixed), in: .mixed)
       
        ImmersiveSpace(id: ColostomySpace.fourth.id) {
            ColostomyFourthView()
                .environment(appModel)
                .environmentObject(viewModel)
                .onAppear {
                    appModel.immersiveSpaceState = .open
                }
                .onDisappear {
                    appModel.immersiveSpaceState = .closed
                }
        }
        .immersionStyle(selection: .constant(.mixed), in: .mixed)
        
        ImmersiveSpace(id: ColostomySpace.fifth.id) {
            ColostomyFifthView()
                .environment(appModel)
                .environmentObject(viewModel)
                .onAppear {
                    appModel.immersiveSpaceState = .open
                }
                .onDisappear {
                    appModel.immersiveSpaceState = .closed
                }
        }
        .immersionStyle(selection: .constant(.mixed), in: .mixed)

        ImmersiveSpace(id: ColostomySpace.sixth.id) {
            ColostomySixthView()
                .environment(appModel)
                .environmentObject(viewModel)
                .onAppear {
                    appModel.immersiveSpaceState = .open
                }
                .onDisappear {
                    appModel.immersiveSpaceState = .closed
                }
        }
        .immersionStyle(selection: .constant(.mixed), in: .mixed)

    
        ImmersiveSpace(id: ColostomySpace.seventh.id) {
            ColostomySeventhView()
                .environment(appModel)
                .environmentObject(viewModel)
                .onAppear {
                    appModel.immersiveSpaceState = .open
                }
                .onDisappear {
                    appModel.immersiveSpaceState = .closed
                }
        }
        .immersionStyle(selection: .constant(.mixed), in: .mixed)

        ImmersiveSpace(id: ColostomySpace.eighth.id) {
            ColostomyEighthView()
                .environment(appModel)
                .environmentObject(viewModel)
                .onAppear {
                    appModel.immersiveSpaceState = .open
                }
                .onDisappear {
                    appModel.immersiveSpaceState = .closed
                }
        }
        .immersionStyle(selection: .constant(.mixed), in: .mixed)

        ImmersiveSpace(id: ColostomySpace.ninth.id) {
            ColostomyNinthView()
                .environment(appModel)
                .environmentObject(viewModel)
                .onAppear {
                    appModel.immersiveSpaceState = .open
                }
                .onDisappear {
                    appModel.immersiveSpaceState = .closed
                }
        }
        .immersionStyle(selection: .constant(.mixed), in: .mixed)
        #endif
        
        
     }
}
