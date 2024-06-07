//
//  DateSelectionView.swift
//  MoodTrackingSwiftUI
//
//  Created by MQF-6 on 03/06/24.
//

import SwiftUI

struct DateSelectionView: View {
    @EnvironmentObject var homeVM: HomeViewModel 
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(homeVM.dates, id: \.self) { date in
                    VStack {
                        Capsule()
                            .fill(homeVM.selectedDate == date ? .appPurple : .white)
                            .frame(width: 48.aspectRatio, height: 65.aspectRatio)
                            .overlay {
                                Text(date.toDate(format: "E dd"))
                                    .foregroundStyle(homeVM.selectedDate == date ? .white : .black)
                                    .font(.subheadline)
                                    .multilineTextAlignment(.center)
                                    .padding(.horizontal, 8.aspectRatio)
                            } 
                    }
                    .onTapGesture {
                        homeVM.selectedDate = date
                    }
                }
            }
            .onAppear(perform: {
                homeVM.selectedDate = homeVM.dates.last
            })
        }
    }
}

#Preview {
    DateSelectionView()
        .environmentObject(HomeViewModel())
}
