//
//  EmotionQAFirstView.swift
//  MoodTrackingSwiftUI
//
//  Created by MQF-6 on 03/06/24.
//

import SwiftUI

struct EmotionSelectionView: View {
    
    @EnvironmentObject private var router: Router
    @EnvironmentObject private var emotionqaVM: EmotionQAViewModel
    
    @State private var searchText = ""
    @State private var showWhatMadeFeel = false
    
    var body: some View {
        ZStack {
            VStack {
                QAHeaderView(title: "1/3")
                
                ScrollView {
                    QATitltSubtitle(title: "What emotion you are feeling now?", subtitle: "Select atleast 1 emotion")
                    
                    AppSearchField(searchText: $searchText, placeholder: "Search emotions")
                        .onChange(of: searchText, perform: { value in
                            emotionqaVM.searchEmotion(searchText: searchText)
                        })
                    
                    EmotionsGridView()
                }
                .scrollIndicators(.hidden)
                
                Spacer()
                
                AppButton(
                    onTap: {
                        if emotionqaVM.checkEmotionContinueEnable() {
                            router.navigate(to: .whatMadeFeel)
                        }
                    },
                    title: "Continue",
                    enable: emotionqaVM.checkEmotionContinueEnable()
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
    EmotionSelectionView()
        .environmentObject(EmotionQAViewModel())
}

