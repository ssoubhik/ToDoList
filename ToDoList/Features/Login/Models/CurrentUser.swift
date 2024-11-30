//
//  CurrentUser.swift
//  ToDoList
//
//  Created by Soubhik Sarkhel on 29/11/24.
//

import Foundation
import FirebaseFirestore

// MARK: - Current User Data Model

struct CurrentUser: Codable, Identifiable {
    @DocumentID var id: String?
    let uid, firstName, lastName, email, userType: String?
    let phoneNo, displayName: String?
}
