//
//  EmailHelper.swift
//  RecipeDeck
//
//  Created by Lane Affield on 11/24/24.
//
import Foundation
@MainActor
final class SignInEmailViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var confirmPassword = ""
    @Published var errorMessage: String? = nil
    
    func signIn() async throws {
        guard !email.isEmpty, !password.isEmpty
        else {
            print("No Email Found")
            return
        }

        let authDataResult = try await AuthenticationManager.shared.signInUser(email: email, password: password)
//        try await UserManager.shared.createNewUser(auth: authDataResult)
        let user = DBUser(auth: authDataResult)
        try await UserManager.shared.createNewUser(user: user)
    }
    
    func signUp() async throws {
        guard !email.isEmpty, !password.isEmpty, !confirmPassword.isEmpty else {
            errorMessage = "All fields are required."
            return
        }
        
        guard password == confirmPassword else {
            errorMessage = "Passwords do not match."
            return
        }
        
        // Perform email and password validation (e.g., check password strength).
        guard email.contains("@") else {
            errorMessage = "Enter a valid email address."
            return
        }
        
        // Attempt to sign up the user.
        do {
            let authDataResult = try await AuthenticationManager.shared.createUser(email: email, password: password)
    //        try await UserManager.shared.createNewUser(auth: authDataResult)
            let user = DBUser(auth: authDataResult)
            try await UserManager.shared.createNewUser(user: user)
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}
