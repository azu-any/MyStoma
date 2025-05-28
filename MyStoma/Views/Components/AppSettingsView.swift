import SwiftUI

struct AppSettingsView: View {
    @AppStorage("useDyslexiaFont") private var useDyslexiaFont = false
    @AppStorage("skinColorSelection") private var skinColorSelection = 0

    let skinColors: [Color] = [
        Color(red: 153/255, green: 112/255, blue: 100/255), // brown pink
        Color(red: 240/255, green: 205/255, blue: 186/255), // light brown
        Color(red: 60/255, green: 32/255, blue: 4/255), // beige
        Color(red: 30/255, green: 15/255, blue: 0/255),     // dark brown
    ]

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Settings")
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .center)

            Toggle("Dislexia Font", isOn: $useDyslexiaFont)

            Text("Skin Color")
                .font(.subheadline)

            HStack(spacing: 15) {
                ForEach(0..<skinColors.count, id: \.self) { index in
                    Circle()
                        .fill(skinColors[index])
                        .frame(width: 32, height: 32)
                        .overlay(
                            Circle()
                                .stroke(Color.primary, lineWidth: skinColorSelection == index ? 3 : 0)
                        )
                        .onTapGesture {
                            skinColorSelection = index
                        }
                }
            }
        }
        .padding()
        .frame(width: 260)
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
    }
}

#Preview {
    AppSettingsView()
}
