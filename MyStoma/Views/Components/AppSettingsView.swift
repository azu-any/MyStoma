import SwiftUI

struct AppSettingsView: View {
    @AppStorage("useDyslexiaFont") private var useDyslexiaFont = false
    @AppStorage("skinColorSelection") private var skinColorSelection = "LightColor"

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Settings")
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .center)

            Toggle("Dislexia Font", isOn: $useDyslexiaFont)

            Text("Skin Color")
            
            HStack(spacing: 15) {
                ForEach(Array(skinColors.keys), id: \.self) { key in
                    let color = skinColors[key] ?? .clear
                    Circle()
                        .fill(color)
                        .frame(width: 32, height: 32)
                        .overlay(
                            Circle()
                                .stroke(Color.accentColor, lineWidth: skinColorSelection == key ? 3 : 0)
                        )
                        .onTapGesture {
                            skinColorSelection = key
                        }
                }
            }
        }
        .animation(.easeInOut, value: useDyslexiaFont)
        .padding()
        .frame(width: 260)
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
    }
}

#Preview {
    AppSettingsView()
}
