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

    var body: some Scene {
        
        // Menu
        WindowGroup() {
            ContentView()
                .environment(appModel)
                .environmentObject(viewModel)

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
        #endif
        
        #if os(visionOS)
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
        #endif
     }
}
