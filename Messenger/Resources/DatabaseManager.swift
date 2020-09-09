//
//  DatabaseManager.swift
//  Messenger
//
//  Created by Bhavesh Saini on 9/6/20.
//  Copyright © 2020 Bhavesh Saini. All rights reserved.
//

import Foundation
import FirebaseDatabase

final class databaseManager {
    static let shared = databaseManager()
    
    private let database = Database.database().reference()
    
}

// MARK: - Account Management

extension databaseManager {
    public func userExists(email: String, completion: @escaping ((Bool) -> Void)){
        var safeEmail = email.replacingOccurrences(of: "@", with: "-")
        safeEmail = email.replacingOccurrences(of: ".", with: "-")
        
        database.child(safeEmail).observeSingleEvent(of: .value, with: {snapshot in
            if snapshot.value as? String != nil {
                completion(true)
            }
            else
            {
                completion(false)
            }
            return
        })
    }
    
    /// Inserts new user to the database
    public func insertUser(user: chatAppUser) {
        
        database.child(user.safeEmail).setValue([
            "first_name": user.firstName,
            "last_name": user.lastName
            ])
    }

}

struct chatAppUser {
    let firstName: String
    let lastName: String
    let emailAddress: String
    
    var safeEmail: String {
        
        var safeEmail = emailAddress.replacingOccurrences(of: "@", with: "-")
        safeEmail = emailAddress.replacingOccurrences(of: ".", with: "-")
        return safeEmail
    }
}
