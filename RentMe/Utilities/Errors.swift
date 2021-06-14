//
//  Errors.swift
//  RentMe
//
//  Created by Kristiyan Butev on 11.06.21.
//

import Foundation

enum GenericError: Error {
    case unknown(String)
}

enum ParserError: Error {
    case generic(String)
}
