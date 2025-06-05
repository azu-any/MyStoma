import SwiftUI

struct AppSettingsView: View {
    @AppStorage("useDyslexiaFont") private var useDyslexiaFont = false
    @AppStorage("skinColorSelection") private var skinColorSelection = "LightColor"
    
    let orderedSkinColorKeys = ["LighterColor", "LightColor", "DarkColor", "DarkerColor"]
    
    let skinColorDescriptions: [String: String] = [
        "LighterColor": "Lightest skin tone",
        "LightColor": "Light skin tone",
        "DarkColor": "Dark skin tone",
        "DarkerColor": "Darkest skin tone"
    ]

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Settings")
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .center)

            //No dislexia font for now
            
            /*Toggle("Dislexia Font", isOn: $useDyslexiaFont)*/

            Text("Skin Color")
            
            HStack(spacing: 15) {
                ForEach(orderedSkinColorKeys, id: \.self) { key in
                    let color = skinColors[key] ?? .clear
                    let description = skinColorDescriptions[key] ?? "Skin color"
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
                        .accessibilityLabel(Text(description))
                        .accessibilityAddTraits(
                            skinColorSelection == key ? .isSelected : []
                        )
                }
            }
        }
        .animation(.easeInOut, value: useDyslexiaFont)
        .padding()
        .frame(width: 260)
        //.background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
    }
}

#Preview {
    AppSettingsView()
}
