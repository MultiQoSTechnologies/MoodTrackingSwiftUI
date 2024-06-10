//
//  MoodDetailCardView.swift
//  MoodTrackingSwiftUI
//
//  Created by MQF-6 on 03/06/24.
//

import SwiftUI
import SDWebImageSwiftUI 

struct MoodDetailCardView: View {
    
    @EnvironmentObject private var homeVM: HomeViewModel
 
    @State var emotion: MDLEmotionDetail
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12.aspectRatio) {
            HStack {
                AnimatedImage(url: URL(string: emotion.moods?.first?.img ?? ""))
                    .resizable()
                    .frame(width: 45.aspectRatio, height: 45.aspectRatio)
                    .aspectRatio(contentMode: .fill)
                
                VStack(alignment: .leading) {
                    Text(emotion.moodHeader?.removeAsterisks() ?? "")
                        .font(.title3)
                        .bold()
                    
                    Text("\(Date(milliseconds: Int64(emotion.createdAt ?? 0)).hm)")
                        .font(.caption)
                        .foregroundStyle(.black.opacity(0.8))
                }
                .padding(.leading, 5.aspectRatio)
                
                Spacer()
                
                HStack {  
                    Button(action: {
                        Task {
                            await homeVM.deleteEmotionDetail(docId: emotion.id!)
                        }
                    }, label: {
                        Text("Delete")
                            .foregroundStyle(.appRed)
                    })
                }
            }
            
            HStack(alignment: .top) {
                Text("You felt ")
                    .foregroundColor(.black.opacity(0.8)) +
                Text("\(emotion.moods?.map{$0.mood ?? ""}.joined(separator: ", ") ?? "")")
                    .bold()
            }
            
            HStack(alignment: .top) {
                Text("Because of ")
                    .foregroundColor(.black.opacity(0.8)) +
                Text("\(emotion.reasons?.map{$0.reason}.joined(separator: ", ") ?? "")")
                    .bold()
            }
            
            HStack(alignment: .top) {
                Text("Note: ")
                    .bold() +
                Text(emotion.onmind?.removeAsterisks() ?? "")
            }.lineLimit(emotion.expanded ? nil : 2)
            
            if (emotion.onmind?.count ?? 0) > 80 {
                Text(emotion.expanded ? "- Read less" : "+ Read more")
                    .foregroundStyle(.appPurple)
                    .onTapGesture {
                        withAnimation {
                            homeVM.toggleExpanded(for: emotion)
                        }
                    }
            }
            
            Divider()
                .frame(height: 1)
                .padding(5.aspectRatio)
            
            VStack(alignment: .leading, spacing: 10.aspectRatio) {
                HStack(alignment: .top) {
                    Text("\(emotion.tipHeader?.removeAsterisks() ?? "")")
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
                
                Text(emotion.tip?.removeAsterisks() ?? "")
                    .foregroundColor(.black.opacity(0.8))
                    .lineLimit(emotion.expandedTip ? nil : 2)
                
                if (emotion.tip?.count ?? 0) > 80 {
                    Text(emotion.expandedTip ? "- Read less" : "+ Read more")
                        .foregroundStyle(.appPurple)
                        .onTapGesture {
                            withAnimation {
                                homeVM.toggleExpandedTip(for: emotion)
                            }
                        }
                }
            }
        }
        .animation(.linear, value: emotion.expanded)
        .padding(15.aspectRatio)
        .background(.white)
        .clipShape(.rect(cornerRadius: 15.aspectRatio))
        .padding(.top, 15.aspectRatio)
    }
}

#Preview {
    MoodDetailCardView(emotion: MDLEmotionDetail())
        .environmentObject(HomeViewModel())
}

struct MoodDetailView: View {
    @EnvironmentObject private var homeVM: HomeViewModel
    
    var body: some View {
        ForEach(homeVM.arrEmotionDetails.filter{Date(milliseconds: Int64($0.createdAt ?? 0)).toDate(format: "dd/MM/yyyy") == homeVM.selectedDate?.toDate(format: "dd/MM/yyyy")}, id: \.id) { emotion in
            MoodDetailCardView(emotion: emotion)
        } 
    }
}
