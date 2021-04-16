//
//  Project.swift
//  Swifty Companion
//
//  Created by Михаил Фокин on 19.01.2021.
//

import Foundation

//struct ProjectUser: Codable {
//    var id: Int
//    var finalMark: Int?
//    var status: String
//    var markedAt: String?
//    var marked: Bool
//    var validated: Bool?
//    var project: Project
//
//}
//
//class Project: NSObject, Codable {
//    var id: Int
//    var name: String
//    var slug: String
//    var parentId: Int?
//}

//
//required init(from decoder: Decoder) throws {
//    let contaner = try decoder.container(keyedBy: RatingsCodingKeys.self)
//    self.validated = try contaner.decode(Bool.self, forKey: .validated)
//}


// MARK: - ProjectUser
struct ProjectUser: Codable {
    let id, occurrence:Int
    let finalMark: Int?
    let status: String
    let validated: Bool?
    let project: Project
    let markedAt: String?
    let marked: Bool
    let retriableAt: String?

    enum CodingKeys: String, CodingKey {
        case id, occurrence
        case finalMark = "final_mark"
        case status
        case validated = "validated?"
        case project
        case markedAt = "marked_at"
        case marked
        case retriableAt = "retriable_at"
    }
}

// MARK: - Project
struct Project: Codable {
    let id: Int
    let name, slug: String
}
