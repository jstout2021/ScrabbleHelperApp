//
//  ViewController.swift
//  ScrabbleHelperApp
//
//  Created by Jason Stout on 5/13/21.
//

import UIKit

class MainVC: UIViewController {
    
    @IBOutlet weak var tilesCollectionView: UICollectionView!
    @IBOutlet weak var wordsCollectionView: UICollectionView!
    
    var lettersDataSource = LettersDataSource()
    var wordsDict: [String: Int] = [:]
    var wordsArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tilesCollectionView.dataSource = lettersDataSource
        tilesCollectionView.delegate = lettersDataSource
        wordsCollectionView.dataSource = self
        wordsCollectionView.delegate = self
    }
    
    @IBAction func showWordsTapped(_ sender: Any) {
        wordsDict.removeAll()
        wordsCollectionView.reloadData()
        showWords()
    }
    
    @IBAction func newGameTapped(_ sender: Any) {
        ScrabbleGame.shared.restartGame()
        wordsDict.removeAll()
        wordsCollectionView.reloadData()
        lettersDataSource.reloadLetters()
        tilesCollectionView.reloadData()
    }
    
    func showWords() {
        ScrabbleGame.shared.cheat()
        wordsDict = ScrabbleGame.shared.wordsCombo
        
        for word in wordsDict.keys {
            wordsArray.append(word)
        }
        wordsArray.sort { (word1, word2) -> Bool in
            let points1 = wordsDict[word1]!
            let points2 = wordsDict[word2]!
            return points1 > points2
        }
        wordsCollectionView.reloadData()
    }
}

extension MainVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return wordsDict.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let word = wordsArray[indexPath.row]
        let points = wordsDict[word]!
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WordCell", for: indexPath) as? WordCell {
            cell.setupCell(word: word, points: points)
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: 145, height: 77)
        }
}

