//
//  PokemonTypeTableViewCell.swift
//  LetsGoPikachuHelper
//
//  Created by Bryce Hammond on 2/14/21.
//

import UIKit

class PokemonTypeTableViewCell: UITableViewCell {

    @IBOutlet private weak var typeImageView: UIImageView?

    var pokemonType: PokemonType? {
        didSet {
            typeImageView?.image = pokemonType?.slug()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
