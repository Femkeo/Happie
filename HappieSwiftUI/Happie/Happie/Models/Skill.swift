//
//  Skill.swift
//  Happie
//
//  Created by Femke Offringa on 22/05/2020.
//  Copyright © 2020 Femke Offringa. All rights reserved.
//

import Foundation

struct Skill: Codable {
    var xp: Int?
    var description: String?

    init(xp: Int? = 0, description: String?) {
        self.xp = xp
        self.description = description
    }
}
