//
//  SettingsView.swift
//  MyStoma
//
//  Created by Azuany Mila Cerón on 20/05/25.
//
import SwiftUI


struct SettingsView: View {
    
    var body: some View {
        
        HStack {
            Image("Logo")
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

#Preview {
    SettingsView()
}
