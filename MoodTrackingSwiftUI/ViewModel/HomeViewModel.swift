//
//  HomeViewModel.swift
//  MoodTrackingSwiftUI
//
//  Created by MQF-6 on 03/06/24.
//

import Foundation

class HomeViewModel: ObservableObject {
    @Published var dates: [Date] = []
    
    init() {
        generateDates()
    }
    
    private func generateDates() {
        let calendar = Calendar.current
        let today = Date()
        
        for i in 0..<7 {
            if let date = calendar.date(byAdding: .day, value: i, to: today) {
                dates.append(date)
            }
        }
    }
}
