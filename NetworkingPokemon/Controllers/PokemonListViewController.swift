//
//  PokemonListViewController.swift
//  BaseTab
//
//  Created by Sophie Zhou on 11/22/17.
//  Copyright © 2017 Sophie Zhou. All rights reserved.
//

import UIKit
import CoreData


class PokemonListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    var pokeList:[Pokemon] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(self.tableView)
        
        self.setupTableView()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        self.fetchRequest()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.tableView.frame = self.view.bounds

    }

    func setupTableView() {
        let nib = UINib(nibName: "PokemonCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "PokeIdentifier")

        self.tableView.separatorStyle = .none
    }
    
    
    //MARK: TableView DataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.pokeList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "PokeIdentifier") as! PokemonCell
        
        let eachPokemon = self.pokeList[indexPath.row]
        cell.numLabel.text = String(indexPath.row + 1)
        
        cell.configure(pokemon: eachPokemon)
        
        return cell
    }
    
    //MARK: TableView DataSource
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let pokemonID = indexPath.row + 1
        let vc = DetailViewController(pokemonId: pokemonID)
        self.navigationController?.pushViewController(vc, animated: true)

    }
    
    //GET request for pokemon
    func fetchRequest() {
        let session = URLSession.shared
        let url = URL(string: "https://pokeapi.co/api/v2/pokemon/")!
        let request = URLRequest(url: url)
        
        let task = session.dataTask(with: request) { (data, response, error) in
            let jsonData = try! JSONSerialization.jsonObject(with: data!,
                                                             options: JSONSerialization.ReadingOptions.allowFragments) as! [String: Any]
            
            let resultsArray = jsonData["results"] as! [[String:String]]
            
            for eachPokemon in resultsArray {
                let pokemon = NSEntityDescription.insertNewObject(forEntityName: "Pokemon", into: CoreDataManager.shared.context) as! Pokemon
                
                pokemon.parse(eachPokemon)
                self.pokeList.append(pokemon)

            }
            DispatchQueue.main.sync {
                self.tableView.reloadData()
            }
        }
        task.resume()
    }
    
}











