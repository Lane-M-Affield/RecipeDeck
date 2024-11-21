//
//  SwiftUIView.swift
//  RecipeDeck
//
//  Created by Lane Affield on 11/17/24.
//

import SwiftUI

struct RootView: View {
    
    @State private var showSignInView: Bool = false
    
    var body: some View {
        ZStack{
            NavigationStack {
                SettingsView(showSignInView: $showSignInView)
            }
            .navigationBarTitleDisplayMode(.inline)
            .tint(.black)
        }
        .onAppear{
            checkAuthentication()
        }
        
        
        .fullScreenCover(isPresented: $showSignInView){
            NavigationStack{
                LogInView( showSignInView: $showSignInView)
            }
        }
    }
    private func checkAuthentication() {
        do {
            let authUser = try? AuthenticationManager.shared.getAuthenticatedUser()
            self.showSignInView = authUser == nil ? true : false
        }
        }
    }




struct RootViewPreview:
    PreviewProvider{
    static var previews: some View{
        NavigationStack{
            RootView()
        }
    }
}

