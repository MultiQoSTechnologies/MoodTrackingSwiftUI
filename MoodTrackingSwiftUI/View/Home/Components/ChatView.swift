//
//  ChatView.swift
//  MoodTrackingSwiftUI
//
//  Created by MQF-6 on 03/06/24.
//

import SwiftUI
import Charts

struct MoodData: Identifiable {
    let id = UUID()
    let time: String
    let moodLevel: Double
    let color: Color
    let emoji: String
}

struct ChartView: View {
    let moodData: [MoodData] = [
        MoodData(time: "10:08", moodLevel: 90, color: .appGreen, emoji: "face_screaming_fear"),
        MoodData(time: "12:10", moodLevel: 10, color: .appRed, emoji: "face_steam_from_nose"),         MoodData(time: "14:40", moodLevel: 50, color: .appSkyBlue, emoji: "nauseated_face"),
        MoodData(time: "18:30", moodLevel: 25, color: .appOrange, emoji: "pouting_face"),
        MoodData(time: "20:1", moodLevel: 10, color: .appRed, emoji: "smiling_face"),
        MoodData(time: "10:10", moodLevel: 40, color: .appSkyBlue, emoji: "woozy_face")
    ]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Mood Chart")
                .font(.title3)
                .padding(.leading, 30.aspectRatio)
            ZStack {
                Chart(moodData) { data in
                    BarMark(
                        x: .value("Time", data.time),
                        y: .value("Mood Level", 150),
                        width: MarkDimension(floatLiteral: 30.aspectRatio)
                    )
                    .foregroundStyle(.appWhite)
                    .cornerRadius(15.aspectRatio)
                    
                }
                .chartYAxis {
                    AxisMarks(position: .leading) {
                        AxisValueLabel()
                            .foregroundStyle(.clear)
                    }
                }
                .chartXAxis {
                    AxisMarks(position: .bottom) { _ in
                        AxisValueLabel()
                            .foregroundStyle(.clear)
                    }
                }
                .offset(x: -15.aspectRatio)
                .frame(height: 250.aspectRatio)
                .padding()
                
                Chart(moodData) { data in
                    BarMark(
                        x: .value("Time", data.time),
                        y: .value("Mood Level", data.moodLevel),
                        width: MarkDimension(floatLiteral: 30.aspectRatio)
                    )
                    .foregroundStyle(data.color)
                    .cornerRadius(15.aspectRatio)
                    .annotation(position: .overlay, alignment: .top) {
                        Image(.faceScreamingFear)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    }
                    
                }
                .chartYAxis {
                    AxisMarks(position: .leading) {
                        AxisValueLabel()
                            .foregroundStyle(.clear)
                    }
                }
                .chartXAxis {
                    AxisMarks(position: .bottom) { _ in
                        AxisValueLabel()
                            .offset(y: 10.aspectRatio)
                            .foregroundStyle(.black)
                            .font(.caption)
                    }
                }
                .offset(x: -15.aspectRatio)
                .frame(height: 250.aspectRatio)
                .padding()
            }
        }
        .padding(.vertical, 20.aspectRatio)
        .background(.lightPurple)
        .clipShape(.rect(cornerRadius: 15.aspectRatio))
        
    }
}

struct ChartView_Previews: PreviewProvider {
    static var previews: some View {
        ChartView()
    }
}
