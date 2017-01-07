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
    
    @IBOutlet weak var timeElapsed: UILabel!
    
    @IBOutlet weak var bestScoreLabel: UILabel!
    
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
    
    var countdown = 5
    var elapsedTime = 0
    
    var countdownTimer = Timer()
    var elapsedTimer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: Selector("showCountdown"), userInfo: nil, repeats: true)
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        print("did we come here")
        if UserDefaults.standard.value(forKey: "userHighScore") != nil {
            if let previousScore = UserDefaults.standard.value(forKey: "userHighScore")! as? Int {
                print("we shoudn't be in here")
                let minutesPortion = String(format: "%02d", previousScore / 60 )
                let secondsPortion = String(format: "%02d", previousScore % 60 )
                self.bestScoreLabel.text = "\(minutesPortion):\(secondsPortion)"
            }
        }
        
    }
    
    func showCountdown() {
        if(countdown > 0) {
            if countdown > 4 {
                expressionLabel.text = "Get Ready"
                countdown = countdown - 1
            } else {
              countdown = countdown - 1
                if countdown == 0 {
                    print("hey")
                    countdownTimer.invalidate()
                    expressionLabel.text = ""
                    
                    // this is when we generate the moves and stuff
                    simulateGame()
                    startElapsedTimer()
                } else {
                    expressionLabel.text = String(countdown)
                }
            }
        }
        print("got to end of showcountfodn")
    }
    
    
    func startElapsedTimer() {
        elapsedTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            self.elapsedTime += 1
            let minutesPortion = String(format: "%02d", self.elapsedTime / 60 )
            let secondsPortion = String(format: "%02d", self.elapsedTime % 60 )
            self.timeElapsed.text = "\(minutesPortion):\(secondsPortion)"
        }
    }
    
    func stopElapsedTimer() {
        elapsedTimer.invalidate()
    }
    
    
    func simulateGame() {
        print("hello")
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
        print("CCC")
        
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
        
        if expressionLabel.text?.characters.count == 13 {
            checkResult(finalResult: currentResult)
        }
        
        
    }

    func checkResult(finalResult: Int) {
        print("should be here")
        if finalResult == 24 {
            // perform some kind of segue
            var storyboard : UIStoryboard = UIStoryboard(name: "GameOver", bundle: nil)
            print("1")
            let secondViewController = storyboard.instantiateViewController(withIdentifier: "GameOverViewController") as! GameOverViewController
            secondViewController.currentScoreInteger = elapsedTime
            
            print("2")
            self.present(secondViewController, animated: true, completion: nil)
            print("3")
            
            
            
            if (UserDefaults.standard.value(forKey: "userHighScore") == nil) {
                print("should've come in here?")
                UserDefaults.standard.set(elapsedTime, forKey: "userHighScore")
                
                print("oh nooo")
            }
            
            
            var previousScore = UserDefaults.standard.value(forKey: "userHighScore")! as? Int
            
            
            // If our current score is better than our high score
            if (elapsedTime < previousScore!) {
                UserDefaults.standard.setValue(elapsedTime, forKey: "userHighScore")
                let minutesPortion = String(format: "%02d", self.elapsedTime / 60 )
                let secondsPortion = String(format: "%02d", self.elapsedTime % 60 )
                self.bestScoreLabel.text = "\(minutesPortion):\(secondsPortion)"
                
            }
            

            
            
            stopElapsedTimer()
            print("YOU HAVE WON!")
        } else {
            // should clear the board
            resetVariables(clearPress: true)
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
        resetVariables(clearPress: true)
    }
    
    func resetVariables(clearPress: Bool) {
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
        countdown = 5
        if !clearPress {
            elapsedTime = 0
            let minutesPortion = String(format: "%02d", elapsedTime / 60 )
            let secondsPortion = String(format: "%02d", elapsedTime % 60 )
            self.timeElapsed.text = "\(minutesPortion):\(secondsPortion)"
            
        }
    }
    
    // Randomly generates new numbers as well as starting the timer over to 0 seconds elapsed
    @IBAction func skipPressed(_ sender: UIButton) {
        resetVariables(clearPress: false)
        countdownTimer.invalidate()
        elapsedTimer.invalidate()
        countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: Selector("showCountdown"), userInfo: nil, repeats: true)
    }
    
    
    
    
    

}
