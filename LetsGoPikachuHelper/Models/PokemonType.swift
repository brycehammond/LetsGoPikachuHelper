//
//  PokemonType.swift
//  LetsGoPikachuHelper
//
//  Created by Bryce Hammond on 1/30/21.
//

import Foundation
import UIKit

enum PokemonType: String, Codable {
    case normal
    case fighting
    case flying
    case poison
    case ground
    case rock
    case bug
    case ghost
    case steel
    case fire
    case water
    case grass
    case electric
    case psychic
    case ice
    case dragon
    case dark
    case fairy
    case unknown
    case shadow
}

extension PokemonType {
    
    func icon() -> UIImage {
        return UIImage(named: "\(self.rawValue)-icon")!
    }
    
    func slug() -> UIImage {
        return UIImage(named: "\(self.rawValue)-slug")!
    }
}
