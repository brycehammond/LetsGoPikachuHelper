//
//  PokemonListViewModel.swift
//  LetsGoPikachuHelper
//
//  Created by Bryce Hammond on 3/23/21.
//

import Foundation
import UIKit

struct PokemonListViewModel {

    lazy var pokemonByFirstLetter: [String: [Pokemon]] = {
        guard let asset = NSDataAsset(name: "PokemonByLetter") else {
            fatalError("Missing data asset: PokemonByLetter")
        }

        return try! JSONDecoder().decode([String: [Pokemon]].self, from: asset.data)
    }()
}
