//
//  ContentView.swift
//  MoodTrackingSwiftUI
//
//  Created by MQF-6 on 03/06/24.
//

import SwiftUI
import Charts 

struct HomeView: View {
    
    @EnvironmentObject private var homeVM: HomeViewModel
    @EnvironmentObject private var router: Router
 
    @State private var expanded = false
    @State private var showQA = false 
    
    @State var showAlert = false
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            VStack {
                VStack {
                    HomeHeaderView()
                    
                    ScrollView(showsIndicators: false) {
                        DateSelectionView()
                        ChartView()
                            .padding(.top, 30.aspectRatio)
                            .animation(nil)
                        
                        MoodDetailCardView(expanded: $expanded)
                    }
                }
                Spacer()
                
            }.padding(.horizontal, 20.aspectRatio)
            
            Button {
                router.navigate(to: .emotionSelection)
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
        .navigationBarBackButtonHidden()
        .loader(loading: homeVM.isLoading)
        .toast(toast: $homeVM.toast)
        .alert("Logout", isPresented: $showAlert) {
            Button {
            } label: {
                Text("Cancel")
            }
            
            Button {
                Constant.user = nil
                try? UserDefaults.standard.set(object: Constant.user, forKey: "User")
                router.navigateToRoot()
            } label: {
                Text("Logout")
            }
        } message: {
            Text("Are you sure want to logout?")
        }
    }
}

#Preview {
    HomeView()
        .environmentObject(HomeViewModel())
}


