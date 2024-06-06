//
//  ReasonGridView.swift
//  MoodTrackingSwiftUI
//
//  Created by MQF-6 on 06/06/24.
//

import SwiftUI

struct ReasonGridView: View {
    
    @EnvironmentObject private var emotionqaVM: EmotionQAViewModel
     
    var body: some View {
        
        FlowLayout(data: emotionqaVM.arrReason) { item in
            VStack {
                ZStack {
                    Text(item.reason)
                        .lineLimit(2)
                        .multilineTextAlignment(.center)
                        .foregroundStyle(item.selected ? .white : .black)
                        .padding()
                        .background(Capsule().fill(item.selected ? .appSkyBlue : .clear))
                }.overlay {
                    Capsule()
                        .stroke(!item.selected ? .black : .clear, lineWidth: 1)
                }
                .onTapGesture {
                    withAnimation(.easeInOut(duration: 0.5)) {
                        emotionqaVM.toggleReasonSelection(for: item)
                    }
                }
            }.padding(.bottom, 10.aspectRatio)
        }
        .onAppear(perform: {
            Task {
                await emotionqaVM.fetchReasons()
            }
        })
    }
}


#Preview {
    ReasonGridView()
        .environmentObject(EmotionQAViewModel())
}
