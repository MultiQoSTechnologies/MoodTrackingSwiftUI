//
//  SwiftUIView.swift
//  MoodTrackingSwiftUI
//
//  Created by MQF-6 on 03/06/24.
//

import SwiftUI

struct QATitltSubtitle: View {
    var title: String
    var subtitle: String
    
    var body: some View {
        VStack(spacing: 12.aspectRatio) {
            Text(title)
                .font(.title2)
                .bold()
                .multilineTextAlignment(.center)
            
            Text(subtitle)
                .font(.caption)
                .foregroundStyle(.black.opacity(0.8))
            
        }
    }
}

#Preview {
    QATitltSubtitle(title: "What emotion you are feeling now?", subtitle: "Select atleast 1 emotion")
}
