import SwiftUI

final class SignUpEmailViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var confirmPassword = ""
    @Published var errorMessage: String? = nil
    
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
            let _ = try await AuthenticationManager.shared.createUser(email: email, password: password)
                
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}


struct SignUpForm: View {
    @StateObject private var viewModel = SignUpEmailViewModel()
    @Binding var showSignUpView: Bool
    
    var body: some View {
        VStack {
            // Email TextField
            TextField("Email", text: $viewModel.email)
                .padding(.bottom, 8)
                .overlay(
                    Rectangle()
                        .frame(height: 3)
                        .foregroundColor(.black),
                    alignment: .bottom
                )
                .padding(.horizontal, 16)
                .autocapitalization(.none)
                .keyboardType(.emailAddress)
            
            // Password SecureField
            SecureField("Password", text: $viewModel.password)
                .padding(.bottom, 8)
                .overlay(
                    Rectangle()
                        .frame(height: 3)
                        .foregroundColor(.black),
                    alignment: .bottom
                )
                .padding(.horizontal, 16)
            
            // Confirm Password SecureField
            SecureField("Confirm Password", text: $viewModel.confirmPassword)
                .padding(.bottom, 8)
                .overlay(
                    Rectangle()
                        .frame(height: 3)
                        .foregroundColor(.black),
                    alignment: .bottom
                )
                .padding(.horizontal, 16)
            
            // Sign Up Button
            Button {
                Task {
                    do {
                        try await viewModel.signUp()
                        showSignUpView = false
                        print(showSignUpView)
                    } catch {
                        print("Sign-up failed: \(error)")
                    }
                }
            } label: {
                Text("Sign Up")
                    .padding()
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(height: 50)
                    .frame(maxWidth: .infinity)
                    .background(Color.black)
                    .cornerRadius(10)
            }
            .padding()
            
            // Error Message
            if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .multilineTextAlignment(.center)
                    .padding()
            }
        }
        .navigationTitle("Sign Up")
        .padding()
    }
}


struct signUpForm_Previews:
    PreviewProvider{
    static var previews: some View{
        NavigationStack{
            SignUpForm(showSignUpView: .constant(false))
        }
    }
}
