//
//  GameViewController.swift
//  Hangman
//
//  Created by Shawn D'Souza on 3/3/16.
//  Copyright © 2016 Shawn D'Souza. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {

    @IBOutlet weak var incorrectGuessList: UILabel!
    @IBOutlet weak var incorrectButton: UIButton!
    @IBOutlet weak var correctButton: UIButton!
    @IBOutlet weak var letterToGuess: UITextField!
    @IBOutlet weak var wordToGuess: UILabel!
    @IBOutlet weak var hangman: UIImageView!
    var phrase : String?
    var phraseArray : [Character]?
    var phraseLength : Int?
    var arrayOfBools : [Bool]?
    var setOfWordCharacters = Set<String>()
    var wrongGuesses = Set<String>()
    var death = 1
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let hangmanPhrases = HangmanPhrases()
        phrase = hangmanPhrases.getRandomPhrase()
        phraseArray = [Character](phrase!.characters)
        phraseLength = phrase!.characters.count
        print(phrase)
        arrayOfBools = [Bool](count: phraseLength!, repeatedValue: false)
        for c in phraseArray! {
            setOfWordCharacters.insert(String(c))
            
        }
        displayWord()
    }

    func displayWord() {
        wordToGuess.text = ""
        for index in 0...phraseLength!-1 {
            if arrayOfBools![index] {
                 wordToGuess.text = wordToGuess.text! + String(phraseArray![index]) + " "
            } else {
                 wordToGuess.text = wordToGuess.text! + "- "
            }
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func isCorrectGuess(guess: String) {
        
    }
    @IBAction func correctGuessMade(sender: AnyObject){
        let guess = letterToGuess.text

        if guess!.characters.count == 1 {
            if (setOfWordCharacters.contains(guess!)) {
                                    print(guess)
                for index in 0...phraseLength!-1 {
                    if guess == String(phraseArray![index]) {
                        arrayOfBools![index] = true
                        print("true")
                    }
                }
            }
        }
        letterToGuess.text = ""
        displayWord()
    }
    
    @IBAction func incorrectGuessMade(sender: AnyObject) {
        let guess = letterToGuess.text
        if guess!.characters.count == 1 {
            if !wrongGuesses.contains(String(guess!)) && !(setOfWordCharacters.contains(guess!)) {
                print(guess)
                wrongGuesses.insert(String(guess!))
                if death < 7 {
                    death++
                }
                let imageName = "hangman" + String(death) + ".gif"
                hangman.image = UIImage(named: imageName)
            }
        }
        incorrectGuessList.text = String(wrongGuesses)
        letterToGuess.text = ""
        
    }
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
