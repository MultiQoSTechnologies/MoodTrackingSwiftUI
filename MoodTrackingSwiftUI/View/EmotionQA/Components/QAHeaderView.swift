//
//  QAHeaderView.swift
//  MoodTrackingSwiftUI
//
//  Created by MQF-6 on 03/06/24.
//

import SwiftUI


struct QAHeaderView: View {
    @Environment(\.dismiss) private var dismiss
    
    var title: String

    var body: some View {
        ZStack(alignment: .center) {
            VStack {
                HStack {
                    Button(action: {
                        dismiss.callAsFunction()
                    }, label: {
                        Image(.arrowLeft)
                    })
                    Spacer()
                }
            } 
            Text(title)
        }.frame(height: 54.aspectRatio, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    QAHeaderView(title: "1/3")
}
