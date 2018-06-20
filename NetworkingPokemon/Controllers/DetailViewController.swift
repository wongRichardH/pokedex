//
//  DetailViewController.swift
//  BaseTab
//
//  Created by Sophie Zhou on 11/22/17.
//  Copyright © 2017 Sophie Zhou. All rights reserved.

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var numLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var speedLabel: UILabel!
    @IBOutlet weak var defenseLabel: UILabel!
    @IBOutlet weak var attackLabel: UILabel!
    @IBOutlet weak var hpLabel: UILabel!
    @IBOutlet weak var pokeImage: UIImageView!
    @IBOutlet weak var speedTitleLabel: UILabel!
    @IBOutlet weak var defenseTitleLabel: UILabel!
    @IBOutlet weak var attackTitleLabel: UILabel!
    @IBOutlet weak var hpTitleLabel: UILabel!

    var pokemonID: Int?

    init(pokemonId: Int) {
        super.init(nibName: nil, bundle: nil)
        self.pokemonID = pokemonId
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        self.numLabel.text = ""
        self.nameLabel.text = ""
        self.speedLabel.text = ""
        self.defenseLabel.text = ""
        self.attackLabel.text = ""
        self.hpLabel.text = ""
        self.setupStats(pokemonId: self.pokemonID!)
        self.setupFont()
    }

    private func setupFont() {
        let grayColor = UIColor(red:0.61, green:0.61, blue:0.61, alpha:1)

        self.numLabel.textColor = grayColor
        self.speedTitleLabel.textColor = grayColor
        self.defenseTitleLabel.textColor = grayColor
        self.attackTitleLabel.textColor = grayColor
        self.hpTitleLabel.textColor = grayColor
    }

    private func setUpName(pokemonId: Int) -> String {
        var result = String(pokemonId)
        if pokemonId < 10 {
            result = "0" + result
        }
        result += "."
        return result
    }

    private func setupStats(pokemonId: Int) {
        let session = URLSession.shared
        let url = URL(string: "https://pokeapi.co/api/v2/pokemon/\(pokemonId)")!
        let request = URLRequest(url: url)

        let task = session.dataTask(with: request) { (data, response, error) in
            if let nameData = data {
                if let jsonData = try! JSONSerialization.jsonObject(with: nameData,
                                                                    options: JSONSerialization.ReadingOptions.init(rawValue: 0)) as? [String: Any] {

                    DispatchQueue.main.async {
                        self.numLabel.text = self.setUpName(pokemonId: pokemonId)
                    }

                    if let formsArray = jsonData["forms"] as? [[String:String]] {
                        let formsDict = formsArray[0]
                        if let pokemonName = formsDict["name"]{
                            DispatchQueue.main.async {
                                self.nameLabel.text = pokemonName.capitalizingFirstLetter()
                            }
                        }
                    }
                    if let statsArray = jsonData["stats"] as? [[String:Any]] {
                        let speedDict = statsArray[0]
                        if let pokemonSpeed = speedDict["base_stat"] as? Int16 {
                            DispatchQueue.main.async {
                                self.speedLabel.text = String(pokemonSpeed)
                            }
                        }
                    }
                    if let statsArray = jsonData["stats"] as? [[String:Any]] {
                        let speedDict = statsArray[3]
                        if let pokemonSpeed = speedDict["base_stat"] as? Int16 {
                            DispatchQueue.main.async {
                                self.defenseLabel.text = String(pokemonSpeed)
                            }
                        }
                    }
                    if let statsArray = jsonData["stats"] as? [[String:Any]] {
                        let speedDict = statsArray[4]
                        if let pokemonSpeed = speedDict["base_stat"] as? Int16 {
                            DispatchQueue.main.async {
                                self.attackLabel.text = String(pokemonSpeed)
                            }
                        }
                    }
                    if let statsArray = jsonData["stats"] as? [[String:Any]] {
                        let speedDict = statsArray[5]
                        if let pokemonSpeed = speedDict["base_stat"] as? Int16 {
                            DispatchQueue.main.async {
                                self.hpLabel.text = String(pokemonSpeed)
                            }
                        }
                    }
                    if let spritesArray = jsonData["sprites"] as? [String:Any] {
                        if let imageUrl = spritesArray["front_default"] as? String {
                            let url = URL(string: imageUrl)
                            let imageTask = session.dataTask(with: url!, completionHandler: { (data, response, error) in

                                if let imageData = data {
                                    let image = UIImage(data: imageData)
                                    DispatchQueue.main.async {
                                        self.pokeImage.image = image
                                    }
                                }
                            })
                            imageTask.resume()
                        }
                    }
                }
            }
        }
        task.resume()
    }
}
