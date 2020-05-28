//
//  Avatar.swift
//  Happie
//
//  Created by Femke Offringa on 22/05/2020.
//  Copyright © 2020 Femke Offringa. All rights reserved.
//

import Foundation

struct Avatar: Codable {
    var skinColor: SkinColor = .blue
    var hair: Hair = .parsing
    var cloths: Cloths = .tankTop
    
    init(skinColor: SkinColor, hair: Hair, cloths: Cloths) {
        self.skinColor = skinColor
        self.hair = hair
        self.cloths = cloths
    }
}

enum SkinColor: CaseIterable {
    case blue
    case dark
    case medium
    case light
    case white
    
    var imageName: String {
        switch self {
        case .blue:
            return "skin1"
        case .dark:
            return "skin2"
        case .medium:
            return "skin3"
        case .light:
            return "skin4"
        case .white:
            return "skin5"
        }
    }
}

extension SkinColor: Codable {
    func encode(to encoder: Encoder) throws {}
    
    public init(from decoder: Decoder) throws {
        self = try type(of: self).init(from: decoder)
    }
}

enum Hair: CaseIterable {
    case parsing
    case spikey
    case mohawk
    case short
    case bun
    case braid
    case halfLong
    case long
    case alienEars
    
    var imageName: String {
        switch self {
        case .parsing:
            return "hair1"
        case .spikey:
            return "hair2"
        case .mohawk:
            return "hair3"
        case .short:
            return "hair4"
        case .bun:
            return "hair5"
        case .braid:
            return "hair6"
        case .halfLong:
            return "hair7"
        case .long:
            return "hair8"
        case .alienEars:
            return "hair9"

        }
    }
}

extension Hair: Codable {
    func encode(to encoder: Encoder) throws {}
    
    public init(from decoder: Decoder) throws {
        self = try type(of: self).init(from: decoder)
    }
}

enum Cloths: CaseIterable {
    case tankTop
    case tshirt
    case superShirt
    case blouse
    
    var imageName: String {
        switch self {
        case .tankTop:
            return "clothes1"
        case .tshirt:
            return "clothes2"
        case .superShirt:
            return "clothes3"
        case .blouse:
            return "clothes4"
        }
    }
}

extension Cloths: Codable {
    func encode(to encoder: Encoder) throws {}
    
    public init(from decoder: Decoder) throws {
        self = try type(of: self).init(from: decoder)
    }
}
