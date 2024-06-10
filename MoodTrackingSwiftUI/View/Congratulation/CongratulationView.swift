//
//  CongratulationView.swift
//  MoodTrackingSwiftUI
//
//  Created by MQF-6 on 03/06/24.
//

import SwiftUI

struct CongratulationView: View {
     
    @EnvironmentObject private var router: Router
    @EnvironmentObject private var emotionVM: EmotionQAViewModel
    
    @State private var showHome = false
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.3).ignoresSafeArea()
            
            VStack(spacing: 16.aspectRatio) {
                Image(.congratulationEmoji)
                    .resizable()
                    .frame(width: 200.aspectRatio, height: 220.aspectRatio)
                
                HStack {
                    Text("You are on a ")
                        
                    + Text("good way! \n")
                        .foregroundColor(.appPurple)
                    
                    + Text("Your day is going \n")
                    
                    + Text("amazing")
                        .foregroundColor(.appPurple)
                }
                .font(.title2)
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)
                .padding(.top, -50)
                
                Text("Keep tracking your mood to know how to improve your mental health")
                    .foregroundStyle(.black.opacity(0.6))
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 30.aspectRatio)
                
                AppButton(
                    onTap: {
                        emotionVM.reset()
                        router.navigateToRoot()
                    },
                    title: "Got it",
                    enable: true
                )
            }
            .padding(16.aspectRatio)
            .background(.white)
            .clipShape(.rect(cornerRadius: 30.aspectRatio))
            .padding(16.aspectRatio)
        } 
        .gradientBackground()
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    CongratulationView()
}
