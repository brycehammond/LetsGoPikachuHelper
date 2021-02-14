//
//  PokemonCollectionViewCell.swift
//  LetsGoPikachuHelper
//
//  Created by Bryce Hammond on 1/30/21.
//

import UIKit
import AVFoundation

class PokemonCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var nameButton: UIButton!
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var firstTypeView: UIImageView!
    @IBOutlet private weak var secondTypeView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 10.0
        nameButton.addTarget(self, action: #selector(tapNameButton(_:)), for: .touchUpInside)
    }
    
    var pokemon: Pokemon? {
        didSet {
            if let pokemon = pokemon {
                nameButton.setTitle(pokemon.name.capitalized, for: .normal)
                imageView.image = pokemon.image()
                firstTypeView.image = pokemon.types[safeIndex: 0]?.icon()
                secondTypeView.image = pokemon.types[safeIndex: 1]?.icon()
            }
        }
    }
    
    @objc func tapNameButton(_ sender: UIButton) {
        if let pokemon = pokemon {
            PokemonSpeaker.speakName(of: pokemon)
        }
    }
    
}
