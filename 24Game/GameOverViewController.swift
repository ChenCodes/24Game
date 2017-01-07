//
//  GameOverViewController.swift
//  24Game
//
//  Created by Jack Chen on 1/7/17.
//  Copyright © 2017 Jack Chen. All rights reserved.
//

import UIKit

class GameOverViewController: UIViewController {

    @IBOutlet weak var currentScore: UILabel!
    
    @IBOutlet weak var bestScore: UILabel!
    
    var currentScoreInteger = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let previousScore = UserDefaults.standard.value(forKey: "userHighScore")! as? Int {
            let minutesPortion = String(format: "%02d", previousScore / 60 )
            let secondsPortion = String(format: "%02d", previousScore % 60 )
            bestScore.text = "\(minutesPortion):\(secondsPortion)"
        }
        
        let minutesPortion = String(format: "%02d", currentScoreInteger / 60 )
        let secondsPortion = String(format: "%02d", currentScoreInteger % 60 )
        currentScore.text = "\(minutesPortion):\(secondsPortion)"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print(currentScoreInteger)
        if let previousScore = UserDefaults.standard.value(forKey: "userHighScore")! as? Int {
            let minutesPortion = String(format: "%02d", previousScore / 60 )
            let secondsPortion = String(format: "%02d", previousScore % 60 )
            bestScore.text = "\(minutesPortion):\(secondsPortion)"
        }
        
        let minutesPortion = String(format: "%02d", currentScoreInteger / 60 )
        let secondsPortion = String(format: "%02d", currentScoreInteger % 60 )
        currentScore.text = "\(minutesPortion):\(secondsPortion)"
    }





}
