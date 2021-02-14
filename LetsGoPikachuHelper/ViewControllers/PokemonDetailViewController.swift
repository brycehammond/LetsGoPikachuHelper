//
//  PokemonDetailViewController.swift
//  LetsGoPikachuHelper
//
//  Created by Bryce Hammond on 1/31/21.
//

import UIKit

class PokemonDetailViewController: UIViewController {

    @IBOutlet private weak var detailImageView: UIImageView!
    @IBOutlet private weak var goodTypesTableView: UITableView!
    @IBOutlet private weak var badTypesTableView: UITableView!

    var pokemon: Pokemon?
    private var battleAdvice = BattleAdvice(goodTypes: [], badTypes: [])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateDetail()
        detailImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(imageTapped(_:))))
    }

    private func updateDetail() {
        detailImageView.image = pokemon?.image()
        self.title = pokemon?.name.uppercased()

        if let pokemon = pokemon {
            battleAdvice = PokemonBattleAdvisor.shared.getBattleAdviceFor(opponent: pokemon)
            goodTypesTableView.reloadData()
            badTypesTableView.reloadData()
        }
    }
    
    @objc func imageTapped(_ sender: UITapGestureRecognizer) {
        if let pokemon = pokemon {
            PokemonSpeaker.speakName(of: pokemon)
        }
    }
}

extension PokemonDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        switch tableView {
        case goodTypesTableView:
            return battleAdvice.goodTypes.count
        case badTypesTableView:
            return battleAdvice.badTypes.count
        default:
            return 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TypeCell") as? PokemonTypeTableViewCell else {
            return UITableViewCell()
        }

        switch tableView {
        case goodTypesTableView:
            cell.pokemonType = battleAdvice.goodTypes[indexPath.row]
        case badTypesTableView:
            cell.pokemonType = battleAdvice.badTypes[indexPath.row]
        default:
            break
        }

        return cell
    }
}
