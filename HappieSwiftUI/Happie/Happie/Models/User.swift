//
//  User.swift
//  Happie
//
//  Created by Femke Offringa on 22/05/2020.
//  Copyright © 2020 Femke Offringa. All rights reserved.
//

import Foundation

struct User: Codable {
    var dream: String?
    var avatar: Avatar?
    var progress: Progress?

    init(dream: String?, avatar: Avatar?, progress: Progress?) {
        self.dream = dream
        self.avatar = avatar
        self.progress = progress
    }
}
