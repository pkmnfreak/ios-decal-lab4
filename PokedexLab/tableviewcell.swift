//
//  tableviewcell.swift
//  PokedexLab
//
//  Created by Evan Chang on 3/9/17.
//  Copyright © 2017 iOS Decal. All rights reserved.
//

import Foundation
import UIKit
class tableviewcell: UITableViewCell {
    
    @IBOutlet weak var importantStats: UILabel!
    
    @IBOutlet weak var pokemonImage: UIImageView!
    
    @IBOutlet weak var pokemonName: UILabel!
    
    @IBOutlet weak var pokemonNumber: UILabel!
}
