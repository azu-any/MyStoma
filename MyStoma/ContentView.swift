//
//  ContentView.swift
//  MyStoma
//
//  Created by Azuany Mila Cerón on 29/04/25.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct ContentView: View {
    
    @State private var isSelected: Bool = false
    
    
    var body: some View {
        
        VStack(spacing: 30) {
            
            if !isSelected  {
                Button {
                    isSelected = true
                } label: {
                    Text("Colostomy")
                }
                
                Button {
                    
                } label: {
                    
                    HStack {
                        Image(systemName: "lock.fill")
                        Text("Ileostomy")
                    }
                }
                
                ToggleColostomyButton()
            } else {
                InfoVPView()
            }
        }
        .ornament(attachmentAnchor: .scene(.top)) {
            OrnamentView()
        }
        
    }
}


struct OrnamentView: View {

    var body: some View {
        VStack {
            Image("Logo")
                .resizable()
                .scaledToFit()
                .frame(width: 200)
        }
        .padding()
        .glassBackgroundEffect()
        
    }
}

#Preview(windowStyle: .automatic) {
    ContentView()
        .environment(AppModel())
}
