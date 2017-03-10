//
//  CategoryViewController.swift
//  PokedexLab
//
//  Created by SAMEER SURESH on 2/25/17.
//  Copyright © 2017 iOS Decal. All rights reserved.
//

import UIKit

class CategoryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var pokemonArray: [Pokemon]?
    var cachedImages: [Int:UIImage] = [:]
    var selectedIndexPath: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewOutlet.delegate = self
        tableViewOutlet.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemonArray!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableViewOutlet.dequeueReusableCell(withIdentifier: "prototype", for: indexPath) as! tableviewcell
        if let image = cachedImages[indexPath.row] {
            cell.pokemonImage.image = image // may need to change this!
        } else {
            let url = URL(string: pokemonArray![indexPath.row].imageUrl)!
            let session = URLSession(configuration: .default)
            let downloadPicTask = session.dataTask(with: url) { (data, response, error) in
                if let e = error {
                    print("Error downloading picture: \(e)")
                } else {
                    if let _ = response as? HTTPURLResponse {
                        if let imageData = data {
                            let image = UIImage(data: imageData)
                            self.cachedImages[indexPath.row] = image
                            cell.pokemonImage.image = UIImage(data: imageData) // may need to change this!
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
        if let attack = pokemonArray![indexPath.row].attack {
            if let defense = pokemonArray![indexPath.row].defense {
                if let health = pokemonArray![indexPath.row].health {
                    cell.importantStats.text = String(describing: attack) + "/" + String(describing: defense) + "/" + String(describing: health)
                }
            }
        }
        cell.pokemonName.text = pokemonArray![indexPath.row].name
        cell.pokemonNumber.text = String(pokemonArray![indexPath.row].number)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndexPath = indexPath
        performSegue(withIdentifier: "categoryToPokemonInfoSegue", sender: Any?.self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            if identifier == "categoryToPokemonInfoSegue" {
                if let dest = segue.destination as? PokemonInfoViewController {
                    dest.pokemon = pokemonArray![(selectedIndexPath?.row)!]
                    if let image = cachedImages[(selectedIndexPath?.row)!] {
                        dest.image = image
                    }
                }
            }
        }
    }

    @IBOutlet weak var tableViewOutlet: UITableView!

}
