//
//  FlowLayout.swift
//  MoodTrackingSwiftUI
//
//  Created by MQF-6 on 06/06/24.
//

import SwiftUI
 
struct FlowLayout<Data: RandomAccessCollection, Content: View>: View where Data.Element: Identifiable {
    var data: Data
    var spacing: CGFloat
    var content: (Data.Element) -> Content
    
    init(data: Data, spacing: CGFloat = 10, @ViewBuilder content: @escaping (Data.Element) -> Content) {
        self.data = data
        self.spacing = spacing
        self.content = content
    }
    
    var body: some View {
        GeometryReader { geometry in
            self.generateContent(in: geometry)
        } 
    }
    
    private func generateContent(in geometry: GeometryProxy) -> some View {
        var width = CGFloat.zero
        var height = CGFloat.zero
        
        return ScrollView {
            ZStack(alignment: .topLeading) {
                ForEach(data) { item in
                    self.content(item)
                        .padding([.horizontal, .vertical], spacing / 2)
                        .alignmentGuide(.leading, computeValue: { d in
                            if (abs(width - d.width) > geometry.size.width) {
                                width = 0
                                height -= d.height
                            }
                            let result = width
                            if item.id == self.data.last!.id {
                                width = 0 // last item
                            } else {
                                width -= d.width
                            }
                            return result
                        })
                        .alignmentGuide(.top, computeValue: {d in
                            let result = height
                            if item.id == self.data.last!.id {
                                height = 0 // last item
                            }
                            return result
                        })
                }
            }
        }
        .scrollIndicators(.hidden)
    }
}
