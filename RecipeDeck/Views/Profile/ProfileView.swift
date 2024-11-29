//
//  ProfilePage.swift
//  RecipeDeck
//
//  Created by Lane Affield on 11/11/24.
//

import SwiftUI


@MainActor
final class ProfileViewModel: ObservableObject {
    
    @Published private(set) var user: DBUser? = nil
    
    
    func loadCurrentUser() async throws {
        let authDataResult = try AuthenticationManager.shared.getAuthenticatedUser()
        self.user = try await UserManager.shared.getUser(userId: authDataResult.uid)
    }
    
}
struct ProfileView: View {
    
    @StateObject private var viewModel = ProfileViewModel()
    @Binding var showSignInView: Bool
    @State var showCompleteProfileForm: Bool = false
    
    var body: some View {
        List{
            if let user = viewModel.user {
                Text("Hello, \(user.profileName)")
            }
        }
        .onAppear{
            Task{
                do{
                    try? await viewModel.loadCurrentUser()
                    print("Success")
                    if let user = viewModel.user, !user.isProfileComplete {
                        showCompleteProfileForm = true
                    }
                    }
            }
        }.sheet(isPresented: $showCompleteProfileForm) {
            ProfileSetupForm()
                }
        
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink {
                        SettingsView(showSignInView: $showSignInView)
                    }
                    label: {
                        Image(systemName: "gear")
                            .font(.headline)
                        }
                    }
                }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            ProfileView(showSignInView: .constant(false))
        }
    }
}
