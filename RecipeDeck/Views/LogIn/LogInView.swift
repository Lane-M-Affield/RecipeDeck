//
//  LogInView.swift
//  RecipeDeck
//
//  Created by Lane Affield on 10/12/24.
//
import SwiftUI

struct LogInView: View {
    @Binding var showSignInView: Bool
    var body: some View{
        VStack{
            NavigationLink{
                LogInForm(showSignInView: $showSignInView)
            } label: {
                Text("Sign in w/ Email")
                    .padding()
                    .font(.headline)
                    .font(.custom("Georgia", size: 16))
                    .foregroundColor(.white)
                    .frame(height: 50)
                    .frame(maxWidth: .infinity)
                    .background(Color.black)
                    .cornerRadius(10)
            }
            NavigationLink {
                            SignUpForm(showSignUpView: $showSignInView) // Assuming SignUpForm exists
                        } label: {
                            Text("Sign up with Email")
                                .padding()
                                .font(.headline)
                                .font(.custom("Georgia", size: 16))
                                .foregroundColor(.white)
                                .frame(height: 50)
                                .frame(maxWidth: .infinity)
                                .background(Color.black) // Differentiate from sign-in button
                                .cornerRadius(10)
                        }
            

            }
        }
    }

struct LoginView_Previews:
    PreviewProvider{
    static var previews: some View{
        NavigationStack{
            LogInView(showSignInView: .constant(false))
        }
    }
}
