//
//  File.swift
//  MoodTrackingSwiftUI
//
//  Created by MQF-6 on 03/06/24.
//

import SwiftUI

struct HomeHeaderView: View {
    
    @EnvironmentObject private var homeVM: HomeViewModel
    
    var body: some View {
        HStack {
            Text("Hey,")
                .font(.title2)
            Text("\(Constant.user?.name ?? "")")
                .font(.title)
                .bold()
            
            Spacer()
            
            Button(action: {
                homeVM.showAlert.toggle()
            }, label: {
                HStack {
                    Image(systemName: "rectangle.portrait.and.arrow.right.fill")
                        .foregroundStyle(.appPurple)
                }
                .padding(10.aspectRatio)
                .background {
                    Circle()
                        .fill(.white)
                }
            })
        } 
    }
}


#Preview {
    HomeHeaderView()
}
