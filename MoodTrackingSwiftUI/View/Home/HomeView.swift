//
//  ContentView.swift
//  MoodTrackingSwiftUI
//
//  Created by MQF-6 on 03/06/24.
//

import SwiftUI
import Charts 

struct HomeView: View {
    @EnvironmentObject var homeVM: HomeViewModel
    
    @State private var expanded = false
    @State private var showQA = false 
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            VStack {
                VStack {
                    HomeHeaderView()
                    
                    ScrollView(showsIndicators: false) {
                        DateSelectionView()
                        ChartView()
                            .padding(.top, 30.aspectRatio)
                            .animation(nil, value: expanded)
                        
                        MoodDetailCardView(expanded: $expanded)
                    }
                
                }
                Spacer()
            }.padding(.horizontal, 20.aspectRatio)
            
            Button {
                showQA = true
            } label: {
                VStack {
                    Image(systemName: "plus")
                        .frame(width: 55.aspectRatio, height: 55.aspectRatio)
                        .background(.appPurple)
                        .foregroundStyle(.white)
                        .clipShape(.rect(cornerRadius: 15.aspectRatio))
                }
            }.padding()
        }
        .gradientBackground()
        .sheet(isPresented: $showQA, content: {
            EmotionSelectionView()
        })
    }
}

#Preview {
    HomeView()
        .environmentObject(HomeViewModel())
}


