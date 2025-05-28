//
//  ContentView.swift
//  MyStoma
//
//  Created by Azuany Mila Cerón on 29/04/25.
//

import SwiftUI
import RealityKit

struct ContentView: View {
    
    @EnvironmentObject var viewModel: OstomyViewModel
    //@StateObject private var router = NavigationRouter()
    @EnvironmentObject private var router: NavigationRouter

    //@State private var isSelected: Bool = false
    
    var body: some View {
        
        /*#if os(visionOS)
        NavigationStack {
            VStack(spacing: 30) {
                
                VStack (spacing: 30) {
                    
                    NavigationLink {
                        InfoVPView()
                            .environmentObject(viewModel)
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
                        
                    }
                .padding(.vertical, 50)
            }
            .ornament(attachmentAnchor: .scene(.top)) {
                OrnamentView()
                    .glassBackgroundEffect()
            }
            .ornament(attachmentAnchor: .scene(.bottom)) {
                BottomOrnamentView()
                    .glassBackgroundEffect()
            }
            
        }
        #endif
        
        #if os(iOS)*/
        MenuView()
            .environmentObject(NavigationRouter())
            .environmentObject(viewModel)
        //#endif
    }
}


struct OrnamentView: View {
    
    var body: some View {
        HStack {
            Image("LogoWhite")
                .resizable()
                .scaledToFit()
                .frame(width: 200)
                .padding()
                .padding(.bottom, -5)
                .foregroundStyle(.white, .white, .white)
        }
        .padding(.horizontal)
        
    }
}



    
    
struct BottomOrnamentView: View {
    
    var body: some View {
        NavigationStack{
            HStack {
                NavigationLink {
                    AppSettingsView()
                } label: {
                    Image(systemName: "gear")
                }
                
            }
            //.padding(.horizontal)
        }
        
    }
}

#Preview() {
    ContentView()
        .environment(AppModel())
        .environmentObject(OstomyViewModel(ostomy: loadOstomyFromBundle() ?? defaultOstomy))        
}
