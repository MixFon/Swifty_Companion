//
//  Token.swift
//  Swifty Companion
//
//  Created by Михаил Фокин on 13.01.2021.
//

import UIKit

class Token: NSObject, Codable {
    var accessToken: String
    var createdAt: Int
    var expiresIn: Int
    var refreshToken: String
    var scope: String
    var tokenType: String
    
    override var description: String { return
    """
    accessToken = \(accessToken)
    createdAt = \(createdAt)
    expiresIn = \(expiresIn)
    refreshToken = \(refreshToken)
    scope = \(scope)
    tokenType = \(tokenType)
    """
    }
}
