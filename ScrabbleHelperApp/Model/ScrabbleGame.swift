//
//  ScrabbleGame.swift
//  ScrabbleHelperApp
//
//  Created by Jason Stout on 5/14/21.
//

import Foundation

struct ScrabbleGame {
    static var shared = ScrabbleGame()
    
    private (set) public var trie = Trie()
    private (set) public var letterPoints = [String : Int]()
    private (set) public var lettersInBagStarting = [String : Int]()
    private (set) public var lettersInBag = [String : Int]()
    private (set) public var bagArray = [String]()
    private (set) public var startingLetters = [String]()
    private (set) public var wordsCombo = [String : Int]()
    
    init() {
        setupPoints()
        setupQuantities()
        lettersInBag = lettersInBagStarting
        makeArray()
        startGame()
        setupTrie()
    }
    
    func setupTrie() {
        var tempArray = [String]()
        let resourcePath = Bundle.main.resourcePath! as NSString
        let fileName = "dictionary.txt"
        let filePath = resourcePath.appendingPathComponent(fileName)
        
        var data: String?
        do {
            data = try String(contentsOfFile: filePath, encoding: .utf8)
        } catch let error {
            print(error.localizedDescription)
        }
        tempArray = data!.components(separatedBy: .whitespacesAndNewlines)
        for word in tempArray {
            trie.insert(word: word)
        }
    }
    
    private mutating func setupPoints() {
        letterPoints["A"] = 1
        letterPoints["E"] = 1
        letterPoints["I"] = 1
        letterPoints["O"] = 1
        letterPoints["N"] = 1
        letterPoints["R"] = 1
        letterPoints["T"] = 1
        letterPoints["L"] = 1
        letterPoints["S"] = 1
        letterPoints["U"] = 1
        
        letterPoints["D"] = 2
        letterPoints["G"] = 2
        
        letterPoints["B"] = 3
        letterPoints["C"] = 3
        letterPoints["M"] = 3
        letterPoints["P"] = 3
        
        letterPoints["F"] = 4
        letterPoints["H"] = 4
        letterPoints["V"] = 4
        letterPoints["W"] = 4
        letterPoints["Y"] = 4
        
        letterPoints["K"] = 5
        
        letterPoints["J"] = 8
        letterPoints["X"] = 8
        
        letterPoints["Q"] = 10
        letterPoints["Z"] = 10
    }
    
    private mutating func setupQuantities() {
        lettersInBagStarting["A"] = 9
        lettersInBagStarting["B"] = 2
        lettersInBagStarting["C"] = 2
        lettersInBagStarting["D"] = 4
        lettersInBagStarting["E"] = 12
        lettersInBagStarting["F"] = 2
        lettersInBagStarting["G"] = 3
        lettersInBagStarting["H"] = 2
        lettersInBagStarting["I"] = 9
        lettersInBagStarting["J"] = 1
        lettersInBagStarting["K"] = 1
        lettersInBagStarting["L"] = 4
        lettersInBagStarting["M"] = 2
        lettersInBagStarting["N"] = 6
        lettersInBagStarting["O"] = 8
        lettersInBagStarting["P"] = 2
        lettersInBagStarting["Q"] = 1
        lettersInBagStarting["R"] = 6
        lettersInBagStarting["S"] = 4
        lettersInBagStarting["T"] = 6
        lettersInBagStarting["U"] = 4
        lettersInBagStarting["V"] = 2
        lettersInBagStarting["W"] = 2
        lettersInBagStarting["X"] = 1
        lettersInBagStarting["Y"] = 2
        lettersInBagStarting["Z"] = 1
    }
    
    mutating func makeArray() {
        for (key, value) in lettersInBag {
            for _ in 1...value {
                bagArray.append(key)
            }
        }
    }
    
    mutating func startGame() {
        for _ in 1...7 {
            let randomInt = Int.random(in: 0..<bagArray.count)
            let randomLeter = bagArray.remove(at: randomInt)
            startingLetters.append(randomLeter)
        }
    }
    
    mutating func restartGame() {
        startingLetters.removeAll()
        wordsCombo.removeAll()
        lettersInBag = lettersInBagStarting
        makeArray()
        startGame()
    }
    
    mutating func cheat() {
        let results = makeCombos()
        for result in results {
            let points = getWordPointFor(result)
            wordsCombo[result] = points
        }
    }
    
    private func makeCombos() -> [String] {
        var letters = Array<Character>()
        for letter in startingLetters {
            letters.append(letter.lowercased().first!)
        }
        
        var results = Set<String>()
        trie.findWordsFromLettersArray(&letters, start: 0, end: letters.count-1, results: &results)
        return Array<String>(results)
    }
    
    func getWordPointFor(_ word: String) -> Int {
        var points = 0
        for letter in word {
            let letter = String(letter).uppercased()
            points += letterPoints[letter]!
        }
        return points
    }
}
