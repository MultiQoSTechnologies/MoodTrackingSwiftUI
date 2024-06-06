//
//  LoginView.swift
//  MoodTrackingSwiftUI
//
//  Created by MQF-6 on 05/06/24.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject private var loginVM: LoginViewModel
    @EnvironmentObject private var router: Router
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                Text("Welcome, \nContinue Login")
                    .font(.title)
                    .fontWeight(.bold)
                
                Spacer()
                
                Button(action: {
                    loginVM.loginWithGoogle()
                }, label: {
                    HStack(spacing: 10.aspectRatio) {
                        Spacer()
                        Image(.googleLogo)
                            .resizable()
                            .frame(width: 24.aspectRatio, height: 24.aspectRatio)
                        
                        Text("Continue with Google")
                            .fontWeight(.semibold)
                            .foregroundStyle(.black)
                        Spacer()
                    }
                    .padding(12.aspectRatio)
                    .background(.white)
                    .clipShape(.capsule)
                    .shadow(color: .gray.opacity(0.3), radius: 5, y: 5)
                })
                Spacer()
            }.padding(16.aspectRatio)
        }
        .gradientBackground()
        .navigationBarBackButtonHidden()
        .loader(loading: loginVM.isLoading)
        .toast(toast: $loginVM.toast)
        .onChange(of: loginVM.loginSuccess, perform: { value in
            if value {
                router.navigate(to: .home)
            }
        })
    }
}

#Preview {
    LoginView()
        .environmentObject(LoginViewModel())
}
