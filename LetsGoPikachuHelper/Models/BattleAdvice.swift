//
//  BattleAdvise.swift
//  LetsGoPikachuHelper
//
//  Created by Bryce Hammond on 2/12/21.
//

import Foundation

struct BattleAdvice {
    let goodTypes: [PokemonType]
    let badTypes: [PokemonType]

    init(goodTypes: [PokemonType], badTypes: [PokemonType]) {
        self.goodTypes = goodTypes
        self.badTypes = badTypes
    }
}
