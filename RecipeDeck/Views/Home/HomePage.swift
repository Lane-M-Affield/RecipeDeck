//
//  HomePage.swift
//  RecipeDeck
//
//  Created by Lane Affield on 10/27/24.
//

import SwiftUI

struct HomePage: View {
    var body : some View {
        VStack{
            SearchBar()
            Spacer()
            UserPost()
            Spacer()
            Navigation()
            
            
        }
        .padding()
    }
}

struct HomeView_Previews:
    PreviewProvider{
    static var previews: some View{
        HomePage()
    }
}

