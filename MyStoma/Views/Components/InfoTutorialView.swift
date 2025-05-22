//
//  InfoTutorialView.swift
//  MyStoma
//
//  Created by Frida Pérez Perfecto on 22/05/25.
//

import SwiftUI

struct InfoColostomyView: View {
    var body: some View {
        VStack {
            Text("Colostomy")
                .font(.largeTitle)
                .bold()
            Text("Information about Colostomy.")
                .padding()
            Spacer()
        }
        .navigationTitle("Colostomy")
    }
}

struct IleostomyView: View {
    var body: some View {
        VStack {
            Text("Ileostomy")
                .font(.largeTitle)
                .bold()
            Text("Information about Ileostomy.")
                .padding()
            Spacer()
        }
        .navigationTitle("Ileostomy")
    }
}

struct UrostomyView: View {
    var body: some View {
        VStack {
            Text("Urostomy")
                .font(.largeTitle)
                .bold()
            Text("Information about Urostomy.")
                .padding()
            Spacer()
        }
        .navigationTitle("Urostomy")
    }
}
