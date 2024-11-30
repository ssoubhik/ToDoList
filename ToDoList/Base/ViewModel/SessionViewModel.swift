//
//  SessionViewModel.swift
//  ToDoList
//
//  Created by Soubhik Sarkhel on 29/11/24.
//

import SwiftUI

// MARK: - Session ViewModel Protocol

protocol SessionViewModel {
    func createAccount() async
    func login() async
}

// MARK: - Session ViewModel Implementation

@MainActor
final class SessionViewModelImpl: ObservableObject, SessionViewModel {
    // local storage properties
    @AppStorage(StorageKeys.currentFlow) var currentFlow = AppFlow.landing
    @AppStorage(StorageKeys.firebaseUID) var firebaseUID = ""

    @Published var loginDetails = LoginDetails.new
    @Published var createAccountDetails = CreateAccountDetails.new
    @Published var showGlobalLoader = false
    @Published var errorHandler = Handler()

    // Method: create account in firebase
    func createAccount() async {
        do {
            // validate create account details
            try validateCreateAccountDetails()
            
            // start loader
            showGlobalLoader = true

            // create user in firebase auth
            let res = try await FirebaseManager.shared.auth?.createUser(
                withEmail: createAccountDetails.email,
                password: createAccountDetails.password
            )
            
            // store user info in firestore
            try await saveUserInfoInFirestore()

            // successful, move the user to dashboard
            showGlobalLoader = false
            firebaseUID = res?.user.uid ?? ""
            currentFlow = .loggedIn
        } catch {
            // general error
            showGlobalLoader = false
            errorHandler.isPresented = true
            errorHandler.description = error.localizedDescription
        }
    }

    // Method: login user with firebase
    func login() async {
        do {
            // validate login details
            try validateLoginDetails()
            
            // start loader
            showGlobalLoader = true
            
            // call login api
            let res = try await FirebaseManager.shared.auth?.signIn(
                withEmail: loginDetails.email,
                password: loginDetails.password
            )

            // successful, move the user to dashboard
            showGlobalLoader = false
            firebaseUID = res?.user.uid ?? ""
            currentFlow = .loggedIn
        } catch {
            // general error
            showGlobalLoader = false
            errorHandler.isPresented = true
            errorHandler.description = error.localizedDescription
        }
    }
    
    // Method: save userinfo in Firestore
    func saveUserInfoInFirestore() async throws {
        guard let uid = FirebaseManager.shared.auth?.currentUser?.uid else { return }
        
        let userData = [
            FirestoreUser.firstName.key: createAccountDetails.firstName,
            FirestoreUser.lastName.key: createAccountDetails.lastName,
            FirestoreUser.email.key: createAccountDetails.email,
            FirestoreUser.uid.key: uid,
        ]
        
        try await FirebaseManager.shared.firestore?
            .collection(FirestoreCollection.users.key)
            .document(uid)
            .setData(userData)
    }
    
    // Method: validate create account details
    func validateCreateAccountDetails() throws {
        if createAccountDetails.firstName.isBlank {
            throw ValidationError.missingFirstName
        } else if createAccountDetails.lastName.isBlank {
            throw ValidationError.missingLastName
        } else if createAccountDetails.email.isBlank {
            throw ValidationError.missingEmail
        } else if createAccountDetails.password.isBlank {
            throw ValidationError.missingPassword
        } else if createAccountDetails.confirmPassword != createAccountDetails.password {
            throw ValidationError.passwordDontMatch
        } else if !createAccountDetails.email.isValidEmail {
            throw ValidationError.invalidEmail
        }
    }

    // Method: validate login details
    func validateLoginDetails() throws {
        if loginDetails.email.isBlank {
            throw ValidationError.missingEmail
        } else if loginDetails.password.isBlank {
            throw ValidationError.missingPassword
        } else if !loginDetails.email.isValidEmail {
            throw ValidationError.invalidEmail
        }
    }
}
