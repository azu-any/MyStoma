//
//  DialogueView.swift
//  MyStoma
//
//  Created by Azuany Mila Cerón on 08/05/25.
//
import SwiftUI

struct DialogueView: View {
    
    var dialogue: String
    @Binding var dialogueIndex: Int
    
    var body: some View {
        
        VStack {
            HStack {
                Image("Nurse")
                    .resizable()
                    .scaledToFit()
                    .clipShape(Circle())
                    .frame(width: 100, height: 100)
                
                TypingTextView(fullText: dialogue, trigger: dialogueIndex)
                    .frame(width: 400, height: 200)
            }
            
        }
    }
}
