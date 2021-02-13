//
//  Pokemon.swift
//  LetsGoPikachuHelper
//
//  Created by Bryce Hammond on 1/30/21.
//

import Foundation
import UIKit

struct Pokemon: Codable {
    var id: Int
    var name: String
    var types: [PokemonType]
    
    func image() -> UIImage {
        return UIImage(named: "\(id)-detail")!
    }
}
