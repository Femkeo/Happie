//
//  UserInfoService.swift
//  Happie
//
//  Created by Femke Offringa on 26/05/2020.
//  Copyright © 2020 Femke Offringa. All rights reserved.
//

import Foundation
import SwiftUI

enum Direction {
    case forwards
    case backwards
}

class UserInfoService {
    let userDefaults = UserInfoService()
    let hairStyles: [Hair] = Hair.AllCases()
    
    func selectHair(from hairStyle: String, to: Direction?) -> String? {
        guard let hair = hairStyles.first(where: { $0.imageName == hairStyle } ),
            let index = hairStyles.lastIndex(of: hair) else { return nil }
        switch to {
        case .forwards:
            return hairStyles[index + 1].imageName
        case .backwards:
            return hairStyles[index - 1].imageName
        case .none:
            return hairStyles[index].imageName
        }
    }
}
