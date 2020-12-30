//
//  Constants.swift
//  Flash Chat iOS13
//
//  Created by Álvaro Santillan on 12/26/20.
//  Copyright © 2020 Angela Yu. All rights reserved.
//

import Foundation

// Good practice to avoid user errors.
struct Constants {
    static let appName = "Flash Chat"
    static let cellIdentifier = "ReusableCell"
    static let cellNibName = "MessageCell"
    static let registerSegue = "RegisterToChat"
    static let loginSegue = "LogInToChat"
    
    struct BrandColors {
        static let purple = "BrandPurple"
        static let lightPurple = "BrandLightPurple"
        static let blue = "BrandBlue"
        static let lighBlue = "BrandLightBlue"
    }
    
    struct FStore {
        static let collectionName = "messages"
        static let senderField = "sender"
        static let bodyField = "body"
        static let dateField = "date"
    }
}
