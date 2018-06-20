//
//  Pokemon.swift
//  NetworkingPokemon
//
//  Created by Richard on 3/26/18.
//  Copyright © 2018 Sophie Zhou. All rights reserved.
//

import Foundation
import CoreData

@objc(Pokemon)
class Pokemon: NSManagedObject {
    @NSManaged var name: String
    @NSManaged var image: String

    @NSManaged var attack: Int16
    @NSManaged var defense: Int16
    @NSManaged var health: Int16
    @NSManaged var id: Int16
    @NSManaged var speed: Int16

    
    func parse(_ data: [String:String]) {
        if let name = data["name"]{
            self.name = name
        }

    }
}


