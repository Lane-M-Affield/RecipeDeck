//
//  Navbar.swift
//  RecipeDeck
//
//  Created by Lane Affield on 10/27/24.
//

import SwiftUI

struct Navigation: View{
    var body: some View{
        HStack{
            Button("Home"){print("home")}
            Button("Profile"){print("Home")}
            Button("Add Post"){print("Home")}
            
        }
    }
}
    
    struct PostView_Previews:
        PreviewProvider{
        static var previews: some View{
            Navigation()
        }
    }

