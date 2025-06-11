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
    
    @EnvironmentObject var itemModel: ItemModel
    



    var body: some View {
        ZStack(alignment: .center) {
            Button {
                animateTap = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    showModal = true
                    animateTap = false
                }
            } label: {
                ZStack(alignment: .center) {
                    Rectangle()
                        .fill(
                            LinearGradient(
                                gradient: Gradient(colors: [Color.white.opacity(0.8), Color.white.opacity(0.8)]),
                                startPoint: .leading, //top
                                endPoint: .trailing //bottom
                            )
                        )
                        .cornerRadius(20)
                        //.opacity(0.5)
                        
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
                #if os(visionOS)
                .frame(width: 120, height: 120)
                #endif
                .scaleEffect(animateTap ? 0.95 : 1.0)
                .animation(.spring(response: 0.4, dampingFraction: 0.6), value: animateTap)
            }
            .buttonStyle(.plain)

        }
        .sheet(isPresented: $showModal) {
            ItemView(selectedItem: item)
        }
        .shadow(color: .black.opacity(0.2), radius: 2, x: 0, y: 0)
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
