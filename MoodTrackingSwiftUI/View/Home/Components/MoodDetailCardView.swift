//
//  MoodDetailCardView.swift
//  MoodTrackingSwiftUI
//
//  Created by MQF-6 on 03/06/24.
//

import SwiftUI

struct MoodDetailCardView: View {
    
    @EnvironmentObject var homeVM: HomeViewModel
 
    @Binding var expanded: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12.aspectRatio) {
            HStack {
                Image(.faceScreamingFear)
                    .resizable()
                    .frame(width: 45.aspectRatio, height: 45.aspectRatio)
                    .aspectRatio(contentMode: .fill)
                
                VStack(alignment: .leading) {
                    Text("Teribble")
                        .font(.title3)
                        .bold()
                    
                    Text("20:10")
                        .font(.caption)
                        .foregroundStyle(.black.opacity(0.8))
                }
                .padding(.leading, 5.aspectRatio)
                
                Spacer()
                
                HStack {  
                    Button(action: {}, label: {
                        Text("Delete")
                            .foregroundStyle(.appRed)
                    })
                }
            }
            
            HStack(alignment: .top) {
                Text("You felt ")
                    .foregroundColor(.black.opacity(0.8)) +
                Text("Disappointed, Confused Disappointed, Confused")
                    .bold()
            }
            
            HStack(alignment: .top) {
                Text("Because of ")
                    .foregroundColor(.black.opacity(0.8)) +
                Text("Work")
                    .bold()
            }
            
            HStack(alignment: .top) {
                Text("Note:")
                    .bold() +
                Text("The day didn’t go well in morning. I tried to make coffee, but it burned out. I missed my bus. The day didn’t go well in morning. I tried to make coffee, but it burned out. I missed my bus,The day didn’t go well in morning. I tried to make coffee, but it burned out. I missed my bus")
            }.lineLimit(expanded ? nil : 2)
            
            Text(expanded ? "- Read less" : "+ Read more")
                .foregroundStyle(.appPurple)
                .onTapGesture {
                    withAnimation {
                        expanded.toggle()
                    }
                }
            
            Divider()
                .frame(height: 1)
                .padding(5.aspectRatio)
            
            VStack(alignment: .leading, spacing: 10.aspectRatio) {
                HStack(alignment: .top) {
                    Text("Connect with nature")
                        .bold()
                    
                    Spacer()
                    
                    HStack(spacing: 3) {
                        Image(.lampOn)
                            .resizable()
                            .frame(width: 24.aspectRatio, height: 24.aspectRatio)
                        Text("Tip")
                            .font(.system(size: 16.aspectRatio, weight: .semibold))
                    }.foregroundStyle(.yellow)
                }
                Text("Spend time outdoors, surrounded by greenery and fresh air")
                    .foregroundColor(.black.opacity(0.8))
            }
            
        }
        .animation(.linear, value: expanded)
        .padding(15.aspectRatio)
        .background(.white)
        .clipShape(.rect(cornerRadius: 15.aspectRatio))
        .padding(.top, 15.aspectRatio)
        .onAppear(perform: {
            Task {
                await homeVM.getEmotionDetailsData()
            }
        })
    }
}

#Preview {
    MoodDetailCardView(expanded: .constant(true))
}
