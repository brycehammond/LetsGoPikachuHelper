//
//  PokemonDetailViewController.swift
//  LetsGoPikachuHelper
//
//  Created by Bryce Hammond on 1/31/21.
//

import UIKit

class PokemonDetailViewController: UIViewController {

    @IBOutlet weak var detailImageView: UIImageView!
    
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
        }
    }
    
    @objc func imageTapped(_ sender: UITapGestureRecognizer) {
        if let pokemon = pokemon {
            PokemonSpeaker.speakName(of: pokemon)
        }
    }
}
