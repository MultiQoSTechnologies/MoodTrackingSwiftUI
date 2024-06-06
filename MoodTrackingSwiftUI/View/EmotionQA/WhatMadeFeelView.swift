//
//  WhatMadeFeel.swift
//  MoodTrackingSwiftUI
//
//  Created by MQF-6 on 03/06/24.
//

import SwiftUI

struct WhatMadeFeelView: View {
    
    @EnvironmentObject private var router: Router
    @EnvironmentObject private var emotionqaVM: EmotionQAViewModel
    
    @State private var searchText = ""
    @State private var showThingWantToAdd = false
    
    var body: some View {
        ZStack {
            VStack {
                QAHeaderView(title: "2/3")
            
                ScrollView {
                    QATitltSubtitle(title: "What reason making you feel this way?", subtitle: "Select reason which reflacted your emotions.")
                    
                    AppSearchField(searchText: $searchText, placeholder: "Search reason")
                        .onChange(of: searchText, perform: { value in
                            emotionqaVM.searchReason(searchText: value)
                        })
                    
                    ReasonGridView()
                        .padding(.top, 10.aspectRatio)
                }
                .scrollIndicators(.hidden)
                
                Spacer()
                
                AppButton(
                    onTap: {
                        if emotionqaVM.checkReasonContinueEnable() {
                            router.navigate(to: .thingYouWantAdd)
                        }
                    },
                    title: "Continue",
                    enable: emotionqaVM.checkReasonContinueEnable()
                )
            }
        }
        .padding(.horizontal, 20.aspectRatio)
        .gradientBackground(colors: [.lightGreen, .lightBlue, .lightPurple])
        .navigationBarBackButtonHidden()
        .loader(loading: emotionqaVM.isLoading)
        .toast(toast: $emotionqaVM.toast)
    }
}

#Preview {
    WhatMadeFeelView()
        .environmentObject(EmotionQAViewModel())
} 
