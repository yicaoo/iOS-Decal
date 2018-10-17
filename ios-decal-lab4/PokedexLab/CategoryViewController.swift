//
//  CategoryViewController.swift
//  PokedexLab
//
//  Created by SAMEER SURESH on 2/25/17. 
//  Copyright © 2017 iOS Decal. All rights reserved.
//

import UIKit

class CategoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {

    var pokemonArray: [Pokemon]?
    var cachedImages: [Int:UIImage] = [:]
    var selectedIndexPath: IndexPath?
    @IBOutlet weak var pokeTableView: UITableView! {
        didSet {
            pokeTableView.dataSource = self
            pokeTableView.delegate = self
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemonArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return TableViewConstant.height
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: StoryboardConstant.newPokeTableCell, for: indexPath)
        if let pokeCell = cell as? PokeTableViewCell {
            if let pokeItem = pokemonArray?[indexPath.row] {
                // load name
                let nameString = pokeItem.name + " \n" + String(pokeItem.number)
                pokeCell.Name.text = nameString
                // load key stats
                let statsString = String(pokeItem.attack) + "/" + String(pokeItem.defense) + "/" + String(pokeItem.health)
                pokeCell.keyStats.text = statsString
                // load image
                if let image = cachedImages[indexPath.row] {
                    pokeCell.pokemonImageView.image = image
                } else {
                    pokeCell.pokemonImageView.image = nil
                    let url = URL(string: pokeItem.imageUrl)!
                    let session = URLSession(configuration: .default)
                    let downloadPicTask = session.dataTask(with: url) { (data, response, error) in
                        if let e = error {
                            print("Error downloading picture: \(e)")
                        } else {
                            if let _ = response as? HTTPURLResponse {
                                if let imageData = data {
                                    let image = UIImage(data: imageData)
                                    DispatchQueue.main.async {
                                        self.cachedImages[indexPath.row] = image
                                        pokeCell.pokemonImageView.image = image // UIImage(data: imageData)
                                    }
                                } else {
                                    print("Couldn't get image: Image is nil")
                                }
                            } else {
                                print("Couldn't get response code")
                            }
                        }
                    }
                    downloadPicTask.resume()
                }
            }
        }
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       if let cell = sender as? PokeTableViewCell, let destination = segue.destination as? PokemonInfoViewController {
                let indexPath = pokeTableView.indexPath(for: cell)
                destination.pokemon = pokemonArray?[indexPath?.row ?? 0]
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private struct StoryboardConstant {
        static let newPokeTableCell = "newPokeTableCell"
        static let showInfo = "showInfo"
    }
    
    private struct TableViewConstant {
        static let height = CGFloat(100)
    }

}
