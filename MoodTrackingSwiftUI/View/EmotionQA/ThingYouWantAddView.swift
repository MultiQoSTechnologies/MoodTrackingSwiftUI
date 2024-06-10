//
//  ThingYouWantAddView.swift
//  MoodTrackingSwiftUI
//
//  Created by MQF-6 on 04/06/24.
//

import SwiftUI

struct ThingYouWantAddView: View {
    
    @EnvironmentObject private var router: Router
    @EnvironmentObject private var emotionqaVM: EmotionQAViewModel
    
    @State private var onmind = ""
    @State private var showCongratulation = false
    
    @State private var isBtnEnabled = false
    
    var body: some View {
        ZStack {
            VStack {
                QAHeaderView(title: "3/3")
            
                ScrollView {
                    QATitltSubtitle(
                        title: "Any thing you want to add",
                        subtitle: "Add your notes on any thought that reflacting your mood."
                    ).padding(.bottom, 20.aspectRatio)
                    
                    TextEditor(text: $emotionqaVM.onmind)
                        .lineSpacing(5)
                        .frame(height: 300.aspectRatio)
                        .padding()
                        .background(.white)
                        .clipShape(.rect(cornerRadius: 15.aspectRatio))
                        .onChange(of: emotionqaVM.onmind, perform: { value in
                            withAnimation(.easeInOut(duration: 0.5)) {
                                isBtnEnabled = (value != "") ? true : false
                            }
                        })
                }
                .scrollIndicators(.hidden)
                
                Spacer()
                
                AppButton(
                    onTap: {
                        if isBtnEnabled {
                            Task {
                                let success = await emotionqaVM.addEmotionData()
                                if success {
                                    router.navigate(to: .congratulate)
                                }
                            }
                        }
                    }, 
                    title: "Save",
                    enable: isBtnEnabled
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
    ThingYouWantAddView()
        .environmentObject(EmotionQAViewModel())
}
