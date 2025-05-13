//
//  TypingTextView.swift
//  MyStoma
//
//  Created by Azuany Mila Cerón on 07/05/25.
//


import SwiftUI

struct TypingTextView: View {
    let fullText: String
    let trigger: Int  // Used to restart typing animation
    
    @State private var displayedText = ""
    @State private var currentIndex = 0
    let typingSpeed = 0.05
    @State private var timer: Timer?
        
    var body: some View {
        Text(displayedText)
            .multilineTextAlignment(.leading)
            .onChange(of: trigger) {
                startTyping()
            }
            .onAppear {
                startTyping()
                
            }
            .onDisappear {
                timer?.invalidate()
            }
    }
    
    func startTyping() {
        // Cancel previous typing animation
        timer?.invalidate()
        
        // Reset text state
        displayedText = ""
        currentIndex = 0
        
        // Start new timer
        timer = Timer.scheduledTimer(withTimeInterval: typingSpeed, repeats: true) { timer in
            if currentIndex < fullText.count {
                let index = fullText.index(fullText.startIndex, offsetBy: currentIndex)
                displayedText += String(fullText[index])
                currentIndex += 1
            } else {
                timer.invalidate()
            }
        }
    }
}
