//
//  MoodTrackingSwiftUIApp.swift
//  MoodTrackingSwiftUI
//
//  Created by MQF-6 on 03/06/24.
//

import SwiftUI
import Firebase
import GoogleSignIn
import SDWebImageSwiftUI

@main
struct MoodTrackingSwiftUIApp: App {
    
    init() { 
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            AppNavigationView()
                .onOpenURL { url in
                    GIDSignIn.sharedInstance.handle(url)
                }
        }
    }
}
