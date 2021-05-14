//
//  TileCell.swift
//  ScrabbleHelperApp
//
//  Created by Jason Stout on 5/13/21.
//

import UIKit

class TileCell: UICollectionViewCell {
    
    @IBOutlet weak var letter: UILabel!
    @IBOutlet weak var value: UILabel!
    
    func setupCell(tile: Tile) {
        letter.text = tile.letter
        value.text = "\(tile.value)"
    }
}
