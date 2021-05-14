//
//  LettersDataSource.swift
//  ScrabbleHelperApp
//
//  Created by Jason Stout on 5/14/21.
//

import UIKit

class LettersDataSource : NSObject, UICollectionViewDelegate, UICollectionViewDataSource {
    var letters = ScrabbleGame.shared.startingLetters
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return letters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let letter = letters[indexPath.row]
        let points = ScrabbleGame.shared.letterPoints[letter] ?? 0
        let tile = Tile(letter: letter, value: points)
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TileCell", for: indexPath) as? TileCell {
            cell.setupCell(tile: tile)
            return cell
        }
        return UICollectionViewCell()
    }
    
    func reloadLetters() {
        letters.removeAll()
        letters = ScrabbleGame.shared.startingLetters
    }
}
