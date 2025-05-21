//
//  QuestionVPView.swift
//  MyStoma
//
//  Created by Azuany Mila Cerón on 08/05/25.
//
import SwiftUI

struct QuestionView: View {
    
    var question: String
    var answers: [String]
    @Binding var showDialogue: Bool
    
    @State private var answerResult: AnswerResult = .none

    var body: some View {
        ZStack {
            VStack(alignment: .center, spacing: 20) {
                
                Text(question)
                
                let columns = [
                    GridItem(.flexible()),
                    GridItem(.flexible())
                ]

                LazyVGrid(columns: columns, spacing: 16) {
                    
                    Button {
                        answerResult = .correct
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                answerResult = .none
                                showDialogue.toggle()
                            }
                    } label: {
                        Text(answers[0])
                            .multilineTextAlignment(.center)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(.regularMaterial)
                            .cornerRadius(10)
                    }
                    .buttonStyle(.plain)
                    
                    Button {
                        answerResult = .incorrect
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                answerResult = .none
                            }
                    } label: {
                        Text(answers[1])
                            .multilineTextAlignment(.center)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(.regularMaterial)
                            .cornerRadius(10)
                    }
                    .buttonStyle(.plain)
                    
                }
                .padding()

            }
            
            if answerResult == .correct {
                Image(systemName: "checkmark.circle.fill")
                    .font(.system(size: 100))
                    .foregroundStyle(.white, .green)
                    .transition(.scale)
                    .opacity(0.8)
                
            } else if answerResult == .incorrect {
                Image(systemName: "xmark.circle.fill")
                    .font(.system(size: 100))
                    .foregroundStyle(.white, .red)
                    .transition(.scale)
                    .opacity(0.8)

            }
        }
        .animation(.spring(), value: answerResult)
        
    }
}


enum AnswerResult {
    case none, correct, incorrect
}
