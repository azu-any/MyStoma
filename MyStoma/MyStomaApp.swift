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
        WindowGroup(id: Windows.menu.id) {
            ContentView()
                .environment(appModel)
        }
        .windowResizability(.contentSize)
        
        
        
        // Model
        WindowGroup(id: Windows.model.id) {
            ModelVPView()
                .environment(appModel)
        }
        .defaultSize(width: 1, height: 1, depth: 0.5, in: .meters)
        .windowStyle(.volumetric)
        
        
        // Info
        WindowGroup(id: Windows.info.id) {
            InfoVPView()
                .environment(appModel)
        }
        .defaultSize(width: 1, height: 0.5, depth: 0.5, in: .meters)
        .windowStyle(.volumetric)
        


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
     }
}
