//
//  EmotionsGridView.swift
//  MoodTrackingSwiftUI
//
//  Created by MQF-6 on 03/06/24.
//

import SwiftUI
import SDWebImageSwiftUI 

struct EmotionsGridView: View {
    
    @EnvironmentObject private var emotionqaVM: EmotionQAViewModel
     
    let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 4)
      
    var body: some View {
        LazyVStack(alignment: .leading, spacing: 14.aspectRatio) {
            Text("All Emotions")
                .font(.caption)
                .bold()
            
            LazyVGrid(columns:  columns, content: {
                ForEach(emotionqaVM.arrMood, id: \.id) { mood in
                    VStack {
                        Circle()
                            .frame(width: 65.aspectRatio, height: 65.aspectRatio)
                            .foregroundStyle(mood.selected ? .white : .lightBlue)
                            .overlay {
                                AnimatedImage(url: URL(string: mood.img ?? ""))
                                    .transition(.fade(duration: 0.4))
                                    .resizable()
                                    .frame(width: 35.aspectRatio, height: 35.aspectRatio)
                            }
                        
                        Text(mood.mood ?? "")
                            .font(.caption)
                            .bold()
                            .foregroundStyle(.black)
                            .lineLimit(1)
                        
                    }
                    .onTapGesture {
                        withAnimation(.easeInOut(duration: 0.5)) {
                            emotionqaVM.toggleEmotionSelection(for: mood)
                        }
                    }
                    .padding(.bottom, 10.aspectRatio)
                }
            })
        }.padding(.top, 16.aspectRatio)
            .onAppear {
                Task {
                    await emotionqaVM.fetchMoods()
                }
            }
    }
}


#Preview {
    EmotionsGridView()
        .environmentObject(EmotionQAViewModel())
}
