//
//  WordCell.swift
//  ScrabbleHelperApp
//
//  Created by Jason Stout on 5/14/21.
//

import UIKit

class WordCell: UICollectionViewCell {
    
    @IBOutlet weak var wordLbl: UILabel!
    @IBOutlet weak var pointLbl: UILabel!
    
    func setupCell(word: String, points: Int) {
        wordLbl.text = word
        pointLbl.text = "\(points)pts"
    }
}
