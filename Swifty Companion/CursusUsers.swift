//
//  CursusUsers.swift
//  Swifty Companion
//
//  Created by Михаил Фокин on 19.01.2021.
//

import Foundation

class CursusUsers: NSObject, Codable {
    var grade: String?
    var level: Double
    var cursus: Cursus
    var skills: [Skills]
    
    override var description: String { return
        """
        grade = \(String(describing: grade))
        level = \(level)
        skills = \(skills)
        """
    }
}

class Skills: NSObject, Codable {
    var id: Int
    var name: String
    var level: Float
    
    override var description: String { return
        """
        id = \(id)
        name = \(name)
        level = \(level)
        """
    }
}

class Cursus: NSObject, Codable {
    var id: Int
    var name: String
}
