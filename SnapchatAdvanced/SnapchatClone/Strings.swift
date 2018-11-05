//
//  Strings.swift
//  SnapchatProject
//
//  Created by Daniel Phiri on 10/13/17. Modified by Yi.
//  Copyright © 2017 org.iosdecal. All rights reserved.
//

import Foundation
import UIKit
struct SnapCloneConstants {
    
    static let dateFormat = "yyyy-MM-dd HH:mm:ss.A"
    static let imageSize = 5 * 1024 * 1024
    static let read = "read"
    static let unread = "unread"
    // category
    static let memes = "Memes"
    static let dog = "Dog Spots"
    static let random = "Random"
    
    // Segues
    static let segueLogInToMainPage = "logInToMainPage"
    static let segueSignUpToMainPage = "signUpToMainPage"
    static let segueLogInToSignUp = "logInToSignUp"
    static let unwindToPicker = "unwindToImagePicker"
    static let chooseThreadCell = "chooseThreadCell"
    static let imagePickerChooseThread = "imagePickerToChooseThread"
    static let pickImageCell = "pickImageCell"
    static let relogin = "reloginSegue"
    // Firebase database strings
    static let firUsersNode = "Users"
    static let firReadPostsNode = "readPosts"
    static let firPostsNode = "Posts"
    static let firUsernameNode = "username"
    static let firThreadNode = "thread"
    static let firDateNode = "date"
    static let firImagePathNode = "imagePath"
    static let firStorageImagesPath = "Images"
    static let postcell = "postCell"
    
    // Alert strings
    static let loginError = "Log In Error"
    static let missingInfo = "Please enter an email and password."
    static let ok = "OK"
    static let signupSuccess = "Sign Up Success"
    static let formEror = "Form Error."
    static let formIncomplete = "Please fill in form completely."
    static let verificationError = "Verification Error."
    static let passwordMismatch = "The two passwords do not match."
    static let signupError = "Sign Up Error"
    static let invalidPostkey = "postkey invalid"
    static let nothingSelected = "No thread selected"
    static let nothingSelectedMessage = "You must select a thread to post your snap to."
    static let dismiss = "Dismiss"
    
    // Numeric constants
    static let numCol = CGFloat(2.0)
    static let minInSec = 60.0
    static let twoHours = 120
    static let minInDay = 24*60
    static let cornerRadius = CGFloat(5)
}
