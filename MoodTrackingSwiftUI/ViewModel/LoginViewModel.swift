//
//  LoginViewModel.swift
//  MoodTrackingSwiftUI
//
//  Created by MQF-6 on 05/06/24.
//

import Foundation
import FirebaseAuth
import GoogleSignIn

class LoginViewModel: ObservableObject {
    
    @Published var isLoading = false
    @Published var loginSuccess = false
    
    @Published var toast: Toast?
    
    func loginWithGoogle() {
        guard let presentingViewController = (UIApplication.shared.connectedScenes.first
                                              as? UIWindowScene)?.windows.first?.rootViewController else { return }
        
        isLoading = true
        
        let config = GIDConfiguration(clientID: Constant.GDIClientId)
        GIDSignIn.sharedInstance.configuration = config

        GIDSignIn.sharedInstance.signIn(withPresenting: presentingViewController) { [weak self] signInResult, error in
            guard let `self` = self else {
                return
            }
            
            if error == nil {
                guard let user = signInResult?.user,
                      let idToken = user.idToken?.tokenString else {
                    AppPrint.print("user not found ")
                    isLoading = false
                    return
                }
                googleLoginFirebase(withIDToken: idToken, accessToken: user.accessToken.tokenString)
                
            } else {
                isLoading = false
                toast = Toast(message: "Google login error: \(error?.localizedDescription ?? "")")
            }
        }
    }
    
    func googleLoginFirebase(withIDToken: String, accessToken: String) {
        let credential = GoogleAuthProvider.credential(withIDToken: withIDToken, accessToken: accessToken)
        Auth.auth().signIn(with: credential) { [weak self] authResult, authError in 
            guard let `self` = self else {
                return
            }
            
            isLoading = false

            if authError == nil {
                let authUser = authResult?.user
                let name = "\(authUser?.displayName?.split(separator: " ").first ?? "")"
                
                let user = MDLUser(name: name, phone: authUser?.phoneNumber, email: authUser?.email, uid: authUser?.uid)
                
                do {
                    try UserDefaults.standard.set<MDLUser>(object: user.self, forKey: "User")
                    Constant.user = user
                    loginSuccess = true
                } catch let error {
                    toast = Toast(message: error.localizedDescription)
                }
            } else {
                toast = Toast(message: authError?.localizedDescription ?? "")
            }
        }
    }
}
