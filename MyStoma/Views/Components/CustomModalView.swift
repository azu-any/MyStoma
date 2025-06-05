//
//  CustomModalView.swift
//  MyStoma
//
//  Created by Martha Mendoza Alfaro on 29/05/25.
//

import SwiftUI

struct CustomModalView: View {
    @EnvironmentObject var router: NavigationRouter
    @Environment(\.dismiss) var dismiss
    @Binding var isPresented: Bool
    let data: CardData
    @State private var showConfirmation = false
    
    var body: some View {
        ZStack {
            // Full screen glassmorphism background
            Rectangle()
                .opacity(0)
                .overlay(
                    // Glass grain effect
                    Rectangle()
                        .fill(
                            RadialGradient(
                                gradient: Gradient(stops: [
                                    .init(color: Color.white.opacity(0.1), location: 0.0),
                                    .init(color: Color.clear, location: 0.3),
                                    .init(color: Color.white.opacity(0.05), location: 0.6),
                                    .init(color: Color.clear, location: 1.0)
                                ]),
                                center: .topLeading,
                                startRadius: 0,
                                endRadius: 800
                            )
                        )
                        .overlay(
                            // Additional glass texture
                            Rectangle()
                                .fill(
                                    LinearGradient(
                                        gradient: Gradient(stops: [
                                            .init(color: Color.white.opacity(0.08), location: 0.0),
                                            .init(color: Color.clear, location: 0.2),
                                            .init(color: Color.white.opacity(0.04), location: 0.4),
                                            .init(color: Color.clear, location: 0.6),
                                            .init(color: Color.white.opacity(0.06), location: 0.8),
                                            .init(color: Color.clear, location: 1.0)
                                        ]),
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    )
                                )
                        )
                )
                .ignoresSafeArea(.all)
            
            // Modal content with custom frame
            ZStack {
                // Background for the modal content with glassmorphism
                RoundedRectangle(cornerRadius: 25)
                    .fill(.regularMaterial)
                    //CHANGES
                    //.environment(\.colorScheme, .dark)
                    .overlay(
                        RoundedRectangle(cornerRadius: 25)  // ← Changed from 20 to 25
                            .stroke(
                                LinearGradient(
                                    gradient: Gradient(stops: [
                                        .init(color: Color.white.opacity(0.2), location: 0.0),
                                        .init(color: Color.white.opacity(0.1), location: 0.5),
                                        .init(color: Color.clear, location: 1.0)
                                    ]),
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                ),
                                lineWidth: 1
                            )
                    )
                    //CHANGES
                    //.shadow(color: .black.opacity(0.3), radius: 20, x: 0, y: 10)
                
                // Content
                HStack(alignment: .top, spacing: 0) {
                    // Image section
                    ZStack {
                        Rectangle()
                            .fill(Color.bluePrimary)
                            LinearGradient(  gradient: Gradient(colors: [Color.white.opacity(0.2), Color.clear]),
                                             startPoint: .top,
                                             endPoint: .bottom)
//                            .fill(Color.blueSecondaryColor.opacity(0.2))
                        
                        Image(data.imageModal)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .clipped()
                        
//                        LinearGradient(
//                            gradient: Gradient(colors: [Color.bluePrimary.opacity(0.4), Color.clear]),
//                            startPoint: .bottom,
//                            endPoint: .top
//                        )
                    }
                    #if os(iOS)
                    .frame(maxWidth: UIScreen.main.bounds.width * 0.28)
                    .shadow(color: .black.opacity(0.2), radius: 2, x: 0, y: 0)
                    #endif
                    //.frame(maxWidth: .infinity)
                    .clipShape(
                        UnevenRoundedRectangle(
                            topLeadingRadius: 20,
                            bottomLeadingRadius: 20,
                            bottomTrailingRadius: 0,
                            topTrailingRadius: 0
                        )
                    )
                    
                    // Text content section
                    
                    VStack(alignment: .leading, spacing: 20) {
                        ScrollView {
                            VStack(alignment: .leading, spacing: 30) {
                                Text(data.title)
                                    .font(.largeTitle)
                                    .bold()
                                    .foregroundColor(.primary)
                                
                                Text(data.description)
                                    .font(.body)
                                    .multilineTextAlignment(.leading)
                                    .foregroundColor(.primary)
                                
                                Spacer(minLength: 80) // Space for button
                            }
                            .padding(.top, 40)
                            .padding(.horizontal, 30)
                        }
                        .scrollIndicators(.hidden)
                    }
                    .frame(maxWidth: .infinity)
                    
                }
                .clipShape(RoundedRectangle(cornerRadius: 25))
            }
            .frame(
                width: min(UIScreen.main.bounds.width , 800),
                height: min(UIScreen.main.bounds.height, 600)
            )
            .overlay(alignment: .topTrailing) {
                // Close button with glassmorphism
                Button(action: { dismiss() }) {
                    Image(systemName: "xmark.circle.fill")
                        .font(.title2)
                        .foregroundColor(.secondary)
                        .background(
                            Circle()
                                .fill(.regularMaterial)
                                .overlay(
                                    Circle()
                                        .stroke(Color.white.opacity(0.2), lineWidth: 1)
                                )
                        )
                }
                .padding(15)
            }
            .overlay(alignment: .bottomTrailing) {
                // Start button with glassmorphism
                Button {
                    showConfirmation = true
                } label: {
                    Text(data.disabledSection ? "Coming Soon" : "Start")
                        .fontWeight(.semibold)
                        .padding(.horizontal, 30)
                        .padding(.vertical, 12)
                        .foregroundColor(.white)
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .fill(.regularMaterial)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 20)
                                        .fill(data.disabledSection ? Color.gray : Color.bluePrimaryColor)
                                )
                                .overlay(
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(Color.white.opacity(0.3), lineWidth: 1)
                                )
                        )
                }
                .padding(.bottom, 30)
                .padding(.trailing, 30)
                .disabled(data.disabledSection)
                .alert("Important Notice", isPresented: $showConfirmation) {
                    Button("Confirm", role: .destructive) {
                        dismiss()
                        if let destination = data.navView {
                            router.path.append(.colostomy) // Update to dynamic routing if needed
                        }
                    }
                    Button("Cancel", role: .cancel) { }
                } message: {
                    Text("This simulator is just a tool, not a diagnosis. Consult your doctor.")
                }
            }
        }
    }
}


struct CustomModalView_Previews: PreviewProvider {
    static var previews: some View {
        CustomModalView(
            isPresented: .constant(true),
            data: CardData(
                type: "content",
                title: "Colostomy l",
                subtitle: "Colon Stoma",
                imageName: "Colostomy",
                imageModal: "Untitled_Artwork",
                description: "In this section you will learn what a colostomy is, how it works and what aspects are important to know in daily life. A colostomy is a surgical opening on the abdomen, called a stoma, that allows feces to exit the colon to the outside of the body, where they are collected in a special adhesive bag. It can be temporary or permanent, depending on the clinical condition. The feces no longer pass through the anus but through the stoma, into a bag. Now that you have a basic understanding, you're ready to begin. Click on the buttons and let's start this journey together!",
                navView: AnyView(Text("Next View"))
            )
        )
        .environmentObject(NavigationRouter())
    }
}
