//
//  UserManage.swift
//  RecipeDeck
//
//  Created by Lane Affield on 11/24/24.
//

import Foundation
import FirebaseFirestore

struct DBUser: Codable {
    let userId: String
    let email: String?
    let photoURL: String?
    let date: Date?
    let profileName: String
    let tags: [String]?
    let experiencelvl: String?
    let budget: Int?
    let isProfileComplete: Bool
    
    init(auth: AuthDataResultModel) {
        self.userId = auth.uid
        self.email = auth.email
        self.photoURL = auth.photoUrl
        self.date = Date()
        self.isProfileComplete = false
        self.profileName = ""
        self.tags = []
        self.experiencelvl = ""
        self.budget = -1
    }
    init(
    userId: String,
    email: String? = nil,
    photoURL: String? = nil,
    date: Date? = nil,
    profileName: String = "",
    tags: [String]? = nil,
    experiencelvl: String? = nil,
    budget: Int? = nil,
    isProfileComplete: Bool
    ){
        self.userId = userId
        self.email = email
        self.photoURL = photoURL
        self.date = Date()
        self.isProfileComplete = isProfileComplete
        self.profileName = profileName
        self.tags = tags
        self.experiencelvl = experiencelvl
        self.budget = budget
    }
}
    //    init(auth: AuthDataResultModel, profileName: String, tags: [String], Experience : String?, budget: Int) {
    //        self.userId = auth.uid
    //        self.email = auth.email
    //        self.photoURL = auth.photoUrl
    //        self.date = Date()
    //        self.profileName = profileName
    //        self.tags = tags
    //        self.experiencelvl = Experience
    //        self.budget = budget
    //    }
    //}
    
    
    
    final class UserManager{
        
        static let shared = UserManager()
        private init() { }
        
        
        private let userCollection = Firestore.firestore().collection("users")
        private func userDocument(userId: String) -> DocumentReference {
            return userCollection.document(userId)
        }
        
        private let encoder: Firestore.Encoder = {
            let encoder = Firestore.Encoder()
            encoder.keyEncodingStrategy = .convertToSnakeCase
            return encoder
        }()
        
        func createNewUser(user: DBUser) async throws {
            try userDocument(userId: user.userId).setData(from: user, merge: false, encoder: encoder)
        }
        
        //    func createNewUser(auth: AuthDataResultModel) async throws{
        //        var userData: [String: Any] = [
        //            "user_id" : auth.uid,
        //            "date_created" : Timestamp(),
        //        ]
        //        if let email = auth.email{
        //            userData["email"] = email
        //        }
        //        if let photoUrl = auth.photoUrl{
        //            userData["photo_url"] = photoUrl
        //        }
        //        try await userDocument(userId: auth.uid).getDocument()
        //    }
        
        private let decoder: Firestore.Decoder = {
            let decoder = Firestore.Decoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return decoder
        }()
        
        func getUser(userId: String) async throws ->  DBUser {
            try await userDocument(userId: userId).getDocument(as: DBUser.self, decoder: decoder)
        }
        //    func getUser(userId: String) async throws -> DBUser {
        //        let snapshot = try await Firestore.firestore().collection("users").document(userId).getDocument()
        //
        //        guard let data = snapshot.data(), let userId = data["user_id"] as? String else {
        //            throw URLError(.badServerResponse)
        //        }
        //
        //
        //        let email = data["email"] as? String
        //        let photoURL = data["photoURL"] as? String
        //        let date = data["datte_created"] as? Date
        //
        //        return DBUser(userId: userId, email: email, photoURL: photoURL, date: date)
        //    }
        func updateUserProfile(user: DBUser) async throws {
            try  userDocument(userId: user.userId).setData(from: user, merge: true, encoder: encoder )
        }
        
        func getUserSavedPosts(userId: String) async throws {
            
        }
        
        func getUserPosts(userId: String) async throws {
            
        }
        
        func getUserFYP(UserId: String)async throws {
            
        }
    }
