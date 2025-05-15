import SwiftUI

struct InfoButtonStyle: ButtonStyle {
    
    var color: Color = Color.bluePrimary
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.headline)
            .foregroundColor(.white)
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(color)
            .cornerRadius(12)
            .shadow(radius: 5)
            .opacity(configuration.isPressed ? 0.7 : 1)
    }
}

#Preview {
    Button(action: {}, label: {
        Text("TO TEST THIS BEAUTIFUL BUTTON")
    })
    .buttonStyle(InfoButtonStyle())
    .padding()
}
