//
//  ErrorMessage.swift
//  GitHubFollower_Programmatic
//
//  Created by YILDIRIM on 27.01.2023.
//

import Foundation
enum GFError: String, Error {
    case invalidUsername    = "This username created an invalid request. Please try again"
    case unableToComplete   = "Unable to complete your request. Please check your internet connection."
    case invalidResponse    = "Invalid response from the server. Please try again."
    case invalidData        = "The recieved from the server was invalid. Please try again."
    
    
    
}
