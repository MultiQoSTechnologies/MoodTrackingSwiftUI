//
//  MoodTrackingSwiftUIApp.swift
//  MoodTrackingSwiftUI
//
//  Created by MQF-6 on 03/06/24.
//

import SwiftUI

@main
struct MoodTrackingSwiftUIApp: App {
    
    @StateObject var homeVM = HomeViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                HomeView()
                    .environmentObject(homeVM)
            }
        }
    }
}
