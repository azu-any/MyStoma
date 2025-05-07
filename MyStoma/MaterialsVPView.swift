//
//  ContentView.swift
//  MyStoma
//
//  Created by Azuany Mila Cerón on 29/04/25.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct MaterialsVPView: View {

    var body: some View {
        
        Model3D(named: "Scene", bundle: realityKitContentBundle)
        
    }
}

#Preview(windowStyle: .automatic) {
    BagRemovalVPView()
        .environment(AppModel())
}
