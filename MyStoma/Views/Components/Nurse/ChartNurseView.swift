//
//  ChartNurseView.swift
//  MyStoma
//
//  Created by Azuany Mila Cerón on 27/05/25.
//
import SwiftUI


struct ChartNurseView: View {
    
    @EnvironmentObject var ostomyViewModel: OstomyViewModel

    var body : some View {
        HStack (spacing: 12) {
            Image("NurseLeft")
                .resizable()
                .frame(width: 120, height: 120)
                .offset(y: 4)
                .background {
                    Rectangle()
                      .foregroundColor(.clear)
                      .frame(width: 124, height: 124)
                      .background(Color(red: 0.19, green: 0.28, blue: 0.34))
                      .cornerRadius(20)
                      .overlay(
                        RoundedRectangle(cornerRadius: 20)
                          .inset(by: 0.5)
                          .stroke(Color(red: 0.42, green: 0.6, blue: 0.74), lineWidth: 1)
                      )
                      .offset(y: 2)
                }

            
            
            VStack(spacing: 12) {
                HStack {
                    
                    // TODO: Check if user can go back to previous step
                    /*Button {
                        ostomyViewModel.currentStepIndex -= 1
                        ostomyViewModel.currentDialogueIndex = 0
                    } label: {
                        Image(systemName: "chevron.left")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 10)
                            .foregroundStyle(.white)
                    }
                    .buttonStyle(.plain)
                    .disabled(!canGoBack(index: ostomyViewModel.currentStepIndex))

                    
                    Spacer()
                     
                     */
                    Text("Step \(ostomyViewModel.currentStepIndex + 1)")
                        .foregroundStyle(.white)
                        .italic()
                        .bold()
                    
                    
                    /*Spacer()
                    
                    // TODO: Check if user can go forward to nexr step if already done

                    Button {
                        ostomyViewModel.currentStepIndex += 1
                        ostomyViewModel.currentDialogueIndex = 0
                    } label: {
                        Image(systemName: "chevron.right")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 10)
                            .foregroundStyle(.white)
                    }
                    .buttonStyle(.plain)
                    .disabled(!canGoForward(index: ostomyViewModel.currentStepIndex, count: ostomyViewModel.ostomy.steps.count))
                    */
                }
                .padding(.horizontal, 5)
                .frame(width: 240, height: 25)
                .background {
                    Rectangle()
                        .foregroundColor(.clear)
                        .background(Color(red: 0.42, green: 0.6, blue: 0.74))
                        .cornerRadius(20)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .inset(by: 0.5)
                                .stroke(Color(red: 0.42, green: 0.6, blue: 0.74), lineWidth: 1)
                        )
                }
                
                Text(ostomyViewModel.ostomy.steps[ostomyViewModel.currentStepIndex].name)
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.white)
                    .italic()
                    .bold()
                    .frame(width: 240, height: 80)
                    .background {
                        Rectangle()
                            .foregroundColor(.clear)
                            .background(Color(red: 0.42, green: 0.6, blue: 0.74))
                            .cornerRadius(20)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .inset(by: 0.5)
                                    .stroke(Color(red: 0.42, green: 0.6, blue: 0.74), lineWidth: 1)
                            )
                    }
            }
            
            
        }
    }
}
