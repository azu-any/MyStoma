import SwiftUI

struct InventoryItem: Identifiable {
    var id: UUID = UUID()
    var name: String
    var imageName: String
}

class InventoryViewModel: ObservableObject {
    @Published var items: [InventoryItem] = [
        InventoryItem(name: "Colostomy Bag", imageName: "StomaBag"),
        InventoryItem(name: "Colostomy Bag", imageName: "StomaBag"),
        InventoryItem(name: "Colostomy Bag", imageName: "StomaBag")
    ]
}

struct ColostomyView: View {
    @ObservedObject private var viewModel = InventoryViewModel()
    let colostomySteps = [
        "Step 1: Wash your hands thoroughly.",
        "Step 2: Gather all necessary supplies.",
        "Step 3: Gently remove the used pouch.",
        "Step 4: Clean the stoma and surrounding skin.",
        "Step 5: Apply a new pouch securely.",
        "Step 6: Dispose of used materials and wash hands again."
    ]
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                Image("Union")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: 300, maxHeight: 300)
                Spacer()
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 16) {
                        ForEach(viewModel.items) { item in
                            VStack {
                                Image(item.imageName)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 100, height: 100)
                                    .background(Color.white.opacity(0.2))
                                    .cornerRadius(8)
                                Text(item.name)
                                    .font(.caption)
                                    .foregroundColor(.white)
                            }
                        }
                    }
                    .padding(.horizontal)
                }
                .padding()
                .background(Color.bluePrimary)
                .cornerRadius(20)
                .padding()
            }
        }
        .overlay(
            ChatBotOverlay(steps: colostomySteps)
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.bottom, 200)
                .padding(.trailing, 16), alignment: .leading
        )
        .padding()
        .navigationTitle("Colostomy")
    }
}

#Preview {
    ColostomyView()
}
