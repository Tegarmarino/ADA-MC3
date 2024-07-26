//
//  OnboardingView.swift
//  Nocjurnal-ADA-MC3
//
//  Created by jessiline imanuela on 24/07/24.
//

import SwiftUI

struct OnboardingView: View {
    let VPW = UIScreen.main.bounds.size.width
    @State private var buttonState = ButtonState.idle
    @State private var pageState = 0
    @AppStorage("passcodeState") private var passcodeState: Bool = false
    @Binding var hasCompletedOnboarding: Bool
    @State private var isReminderPresented = false
    @State private var isReminderDone = false

    @Environment(Application.self) private var app

    var body: some View {
        ZStack{
            switch pageState {
                case 1:
                    Image("onboarding-reminder")
                        .resizable()
                        .edgesIgnoringSafeArea(.all)
                case 2:
                    Image("onboarding-passcode")
                        .resizable()
                        .edgesIgnoringSafeArea(.all)
                default:
                    Image("onboarding-journaling")
                        .resizable()
                        .edgesIgnoringSafeArea(.all)
            }
            VStack{
                VStack(alignment: .leading){
                    Spacer()
                    switch pageState {
                        case 1:
                            Text("Do you want to set a reminder?")
                                .font(Font.format.textHeadlineOne)
                            Text("A reminder will keep you stay on track with your journaling schedule.")
                                .font(Font.format.textBodyThree)
                                .padding(.top,1)
                        case 2:
                            Text("Do you want to enable the journal passcode?")
                                .font(Font.format.textHeadlineOne)
                            Text("A passcode aims to secure your writings and keep them private.")
                                .font(Font.format.textBodyThree)
                                .padding(.top,1)
                        default:
                            Text("Achieve a consistent journaling!")
                                .font(Font.format.textHeadlineOne)
                            Text("The more you write, the more you earn coins and experience to spoil your Noc.")
                                .font(Font.format.textBodyThree)
                                .padding(.top,1)
                    }
                }
                VStack{
                    if (pageState == 1){
                        ButtonRegular("Set Up Reminder", state: $buttonState) {
                            // setupreminder
                            isReminderPresented.toggle()
                        }
                        .sheet(isPresented: $isReminderPresented) {
                            Notification(isDone: $isReminderDone)
                        }
                        
                    }else if (pageState == 2){
                        HStack{
                            Image(systemName: "key.fill")
                            Toggle(isOn: $passcodeState) {
                                Text("Enable Passcode")
                            }
                            .toggleStyle(SwitchToggleStyle(tint: .blue))
                        }
                        .padding(.vertical, 10)
                        .padding(.horizontal,20)
                        .background(Color(.secondarySystemBackground))
                        .cornerRadius(24)
                    }
                    else{
                        ButtonRegular("Start Journaling", state: $buttonState) {
                            hasCompletedOnboarding = true
                            app.path.append(PageKind.editor)
                            
                        }
                    }
                    
                    Button(pageState == 2 ? "Next" : "Skip") {
                        if(pageState == 2){
                            // halaman trakhir onboarding
                            hasCompletedOnboarding = true
                            
                            // harusnya ke reward page
                            
                            
                        }
                        else if(pageState == 1){
                            pageState = 2
                        }
                        else{
                            pageState = 1
                        }
                    }
                    .padding(.top,5)
                }
                .font(Font.format.textBodyFour)
                .padding(.top,50)
                
            }
            .frame(width: VPW-48)
            .onChange(of: isReminderDone) { newValue in
                if newValue {
                    pageState = 2
                    isReminderDone = false
                }
            }
        }
        
        
    }
}

#Preview {
    OnboardingView(hasCompletedOnboarding: .constant(false))
}
