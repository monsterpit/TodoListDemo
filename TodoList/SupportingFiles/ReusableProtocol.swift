//
//  ReusableProtocol.swift
//  TodoList
//
//  Created by Vikas S on 17/09/21.
//

import Foundation

protocol ReusableProtocol {
    static var reusableIdentifier: String {
        get
    }
}

extension ReusableProtocol {
    static var reusableIdentifier: String {
        get {
            return "\(self)"
        }
    }
}
