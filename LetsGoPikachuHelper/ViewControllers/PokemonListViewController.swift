//
//  PokemonListViewController.swift
//  LetsGoPikachuHelper
//
//  Created by Bryce Hammond on 1/16/21.
//

import UIKit

class PokemonListViewController: UIViewController {

    @IBOutlet private weak var collectionView: UICollectionView?
    
    lazy var pokemonByFirstLetter: [String: [Pokemon]] = {
        guard let asset = NSDataAsset(name: "PokemonByLetter") else {
            fatalError("Missing data asset: PokemonByLetter")
        }
        
        return try! JSONDecoder().decode([String: [Pokemon]].self, from: asset.data)
    }()
    
    var sectionLetters = [String]()
    var pokemon = [Pokemon]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sectionLetters = pokemonByFirstLetter.keys.sorted()
        for section in sectionLetters {
            if let alphabetizedPokemon = pokemonByFirstLetter[section] {
                pokemon.append(contentsOf: alphabetizedPokemon)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? PokemonDetailViewController,
           let indexPath = collectionView?.indexPathsForSelectedItems?.first,
           let pokemon = pokemon[safeIndex: indexPath.row] {
            controller.pokemon = pokemon
        }
    }
}

extension PokemonListViewController: UICollectionViewDelegate {
    
}

extension PokemonListViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pokemon.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let pokemonCell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: PokemonCollectionViewCell.self), for: indexPath) as? PokemonCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        pokemonCell.pokemon = pokemon[indexPath.row]
        
        return pokemonCell
    }
    
    func indexTitles(for collectionView: UICollectionView) -> [String]? {
        return sectionLetters.map { $0.uppercased()}
    }
    
    func collectionView(_ collectionView: UICollectionView, indexPathForIndexTitle title: String, at index: Int) -> IndexPath {
        //Go to the first pokemon starting with the letter
        guard let index = pokemon.firstIndex(where: {$0.name.starts(with: title.lowercased())}) else {
            return IndexPath(row: 0, section: 0)
        }
        
        return IndexPath(row: index, section: 0)
    }
}
