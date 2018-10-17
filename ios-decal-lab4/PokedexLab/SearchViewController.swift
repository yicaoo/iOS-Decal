//
//  SearchViewController.swift
//  PokedexLab
//
//  Created by SAMEER SURESH on 2/25/17. Completed by Yi cao on 10/17/18.
//  Copyright © 2017 iOS Decal. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    var pokemonArray: [Pokemon] = []
    var filteredArray: [Pokemon] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pokemonArray = PokemonGenerator.getPokemonArray()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    // Utility function to iterate through pokemon array for a single category
    func filteredPokemon(ofType type: Int) -> [Pokemon] {
        var filtered: [Pokemon] = []
        for pokemon in pokemonArray {
            if (pokemon.types.contains(PokemonGenerator.categoryDict[type]!)) {
                filtered.append(pokemon)
            }
        }
        return filtered
    }
    
    @IBOutlet weak var pokedexCollectionView: UICollectionView! {
        didSet {
            pokedexCollectionView.dataSource = self
            pokedexCollectionView.delegate = self
        }
    }
    
    private var flowLayout: UICollectionViewFlowLayout? {
        return pokedexCollectionView?.collectionViewLayout as? UICollectionViewFlowLayout
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
       
        let paddingSpace = LayoutConstant.sectionInsets.left * (LayoutConstant.itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / LayoutConstant.itemsPerRow
        
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return LayoutConstant.sectionInsets
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return LayoutConstant.sectionInsets.left
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return PokemonGenerator.categoryDict.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StoryboardConstant.newPokeCell, for: indexPath)
        if let pokeCell = cell as? PokeCollectionViewCell {
            if let imageName = PokemonGenerator.categoryDict[indexPath.item] {
                pokeCell.pokeView.image = UIImage(named: imageName)
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
         performSegue(withIdentifier: StoryboardConstant.searchCategory, sender: indexPath.item)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let pokeID = sender as? Int, let destination = segue.destination as? CategoryViewController {
            destination.pokemonArray = filteredPokemon(ofType: pokeID)
        }
    }
    
    
    private struct LayoutConstant {
        static let itemsPerRow: CGFloat = 3
        static let sectionInsets = UIEdgeInsets(top: 50.0, left: 20.0, bottom: 50.0, right: 20.0)
    }
    
    private struct StoryboardConstant {
        static let newPokeCell = "newPokeCollectionCell"
        static let searchCategory = "searchCategory"
    }
}
