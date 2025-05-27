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
    @State private var selectedAnswer: String?
    @Binding var showDialogue: Bool
    
    @State private var answerResult: AnswerResult = .none
    @State private var shuffledAnswers: [String] = []


    var body: some View {
        ZStack {
            VStack(alignment: .center, spacing: 10) {
                
                Text(question)
                    .multilineTextAlignment(.center)

                
                let columns = [
                    GridItem(.flexible()),
                    GridItem(.flexible())
                ]

                LazyVGrid(columns: columns, spacing: 12) {
                    
                    ForEach(shuffledAnswers, id: \.self) { answer in
                        
                        Button {
                            withAnimation(.easeInOut(duration: 0.5)) {
                                selectedAnswer = answer
                                answerResult = (answer == answers[0]) ? .correct : .incorrect
                            }
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            withAnimation(.easeInOut(duration: 0.5)) {
                                selectedAnswer = nil
                                answerResult = .none
                                if answer == answers[0] {
                                    showDialogue = true
                                }
                            }
                        }
                            
                        } label: {
                            Text(answer)
                                .multilineTextAlignment(.center)
                                .padding(5)
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .overlay{
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(Color.black.opacity(0.4), lineWidth: 1)
                                }
                                .background(backgroundColor(for: answer))
                                .cornerRadius(20)
                                .animation(.easeInOut(duration: 0.3), value: selectedAnswer)


                        }
                        .buttonStyle(.plain)
                        .allowsHitTesting(answerResult == .none)
                    }
                    
                }
                .padding()
                
                if answerResult == .correct {
                    Text("That's right!")
                        .bold()
                } else if answerResult == .incorrect {
                    Text("Ups, try again!")
                        .bold()
                }

            }
            .onAppear {
                shuffledAnswers = answers.shuffled()
            }

        }
    }
    
    
    func backgroundColor(for answer: String) -> Color {
            guard let selected = selectedAnswer else { return Color.white }

            if answer == selected {
                return answerResult == .correct ? Color.green.opacity(0.6) : Color.red.opacity(0.6)
            } else {
                return Color.white
            }
        }
}


enum AnswerResult {
    case none, correct, incorrect
}

#Preview {
    QuestionView(question: "Here goes the question?", answers: ["correct", "right"], showDialogue: .constant(false))
}
