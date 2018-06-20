//
//  PokemonCell.swift
//  NetworkingPokemon
//
//  Created by Richard on 3/26/18.
//  Copyright © 2018 Sophie Zhou. All rights reserved.
//

import UIKit

class PokemonCell: UITableViewCell {

    @IBOutlet weak var numLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configure(pokemon: Pokemon) {
        self.nameLabel.text = pokemon.name.capitalizingFirstLetter()
    }
    
}
