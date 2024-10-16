//
//  LogInView.swift
//  RecipeDeck
//
//  Created by Lane Affield on 10/12/24.
//
import SwiftUI

struct LoginView: View {
    var body: some View{
        ZStack{
            VStack{
                Text("Recipe Deck")
                    .font(.title)
                Spacer()
                Form {
                    Button("Log In") {
                        print("Login")
                    
                    }
                    Button("Sign Up"){
                        print("sign up")
                    }
                }

            }
        }
    }
}

struct ContentView_Previews:
    PreviewProvider{
    static var previews: some View{
        LoginView()
    }
}
