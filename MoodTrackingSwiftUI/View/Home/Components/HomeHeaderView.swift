//
//  File.swift
//  MoodTrackingSwiftUI
//
//  Created by MQF-6 on 03/06/24.
//

import SwiftUI

struct HomeHeaderView: View {
    var body: some View {
        HStack {
            Text("Hey,")
                .font(.title2)
            Text("Alexa")
                .font(.title)
                .bold()
            Spacer()
            
            HStack { 
                Text(Date.now.toDate(format: "E, dd MMMM"))
                    .font(.caption)
                Image(.calendar)
                    .resizable()
                    .frame(width: 24.aspectRatio, height: 24.aspectRatio)
                    .foregroundStyle(.appPurple)
            }
            .padding(.horizontal, 15.aspectRatio)
            .padding(.vertical, 10.aspectRatio)
            .background {
                Capsule()
                    .fill(.white)
            }
        }
        
    }
}


#Preview {
    HomeHeaderView()
}
