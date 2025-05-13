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
        
        #if os(visionOS)
        VStack(spacing: 30) {
            
            if !isSelected  {
                
                VStack (spacing: 30) {
                    
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
                    .disabled(true)
                    
                    Button {
                        
                    } label: {
                        
                        HStack {
                            Image(systemName: "lock.fill")
                            Text("Urostomy")
                        }
                    }
                    .disabled(true)

                    
                    //ToggleColostomyButton()

                }
                .padding(.vertical, 50)
            } else {
                InfoVPView()
            }
        }
        .ornament(attachmentAnchor: .scene(.top)) {
            OrnamentView(isSelected: $isSelected)
        }
        #endif
        
        #if iOS
        VStack {
            Text("Hi")
        }
        #endif
    }
}


struct OrnamentView: View {
    
    @Binding var isSelected: Bool

    var body: some View {
        HStack {
            Image("Logo")
                .resizable()
                .scaledToFit()
                .frame(width: 200)
                .foregroundStyle(.white, .white, .white)
                .padding()
                .padding(.bottom, -5)
            
            Button {
                isSelected = false
            } label: {
                Image(systemName: "line.3.horizontal.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 50)
                    .padding()
            }
            .buttonStyle(.plain)
        }
        .padding(.horizontal)
        .glassBackgroundEffect()
        
    }
}

#Preview(windowStyle: .automatic) {
    ContentView()
        .environment(AppModel())
}
