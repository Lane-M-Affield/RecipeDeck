//
//  SignUpFormView.swift
//  RecipeDeck
//
//  Created by Lane Affield on 10/16/24.
//

import SwiftUI

struct SignUpForm: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    var body: some View {
        VStack {
            Text("Log In")
            TextField("Email", text: $username)
            TextField("Password", text: $password)
            TextField("Confirm Password", text: $confirmPassword)
            HStack{
                Button("Sign Up"){print("LogIn")}
                Button("Continue ->"){print("Continue")}
            }
        }
    }
    
}



struct SignUpForm_Previews:
    PreviewProvider{
    static var previews: some View{
        SignUpForm()
    }
}
