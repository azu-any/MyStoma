import SwiftUI

struct WindowView: View {
    @Binding var isPresented: Bool
    var title: LocalizedStringResource
    var description: LocalizedStringResource

    
    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Text(title)
                    .font(.largeTitle)
                    .bold()
                Spacer()
            }
            .padding(.horizontal)

            HStack(alignment: .top, spacing: 40) {
                Text(description)
                    .font(.body)
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)

                Spacer()

                Image("NurseRight")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 220, height: 220)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .frame(maxWidth: .infinity, alignment: .center)
            }
            .padding(.horizontal)

            Spacer()

            Button(action: {
                withAnimation {
                    isPresented = false
                }
            }) {
                Text("Start")
                    .fontWeight(.semibold)
                    .frame(minWidth: 100)
                    .padding()
                    .foregroundColor(.blue)
                    .overlay(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(Color.blue, lineWidth: 2)
                    )
            }
            .padding(.bottom, 20)
            .buttonStyle(ScaleButtonStyle())
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white)
        .cornerRadius(20)
        .shadow(radius: 20)
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
            description: "This procedure involves creating a stoma by bringing the colon to the surface of the abdomen. It allows waste to be diverted outside of the body, often in cases of bowel disease or injury."
        )
    }
}
