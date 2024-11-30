//
//  StaticText.swift
//  ToDoList
//
//  Created by Soubhik Sarkhel on 29/11/24.
//

import Foundation

enum StaticText {
    // common text labels
    static let login = "Log in"
    static let signup = "Sign up"
    static let okay = "Okay"
    static let confirm = "Confirm"
    static let cancel = "Cancel"
    static let loading = "Please wait..."
    static let save = "Save"
    static let edit = "Edit"

    // login & register screen text labels
    static let signin = "Sign In"
    static let createAccount = "Create Account"
    static let email = "Email address"
    static let password = "Password"
    static let confirmPassword = "Confirm Password"
    static let firstName = "First Name"
    static let lastName = "Last Name"
    static let dontHaveAccount = "Don’t have an account ?"
    static let createOne = "Create one"

    // add/edit todo
    static let title = "Title"
    static let description = "Description"
    static let addTask = "Add Task"
    static let newTask = "New Task"
    static let dueDate = "Due Date"
    static let priority = "Priority"
    static let editTask = "Edit Task"
    static let status = "Status"
    static let complete = "Complete"
    static let incomplete = "Incomplete"
    static let taskDetails = "Task Details"
    static let todoList = "To-Do List"

    // error & success text labels
    static let error = "Error"
    static let success = "Success"
    static let defaultError = "Somthing went wrong!\nPlease try again later."
    static let missingFirstName = "First Name is required"
    static let missingLastName = "Last Name is required"
    static let missingEmail = "Email is required"
    static let missingPassword = "Password is required"
    static let passwordDontMatch = "Passwords do not match. Please ensure both fields contain the same password."
    static let invalidEmail = "Email is invalid"
    static let submitSuccessful = "Submitted Successfully"
    static let missingDescription = "Description is required"
    static let provideEmail = "Please provide your Email Address"
}
