//
//  LogInFormView.swift
//  RecipeDeck
//
//  Created by Lane Affield on 10/16/24.
//

import SwiftUI
@MainActor
final class SignInEmailViewModel: ObservableObject{
    @Published var email = ""
    @Published var password = ""
    
    
    func signIn() async throws {
        guard !email.isEmpty, !password.isEmpty
        else {
            print("No Email Found")
            return
        }
        print(password)
        print(email)
        let _ = try await AuthenticationManager.shared.signInUser(email: email, password: password)
        
    }
}


        struct LogInForm: View {
            @StateObject private var  viewModel = SignInEmailViewModel()
            @Binding var showSignInView: Bool
            var body: some View {
                VStack {
                    
                    TextField("Email", text: $viewModel.email)
                        .padding(.bottom, 8) // Add padding above the line
                        .overlay(
                            Rectangle()
                                .frame(height: 3) // Set the height of the line
                                .foregroundColor(.black), // Line color
                            alignment: .bottom // Position the line at the bottom
                        )
                        .padding(.horizontal, 16) // Optional: Add horizontal padding
                    SecureField("Password", text: $viewModel.password)
                        .padding(.bottom, 8) // Add padding above the line
                        .overlay(
                            Rectangle()
                                .frame(height: 3) // Set the height of the line
                                .foregroundColor(.black), // Line color
                            alignment: .bottom // Position the line at the bottom
                        )
                        .padding(.horizontal, 16) // Optional: Add horizontal padding
                    HStack{
                        NavigationLink{
                            SignUpForm(showSignUpView: $showSignInView)
                        } label: {
                            Text("Sign Up")
                                .padding()
                                .font(.headline)
                                .font(.custom("Georgia", size: 16))
                                .foregroundColor(.white)
                                .frame(height: 50)
                                .frame(maxWidth: .infinity)
                                .background(Color.black)
                                .cornerRadius(10)
                        }
                        
                        
                        Button{
                            Task{
                                do{
                                    try await viewModel.signIn()
                                    showSignInView = false
                                    print(showSignInView)}catch{print(error)}
                        }
                        }label: {
                            Text("Sign in")
                                .padding()
                                .font(.headline)
                                .font(.custom("Georgia", size: 16))
                                .foregroundColor(.white)
                                .frame(height: 50)
                                .frame(maxWidth: .infinity)
                                .background(Color.black)
                                .cornerRadius(10)
                        }
                    }
                    .padding()
                    .navigationTitle("Sign In")
                    
                }
                
            }
        }



struct LoginForm_Previews:
    PreviewProvider{
    static var previews: some View{
        NavigationStack{
            LogInForm(showSignInView: .constant(false))
        }
    }
}
