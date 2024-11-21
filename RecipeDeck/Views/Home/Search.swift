//
//  Search.swift
//  RecipeDeck
//
//  Created by Lane Affield on 10/27/24.
//
import SwiftUI

struct SearchBar: View{
     var body: some View{
         HStack{
             Image(systemName: "magnifyingglass")
             TextField("Search", text: .constant(""))
             Button("Submit"){print("Submit")}
             
         }
         .padding()
         
    }
}

struct SearchView_Previews:
    PreviewProvider{
    static var previews: some View{
        SearchBar()
    }
}

