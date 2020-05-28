//
//  User.swift
//  Happie
//
//  Created by Femke Offringa on 22/05/2020.
//  Copyright © 2020 Femke Offringa. All rights reserved.
//

import Foundation

struct User: Codable {
    var avatar: Avatar?
    var progress: Progress?

    init(avatar: Avatar?, progress: Progress?) {
        self.avatar = avatar
        self.progress = progress
    }
}
