import SwiftUI

struct ChatBotOverlay: View {
    
    @EnvironmentObject var viewModel: OstomyViewModel
    @State private var currentStep: Int = 0
    
    let steps: [String]
    
    var body: some View {
        VStack(alignment: .trailing) {
            HStack(alignment: .center, spacing: 16) {
                
                Spacer()
                        
                VStack(alignment: .trailing) {
                    Text(steps[currentStep])
                        .padding()
                        .background(Color.bluePrimary.opacity(0.2))
                        .cornerRadius(20)
                        .frame(maxWidth: 400)
                        .font(.body)
                        .transition(.slide)
                    
                
                    Button {
                        if currentStep < steps.count - 1 {
                            currentStep += 1
                        }
                    } label: {
                        Text("Next")
                            .font(.system(size: 17, weight: .bold))
                            .foregroundColor(.blue)
                            .padding(.top, 4)
                    }
                
                }
                
                Image("NurseRight")
                    .resizable()
                    .frame(width: 60, height: 60)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.white, lineWidth: 4))
                    .shadow(radius: 4)
                
                
            }
        }
        .frame(maxWidth: 500)
        .padding()
    }
}

#Preview {
    ColostomyView()
}
