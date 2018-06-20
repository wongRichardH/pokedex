//
//  StringExtension.swift
//  NetworkingPokemon
//
//  Created by Richard on 6/20/18.
//  Copyright © 2018 Sophie Zhou. All rights reserved.
//

import Foundation

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).uppercased() + dropFirst()
    }
}
