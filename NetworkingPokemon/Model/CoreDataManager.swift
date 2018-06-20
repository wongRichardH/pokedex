//
//  CoreDataManager.swift
//  NetworkingPokemon
//
//  Created by Sophie on 3/20/18.
//  Copyright © 2018 Sophie Zhou. All rights reserved.
//

import UIKit
import CoreData

class CoreDataManager: NSObject {

    var context: NSManagedObjectContext!
    static let shared: CoreDataManager = CoreDataManager()

    class func setUpCoreDataStack() {
        let container = NSPersistentContainer(name: "Pokemon")
        container.loadPersistentStores { (store, error) in
            guard error == nil else { NSLog("Failed to load core data stack!"); return }
            shared.context = container.viewContext
            NSLog("Loaded store!")
        }
    }

}
