//
//  Post.swift
//  RecipeDeck
//
//  Created by Lane Affield on 10/27/24.
//

import SwiftUI

struct UserPost: View {
    var body: some View{
        VStack{
            HStack{
                Image(systemName: "person.crop.circle")
                VStack{
                    Text("User")
                        .font(.headline)
                    Text("Recipe name")
                        .font(.title)
                }
        
            }
            Image(systemName: "camera.badge.ellipsis")
            HStack{
                Button("Rate") {
                    print("Rate")
                }
                Button("Favorite") {
                    print("Fav")
                }
                Button("Comment"){
                    print("Comment")
                }
            }
            Text("Tags")
            Text("Discription")
        
        
    }
}
struct PostView_Previews:
    PreviewProvider{
    static var previews: some View{
        UserPost()
    }
}
}
