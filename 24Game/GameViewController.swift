//
//  GameViewController.swift
//  24Game
//
//  Created by Jack Chen on 1/6/17.
//  Copyright © 2017 Jack Chen. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {

    
    @IBOutlet weak var expressionLabel: UILabel!
    
    @IBOutlet weak var firstNumber: UIButton!
    
    @IBOutlet weak var secondNumber: UIButton!
    
    @IBOutlet weak var thirdNumber: UIButton!
    
    @IBOutlet weak var fourthNumber: UIButton!
    
    var numbersArray = [Int]()
    var currentResult = -1
    var concatenatedExpression = ""
    
    var firstPress = false
    var pressedNumber = false
    var firstNumberPressed = false
    var secondNumberPressed = false
    var thirdNumberPressed = false
    var fourthNumberPressed = false
    var plusPressed = false
    var minusPressed = false
    var multiplyPressed = false
    var dividePressed = false
    
    var nextOperation = "none"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        simulateGame()
    }
    
    func simulateGame() {
        numbersArray = [Int]()
        firstPress = false
        var chosenNumbers = expression24(mode: "easy")
        
        for (index, number) in chosenNumbers.enumerated() {
            print(number, index)
            var correctImage = UIImage(named: "nil.png")
            switch(number) {
            case "1":
                correctImage = UIImage(named: "one.png")
                
            case "2":
                correctImage = UIImage(named: "two.png")
            case "3":
                correctImage = UIImage(named: "three.png")
            case "4":
                correctImage = UIImage(named: "four.png")
            case "5":
                correctImage = UIImage(named: "five.png")
            case "6":
                correctImage = UIImage(named: "six.png")
            case "7":
                correctImage = UIImage(named: "seven.png")
            case "8":
                correctImage = UIImage(named: "eight.png")
            case "9":
                correctImage = UIImage(named: "nine.png")
            default:
                print("shouldn't come here")
                break
            }
            numbersArray.append(Int(number)!)
            if index == 0 {
                firstNumber.setImage(correctImage, for: .normal)
            } else if index == 1 {
                secondNumber.setImage(correctImage, for: .normal)
            } else if index == 2 {
                thirdNumber.setImage(correctImage, for: .normal)
            } else {
                fourthNumber.setImage(correctImage, for: .normal)
            }
            
            print("numbers array is", numbersArray)
            
        }
        
        
    }
    
    
    
    
    @IBAction func mainButton(sender: UIButton) {
        
        
        
        
        
        
        if firstPress == false {
            
            // This sets our value to be the number we pressed on
            currentResult = numbersArray[sender.tag]
            firstPress = true
            currentResult = numbersArray[sender.tag]
            concatenatedExpression += String(currentResult)
            expressionLabel.text = concatenatedExpression
            pressedNumber = true
        }
        
        // This means we pressed another number, time to evaluate what it is given the previous operation
        if pressedNumber == false {
            
            if (sender.tag == 0 && firstNumberPressed == false || sender.tag == 1 && secondNumberPressed == false || sender.tag == 2 && thirdNumberPressed == false || fourthNumberPressed == false && sender.tag == 3) {
                
                
                
                switch(nextOperation) {
                    case "plus":
                        currentResult = currentResult + numbersArray[sender.tag]
                    case "minus":
                        currentResult = currentResult - numbersArray[sender.tag]
                    case "multiply":
                        currentResult = currentResult * numbersArray[sender.tag]
                    case "divide":
                        currentResult = currentResult / numbersArray[sender.tag]
                    default:
                        break
                }
                
                
                concatenatedExpression += String(numbersArray[sender.tag])
                expressionLabel.text = concatenatedExpression
                pressedNumber = true
            }
        }
        
        switch(sender.tag) {
        case 0:
            firstNumberPressed = true
        case 1:
            secondNumberPressed = true
        case 2:
            thirdNumberPressed = true
        case 3:
            fourthNumberPressed = true
        default:
            break
        }
        
        
        print("our current result is now: ", currentResult)
        if expressionLabel.text?.characters.count == 13 {
            checkResult(finalResult: currentResult)
        }
        
        
    }

    func checkResult(finalResult: Int) {
        
        if finalResult == 24 {
            // perform some kind of segue
            print("YOU HAVE WON!")
        } else {
            // should clear the board
            resetVariables()
        }
        
        
    }
    
    @IBAction func plusPressed(_ sender: UIButton) {
        
        if pressedNumber && !plusPressed {
            concatenatedExpression = concatenatedExpression + " + "
            expressionLabel.text = concatenatedExpression
            nextOperation = "plus"
            plusPressed = true
        }
        pressedNumber = false
        
        
    }
    
    
    
    @IBAction func minusPressed(_ sender: UIButton) {
        if pressedNumber && !minusPressed {
            concatenatedExpression = concatenatedExpression + " - "
            expressionLabel.text = concatenatedExpression
            minusPressed = true
            nextOperation = "minus"
        }
        pressedNumber = false
    
    }
    
    
    @IBAction func multiplyPressed(_ sender: UIButton) {
        if pressedNumber && !multiplyPressed {
            concatenatedExpression = concatenatedExpression + " x "
            expressionLabel.text = concatenatedExpression
            multiplyPressed = true
            nextOperation = "multiply"
        }
        pressedNumber = false
        
    }
    
    
    @IBAction func dividePressed(_ sender: UIButton) {
        if pressedNumber && !dividePressed {
            concatenatedExpression = concatenatedExpression + " / "
            expressionLabel.text = concatenatedExpression
            dividePressed = true
            nextOperation = "divide"
        }
        pressedNumber = false
        
    }
    
    
    
    @IBAction func clearPressed(_ sender: UIButton) {
        print("clear")
        resetVariables()
    }
    
    func resetVariables() {
        currentResult = -1
        concatenatedExpression = ""
        
        firstPress = false
        pressedNumber = false
        firstNumberPressed = false
        secondNumberPressed = false
        thirdNumberPressed = false
        fourthNumberPressed = false
        plusPressed = false
        minusPressed = false
        multiplyPressed = false
        dividePressed = false
        nextOperation = "none"
        expressionLabel.text = concatenatedExpression
        
    }
    
    
    // Randomly generates new numbers as well as starting the timer over to 0 seconds elapsed
    @IBAction func skipPressed(_ sender: UIButton) {
        resetVariables()
        simulateGame()
    }
    
    
    
    
    

}
