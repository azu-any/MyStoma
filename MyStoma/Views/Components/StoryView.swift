//
//  ContentViewIpad 2.swift
//  MyStoma
//
//  Created by Martha Mendoza Alfaro on 26/05/25.
//
import SwiftUI

struct StoryView: View {
    
    
    let data: CardData
    //var title: LocalizedStringResource
    //var subtitle: LocalizedStringResource
    //var imageName: String
    //var imageModal: String
    //var description: LocalizedStringResource
    var navView: AnyView?
    //var quote: LocalizedStringResource?

    @State private var animateTap = false
    @State private var showModal = false

    var body: some View {
        HStack(alignment: .center, spacing: 16) {
            // App icon
            

            // Get Button
            Button(action: {
                animateTap = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    showModal = true
                    animateTap = false
                }
            }) {
                
                HStack(alignment: .top, spacing: 16) {
                    
                    Image(data.imageName)
                        .resizable()
                        .aspectRatio(1, contentMode: .fit)
                        //.frame(maxWidth: 100, minHeight: 100)
                        #if os(iOS)
                        .frame(width: UIScreen.main.bounds.width * 0.1,
                               height: UIScreen.main.bounds.width * 0.1)
                        #endif
                        .cornerRadius(14)
                    
                    // Title and subtitle
                    VStack(alignment: .leading, spacing: 4) {
                        Text(data.title)
                            .font(.headline)
                            .foregroundColor(.black)
                        
                        Text("“\(data.quote ?? "No quote")”")
                            //.padding(.top, 10)
                            .font(.subheadline.bold().italic())
                            .minimumScaleFactor(0.5)
                            .multilineTextAlignment(.leading)
                            .foregroundColor(.gray)
                        Spacer()
                        HStack() {
                            Spacer()
                            
                            Text(data.subtitle)
                                .font(.subheadline.bold())
                                .frame(alignment: .topLeading)
                                .foregroundColor(.gray)
                        }
                    }
                }
                .padding()
                .background(Color.white)
                .cornerRadius(20)
                .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
                #if os(iOS)
                .frame(width: UIScreen.main.bounds.width * 0.4,
                       height: UIScreen.main.bounds.width * 0.12)
                #endif
                
            }
            .scaleEffect(animateTap ? 0.95 : 1.0)
            .animation(.spring(), value: animateTap)
            #if os(iOS)
            .frame(width: UIScreen.main.bounds.width * 0.4,
                   height: UIScreen.main.bounds.width * 0.12)
            #endif
        }
        //.padding()
        //.background(Color.white)
        //.cornerRadius(20)
        //.shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
        /*.sheet(isPresented: $showModal) {
            WindowView(isPresented: $showModal, data:data)
            #if os(iOS)
                .frame(width: UIScreen.main.bounds.width * 2/3,
                       height: UIScreen.main.bounds.height * 2/3)
            #endif
                .transition(.scale)
        }*/
        .sheet(isPresented: $showModal) {
            CustomModalView2(isPresented: $showModal, data: data)
                .presentationDetents([.large])
                .presentationDragIndicator(.hidden)
                .presentationBackground(.clear)
        }
    }
}

#Preview {
    StoryView(
        data: CardData(
            type: "content",
            title: "Colostomy Leaving It Beh9ind",
            subtitle: "Martha Mendoza",
            imageName: "NurseLeft",
            imageModal: "Untitled_Artwork",
            description: "This is a preview of the colostomy content for demonstration purposes.",
            navView: AnyView(Text("Next View")),
            quote: "I couldn't let my urostomy change my love for sports and change who I am."
        )
    )
}



extension Color {
    static let bluePrimaryColor = Color("BluePrimaryColor")
    static let blueSecondaryColor = Color("BlueSecondaryColor")
}
