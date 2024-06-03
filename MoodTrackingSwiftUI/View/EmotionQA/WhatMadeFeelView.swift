//
//  WhatMadeFeel.swift
//  MoodTrackingSwiftUI
//
//  Created by MQF-6 on 03/06/24.
//

import SwiftUI

struct WhatMadeFeelView: View {
    
    @State var searchText = ""
    
    let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 1)

    var body: some View {
        ZStack {
            VStack {
                QAHeaderView(title: "2/3")
            
                ScrollView {
                    QATitltSubtitle(title: "What reason making you feel this way?", subtitle: "Select reason which reflacted your emotions.")
                    AppSearchField(searchText: searchText, placeholder: "Search reason")
                    
                    LazyVGrid(columns: columns, content: {
                        GeometryReader(content: { geometry in
                            Text("Placeholder")
                                .frame(width: geometry.size.width)
                        })
                            
                    })
                }
                Spacer()
                
                AppButton(onTap: {

                }, title: "Continue")
                
                
            }
        }
        .padding(.horizontal, 20.aspectRatio)
        .gradientBackground(colors: [.lightGreen, .lightBlue, .lightPurple])
    } 
}

#Preview {
    WhatMadeFeelView()
}
