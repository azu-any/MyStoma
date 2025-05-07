//
//  ContentView.swift
//  MyStoma
//
//  Created by Azuany Mila Cerón on 29/04/25.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct ModelVPView: View {

    var body: some View {
        
        Model3D(named: "HumanModel", bundle: realityKitContentBundle)
        
    }
}

#Preview(windowStyle: .automatic) {
    BagRemovalVPView()
        .environment(AppModel())
}
