//
//  Progress.swift
//  Happie
//
//  Created by Femke Offringa on 22/05/2020.
//  Copyright © 2020 Femke Offringa. All rights reserved.
//

import Foundation

struct Progress: Codable {
    var deciding: Skill?
    var doing: Skill?
    var dreaming: Skill?
    
    init(deciding: Skill?, doing: Skill?, dreaming: Skill?) {
        self.deciding = deciding
        self.doing = doing
        self.dreaming = dreaming
    }
}
