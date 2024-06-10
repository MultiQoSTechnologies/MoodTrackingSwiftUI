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
 
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            VStack {
                VStack {
                    HomeHeaderView()
                    
                    DateSelectionView() 
                    
                    ScrollView {
                        MoodDetailView()
                    }.scrollIndicators(.hidden)
                }
                
                
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
        .task {
            await homeVM.getEmotionDetailsData()
        }
        .alert("Logout", isPresented: $homeVM.showAlert) {
            Button {
                
            } label: {
                Text("Cancel")
            }
            
            Button {
                homeVM.logout()
                router.navigateToRoot()
            } label: {
                Text("Logout")
            }
        } message: {
            Text("Are you sure want to logout?")
        }
        .overlay(alignment: .center) {
            if homeVM.arrEmotionDetails.filter({Date(milliseconds: Int64($0.createdAt ?? 0)).toDate(format: "dd/MM/yyyy") == homeVM.selectedDate?.toDate(format: "dd/MM/yyyy")}).count == 0 {
                Text("No Data Found")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
            }
        }
    }
}

#Preview {
    HomeView()
        .environmentObject(HomeViewModel())
}


