//
//  AppButton.swift
//  MoodTrackingSwiftUI
//
//  Created by MQF-6 on 03/06/24.
//

import SwiftUI

struct AppButton: View {
    
    var onTap: () -> ()
    var title: String
    
    var body: some View {
        Button(action: onTap, label: {
            HStack {
                Spacer()
                Text(title)
                Spacer()
            }
            .frame( height: 50.aspectRatio)
            .background(.appPurple)
            .clipShape(.capsule)
            .foregroundStyle(.white)
            .bold()
            .padding(.bottom, 1)
            
        })
    }
}

#Preview {
    AppButton(onTap: {
        
    }, title: "Continue")
}
