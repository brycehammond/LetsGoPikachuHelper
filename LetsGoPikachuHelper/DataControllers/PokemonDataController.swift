//
//  PokemonDataController.swift
//  LetsGoPikachuHelper
//
//  Created by Bryce Hammond on 3/25/21.
//

import UIKit

class PokemonDataController {

    private lazy var pokemonByFirstLetter: [String: [Pokemon]] = {
        guard let asset = NSDataAsset(name: "PokemonByLetter") else {
            fatalError("Missing data asset: PokemonByLetter")
        }

        return try! JSONDecoder().decode([String: [Pokemon]].self, from: asset.data)
    }()


    /// Fetches the pokemon and section letters and provide them in the completion
    /// - Parameter completion: A completion block expecting the section letters and the pokemon
    func fetchPokemon(completion: @escaping ([String], [Pokemon]) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            let sectionLetters = self.pokemonByFirstLetter.keys.sorted()
            var pokemon = [Pokemon]()
            for section in sectionLetters {
                if let alphabetizedPokemon = self.pokemonByFirstLetter[section] {
                    pokemon.append(contentsOf: alphabetizedPokemon)
                }
            }
            completion(sectionLetters, pokemon)
        }
    }
}
