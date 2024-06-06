//
//  AppNavView.swift
//  NavigationDemo
//
//  Created by MQF-6 on 02/04/24.
//

import SwiftUI
  
struct AppNavigationView: View {
    @StateObject var homeVM = HomeViewModel()
    @StateObject var loginVM = LoginViewModel()
    @StateObject var emotionqaVM = EmotionQAViewModel()
    
    @ObservedObject var router = Router()
    @State var isShowingFullScreen = false
    
    var user: MDLUser? {
        do {
            let authUser = try UserDefaults.standard.get(objectType: MDLUser.self, forKey: "User")
            Constant.user = authUser
            return authUser
        } catch let e {
            AppPrint.print("Error in decoading user: \(e.localizedDescription)")
            return nil
        }
    }
    
    var body: some View {
        NavigationStack(path: $router.navPath) {
            VStack {
                if user == nil {
                    LoginView()
                        .environmentObject(loginVM)
                } else {
                    HomeView()
                        .environmentObject(homeVM)
                }
            }
            .navigationDestination(for: Router.Destination.self) { destinaiton in
                switch destinaiton {
                case .login:
                    LoginView()
                        .environmentObject(loginVM)
                case .home:
                    HomeView()
                        .environmentObject(homeVM)
                case .emotionSelection:
                    EmotionSelectionView()
                        .environmentObject(emotionqaVM)
                case .whatMadeFeel:
                    WhatMadeFeelView()
                        .environmentObject(emotionqaVM)
                case .thingYouWantAdd:
                    ThingYouWantAddView()
                        .environmentObject(emotionqaVM)
                case .congratulate:
                    CongratulationView()
                }
            }
        }
        .environmentObject(router)
    }
}

#Preview {
    AppNavigationView()
}

