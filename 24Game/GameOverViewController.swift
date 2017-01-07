//
//  GameOverViewController.swift
//  24Game
//
//  Created by Jack Chen on 1/7/17.
//  Copyright © 2017 Jack Chen. All rights reserved.
//

import UIKit
import GameKit


class GameOverViewController: UIViewController, GKGameCenterControllerDelegate {

    @IBOutlet weak var currentScore: UILabel!
    
    @IBOutlet weak var bestScore: UILabel!
    
    var currentScoreInteger = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if (UserDefaults.standard.value(forKey: "userHighScore") != nil)  {
            
            var previousScore = UserDefaults.standard.value(forKey: "userHighScore")! as? Int
            let minutesPortion = String(format: "%02d", previousScore! / 60 )
            let secondsPortion = String(format: "%02d", previousScore! % 60 )
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


    @IBAction func callGameCenter(_ sender: UIButton) {
        if let previousScore = UserDefaults.standard.value(forKey: "userHighScore")! as? Int {
            saveHighscore(number: previousScore)
        }
        showLeaderBoard()
    }

    
    func authPlayer(){
        let localPlayer = GKLocalPlayer.localPlayer()
        
        localPlayer.authenticateHandler = {
            (view, error) in
            
            if view != nil {
                
                self.present(view!, animated: true, completion: nil)
                
            }
            else {
                
                print(GKLocalPlayer.localPlayer().isAuthenticated)
                
            }
            
            
        }
    }
    
    func saveHighscore(number : Int){
        
        if GKLocalPlayer.localPlayer().isAuthenticated {
            
            let scoreReporter = GKScore(leaderboardIdentifier: "This2")
            
            scoreReporter.value = Int64(number)
            
            let scoreArray : [GKScore] = [scoreReporter]
            
            GKScore.report(scoreArray, withCompletionHandler: nil)
            
        }
    }
    
    func showLeaderBoard(){
        let viewController = self.view.window?.rootViewController
        let gcvc = GKGameCenterViewController()
        
        gcvc.gameCenterDelegate = self
        
        viewController?.present(gcvc, animated: true, completion: nil)
    }
    
    
    func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
        gameCenterViewController.dismiss(animated: true, completion: nil)
        
    }
    
    
    


}
