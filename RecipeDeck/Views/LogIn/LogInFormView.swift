//
//  LogInFormView.swift
//  RecipeDeck
//
//  Created by Lane Affield on 10/16/24.
//

import SwiftUI

struct LogInForm: View {
    @State private var username: String = ""
    @State private var password: String = ""
    var body: some View {
        VStack {
            Text("Log In")
            TextField("Email", text: $username)
            TextField("Password", text: $password)
            HStack{
                Button("Sign Up"){print("Signup")}
                Button("Continue ->"){print("Continue")}
            }
        }
    }
    
}




struct LoginForm_Previews:
    PreviewProvider{
    static var previews: some View{
        LogInForm()
    }
}
