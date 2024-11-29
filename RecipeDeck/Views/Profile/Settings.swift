//
//  userSettings.swift
//  RecipeDeck
//
//  Created by Lane Affield on 11/11/24.
//

import SwiftUI

@MainActor
final class SettingsViewModel: ObservableObject {
    func signOut() throws {
        try AuthenticationManager.shared.signOut()
    }
    func resetPassword() async throws {
        let authUser = try AuthenticationManager.shared.getAuthenticatedUser()
        guard let email = authUser.email else{
            throw URLError(.fileDoesNotExist)
        }
        try await AuthenticationManager.shared.resetPassword(email: email)
    
    }
    func deleteAccount() async throws {
        try await AuthenticationManager.shared.delete()
    }
}

struct SettingsView: View {
    
    @StateObject private var viewModel = SettingsViewModel()
    @Binding var showSignInView: Bool
    var body: some View {
        List {
            Button("Sign Out"){
                Task{
                    do{
                        try viewModel.signOut()
                        showSignInView = true
                    } catch { print(error)
                        
                    }
                }
            }
            Button("Password Reset"){ Task { do{ try await viewModel.resetPassword()
                print("Password RESET!")}
                catch{print(error)}}
            }
            .navigationBarTitle("Settings")
            
            Button(role: .destructive){
                Task {
                    do {
                        try await viewModel.deleteAccount()
                        showSignInView = true
                    } catch {
                        print(error)
                    }
                }
            } label: {
                Text("delete Account")
                
            }
        }
    }
}
        
        
struct SettingsView_Previews: PreviewProvider{
    static var previews: some View {
        NavigationStack{
            SettingsView(showSignInView: .constant(false))
        }
    }
}
