//
//  InfoItemCardView.swift
//  MyStoma
//
//  Created by Martha Mendoza Alfaro on 28/05/25.
//


import SwiftUI

struct InfoItemCardView: View {
    let item: InfoItem

    @State private var animateTap = false
    @State private var showModal = false

    var body: some View {
        ZStack(alignment: .center) {
            Button(action: {
                animateTap = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    showModal = true
                    animateTap = false
                }
            }) {
                ZStack(alignment: .center) {
                    Rectangle()
                        .fill(
                            LinearGradient(
                                gradient: Gradient(colors: [Color.bluePrimary.opacity(0.7), Color.blueSecondaryColor.opacity(0.9)]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                        .cornerRadius(20)
                        .opacity(0.5)
                        
                        Image(item.imageName)
                            .resizable()
                            .scaledToFit()
                            .padding()
                        
                        
                        /*Text(item.title)
                            .font(.headline)
                            .bold()
                            .foregroundColor(.white)
                        //.padding(),alignment: .bottomLeading
                    */
                }
                #if os(iOS)
                .frame(width: UIScreen.main.bounds.width * 0.12,
                       height: UIScreen.main.bounds.width * 0.12)
                #endif
                .scaleEffect(animateTap ? 0.95 : 1.0)
                .animation(.spring(response: 0.4, dampingFraction: 0.6), value: animateTap)
            }

        }
        .sheet(isPresented: $showModal) {
            ItemView(selectedItem: item)
                #if os(iOS)
                /*.frame(width: UIScreen.main.bounds.width * 2/3,
                       height: UIScreen.main.bounds.height * 2/3)
                .transition(.scale)*/
                #endif
        }

        .shadow(radius: 5)
        //.padding()
    }
}

#Preview {
    InfoItemCardView(
        item: InfoItem(
            title: "infoitem_adhesivespray_title",
            description: "infoitem_adhesivespray_description",
            modelName: "Bottle"
        )
    )
}
