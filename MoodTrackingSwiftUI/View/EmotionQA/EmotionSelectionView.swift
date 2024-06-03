//
//  EmotionQAFirstView.swift
//  MoodTrackingSwiftUI
//
//  Created by MQF-6 on 03/06/24.
//

import SwiftUI

struct EmotionSelectionView: View {
    
    @State var searchText = ""
    
    @State var showWhatMadeFeel = false
    
    var body: some View {
        ZStack {
            VStack {
                QAHeaderView(title: "1/3")
                
                ScrollView {
                    QATitltSubtitle(title: "What emotion you are feeling now?", subtitle: "Select atleast 1 emotion")
                    AppSearchField(searchText: searchText, placeholder: "Search emotions")
                    EmotionsGridView()
                }
                Spacer()
                
                AppButton(onTap: {
                    showWhatMadeFeel = true
                }, title: "Continue")
                
            }
            
        }
        .padding(.horizontal, 20.aspectRatio)
        .gradientBackground(colors: [.lightGreen, .lightBlue, .lightPurple])
        .sheet(isPresented: $showWhatMadeFeel, content: {
            WhatMadeFeelView()
        })
    } 
}

#Preview {
    EmotionSelectionView()
}

