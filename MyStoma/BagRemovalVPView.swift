//
//  ContentView.swift
//  MyStoma
//
//  Created by Azuany Mila Cerón on 29/04/25.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct BagRemovalVPView: View {

    var body: some View {
        
        VStack {
            
            HStack {
                Text("Step 1: Remove the bag")
                
                Text("1/5")
            }
        }
    }
}

#Preview(windowStyle: .automatic) {
    BagRemovalVPView()
        .environment(AppModel())
}
