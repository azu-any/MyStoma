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

    var body: some Scene {
        
        // Menu
        WindowGroup() {
            ContentView()
                .environment(appModel)
        }
        #if os(visionOS)
        .defaultSize(width: 650, height: 500)
        #endif
        //.windowResizability(.contentSize)
        //.defaultSize()

        #if os(visionOS)
        ImmersiveSpace(id: appModel.immersiveSpaceID) {
            ImmersiveView()
                .environment(appModel)
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
