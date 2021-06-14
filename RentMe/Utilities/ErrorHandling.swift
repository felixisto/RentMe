//
//  ErrorHandling.swift
//  RentMe
//
//  Created by Kristiyan Butev on 12.06.21.
//

import Foundation

class ErrorHandling {
    func isInternetConnection(_ error: Error) -> Bool {
        return error as? URLError != nil
    }
    
    func userFriendlyMessage(forError error: Error) -> String {
        if isInternetConnection(error) {
            return "Connection issue"
        }
        
        return "Unknown error"
    }
}
