//
//  EmotionsGridView.swift
//  MoodTrackingSwiftUI
//
//  Created by MQF-6 on 03/06/24.
//

import SwiftUI

struct EmotionsGridView: View {
    let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 4)
    
    @State var selected: [Int] = []

    var body: some View {
        LazyVStack(alignment: .leading, spacing: 14.aspectRatio) {
            Text("All Emotions")
                .font(.caption)
                .bold()
            
            LazyVGrid(columns:  columns, content: {
                ForEach(0..<10, id: \.self) { item in
                    Button {
                        if selected.contains(item) {
                            withAnimation {
                                selected.removeAll(where: {$0 == item})
                            }
                        } else {
                            withAnimation(.linear(duration: 0.5)) {
                                selected.append(item)
                            }
                        }
                    } label: {
                        VStack {
                            Circle()
                                .frame(width: 65.aspectRatio, height: 65.aspectRatio)
                                .foregroundStyle(selected.contains(item) ? .white : .lightBlue)
                                .overlay {
                                    Image(.faceScreamingFear)
                                        .resizable()
                                        .frame(width: 35.aspectRatio, height: 35.aspectRatio)
                                }
                            
                            Text("Confused")
                                .font(.caption)
                                .bold()
                                .foregroundStyle(.black)
                        }.padding(.bottom, 10.aspectRatio)
                    }

                    
                }
            })
            
        }.padding(.top, 16.aspectRatio)
    }
}


#Preview {
    EmotionsGridView()
}
