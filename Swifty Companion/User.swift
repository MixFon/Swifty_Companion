//
//  User.swift
//  Swifty Companion
//
//  Created by Михаил Фокин on 19.01.2021.
//

import Foundation

class User: Codable {
    var id: Int
    var email: String
    var login: String
    var url: String
    var phone: String
    var displayname: String
    var imageUrl: String?
    var correctionPoint: Int?
    var poolMonth: String?
    var poolYear: String?
    var location: String?
    var wallet: Int
    var cursusUsers: [CursusUsers]
    var campus: [Campus]
}
