import SwiftUI

struct SignUpForm: View {
    @StateObject private var viewModel = SignInEmailViewModel()
    @Binding var showSignUpView: Bool
    @State private var isPasswordVisible: Bool = false

    var body: some View {
        NavigationStack{
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
                            print("Success")
                            showSignUpView = false
                            
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
}


struct signUpForm_Previews:
    PreviewProvider{
    static var previews: some View{
        NavigationStack{
            SignUpForm(showSignUpView: .constant(false))
        }
    }
}
