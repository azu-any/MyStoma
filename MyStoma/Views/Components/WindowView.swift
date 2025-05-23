import SwiftUI

struct WindowView: View {
    
    @EnvironmentObject var router: NavigationRouter
    @Environment(\.dismiss) var dismiss

    @Binding var isPresented: Bool
    var title: String
    var description: String
    var navView: AnyView?

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text(title)
                    .font(.largeTitle)
                    .bold()
                    .padding()
                
                HStack(alignment: .top, spacing: 40) {
                    Text(description)
                        .font(.body)
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Spacer()
                    
                    Image("NurseRight")
                        .resizable()
                        .scaledToFit()
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        .frame(maxWidth: .infinity, alignment: .center)
                }
                .padding(.horizontal)
                
                Spacer()
                
            }
            .padding()
        }
        .overlay(alignment: .bottom) {
            Button {
                dismiss()
                router.path.append(.colostomy)
            } label: {
                Text("Start")
                    .fontWeight(.semibold)
                    .frame(minWidth: 100)
                    .padding()
                    .foregroundColor(.blue)
                    .background(Color.white)
                    .cornerRadius(15)
                    .overlay(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(Color.blue, lineWidth: 2)
                    )
            }
            
            .padding(.bottom, 20)
            //.buttonStyle(ScaleButtonStyle())
            .padding()
            .disabled((navView != nil) ? false : true)
            
        }
        .background(Color.white)

    }
}

struct ScaleButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}

struct WindowView_Previews: PreviewProvider {
    static var previews: some View {
        WindowView(
            isPresented: .constant(true),
            title: "Colostomy",
            description: "A colostomy is a type of bowel stoma where part of the colon (large intestine) is brought out through the abdominal wall to allow stool to pass out of the body. \"Colostomy\" comes from \"colon\" and \"stoma\" (opening or mouth). \n\nTypes of colostomy \n*Temporary: to give time for a section of bowel to heal after surgery, trauma, or inflammation.\n*Permanent: when it's not possible to reconnect the bowel after resection.\n\nStoma location \nColostomies can be placed at different points in the colon, affecting stool consistency: \n*Ascending colostomy: liquid stool; less common. \n*Transverse colostomy: semi-formed stool; can be temporary or permanent. \n*Descending or sigmoid colostomy: formed or solid stool; most common and easier to manage. \n\nAppearance and management \nThe stoma looks red and moist, and has no nerve endings (so it's not painful to touch). \nStool is collected in a pouching system, which can be: \nClosed (for formed stool) \nDrainable (for liquid or semi-liquid stool) \nIt is important to protect the peristomal skin (the skin around the stoma) to avoid irritation. \n\nIn this section we are going to learn how to take change and take care of our colostomy!"
        )
    }
}
