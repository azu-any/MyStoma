import SwiftUI

struct ChatBotOverlay: View {
    
    @EnvironmentObject var viewModel: OstomyViewModel
    @State private var currentStep: Int = 0
    
    let steps: [String]
    
    var body: some View {
        VStack {
            HStack(alignment: .center, spacing: 16) {
                VStack(alignment: .leading) {
                    Text(steps[currentStep])
                        .padding(10)
                        .background(Color.white.opacity(0.9))
                        .cornerRadius(20)
                        .font(.body)
                        .transition(.slide)
                    Button(action: {
                        if currentStep < steps.count - 1 {
                            currentStep += 1
                        }
                    }, label: {
                        Text("Next")
                            .font(.system(size: 17, weight: .bold))
                            .foregroundColor(.blue)
                            .padding(.top, 4)
                    })
                }
                Image("NurseRight")
                    .resizable()
                    .frame(width: 60, height: 60)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 4))
                    .shadow(radius: 4)
            }
            .padding()
        }
    }
}

#Preview {
    ColostomyView()
}
