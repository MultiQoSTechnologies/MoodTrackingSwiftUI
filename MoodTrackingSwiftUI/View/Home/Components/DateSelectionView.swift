//
//  DateSelectionView.swift
//  MoodTrackingSwiftUI
//
//  Created by MQF-6 on 03/06/24.
//

import SwiftUI

struct DateSelectionView: View {
    @EnvironmentObject var homeVM: HomeViewModel
    
    @State var selectedDate: Date?
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(homeVM.dates, id: \.self) { date in
                    VStack {
                        Capsule()
                            .fill(selectedDate == date ? .appPurple : .white)
                            .frame(width: 49.aspectRatio, height: 65.aspectRatio)
                            .overlay { 
                                Text(date.toDate(format: "E dd"))
                                    .foregroundStyle(selectedDate == date ? .white : .black)
                                    .font(.subheadline)
                                    .multilineTextAlignment(.center)
                                    .padding(.horizontal, 8.aspectRatio)
                            }
                        Image(.faceScreamingFear)
                            .resizable()
                            .frame(width: 24.aspectRatio, height: 24.aspectRatio)
                    }
                    .onTapGesture {
                        withAnimation(.easeInOut(duration: 0.5)) {
                            selectedDate = date
                        }
                    }
                }
            }
            .onAppear(perform: {
                selectedDate = homeVM.dates.first
            })
        }
    }
}

#Preview {
    DateSelectionView()
}
