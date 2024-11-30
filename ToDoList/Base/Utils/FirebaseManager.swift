//
//  FirebaseManager.swift
//  ToDoList
//
//  Created by Soubhik Sarkhel on 29/11/24.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

// MARK: - Firebase Config Manager

class FirebaseManager {
    static let shared = FirebaseManager()
    
    var currentUser: CurrentUser?
    var auth: Auth?
    var firestore: Firestore?

    private init() {}

    func setup() {
        self.auth = Auth.auth()
        self.firestore = Firestore.firestore()
    }
}
