//
//  GradientBackground.swift
//  MoodTrackingSwiftUI
//
//  Created by MQF-6 on 03/06/24.
//

import SwiftUI

struct GradientBackground: ViewModifier {
    var colors: [Color]
    
    init(colors: [Color]) {
        self.colors = colors
    }
    func body(content: Content) -> some View {
            content
            .background(LinearGradient(colors: colors,
                                        startPoint: UnitPoint(x: 0, y: 0),
                                        endPoint: UnitPoint(x: 1, y: 1)
                         ).ignoresSafeArea())
        }
}

extension View {
    func gradientBackground(colors: [Color] = [.lightOrange, .lightBlue]) -> some View {
        modifier(GradientBackground(colors: colors))
    }
}
