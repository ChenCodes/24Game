//
//  GameOverViewController.swift
//  24Game
//
//  Created by Jack Chen on 1/7/17.
//  Copyright © 2017 Jack Chen. All rights reserved.
//

import UIKit
import GameKit
import GoogleMobileAds


class GameOverViewController: UIViewController, GKGameCenterControllerDelegate {

    @IBOutlet weak var currentScore: UILabel!
    
    @IBOutlet weak var bestScore: UILabel!
    
    @IBOutlet weak var bannerView: GADBannerView!
    
    
    var currentScoreInteger = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let request = GADRequest()
        request.testDevices = [kGADSimulatorID]
        bannerView.adUnitID = "ca-app-pub-5253392741312904/4397874541"
        bannerView.rootViewController = self
        bannerView.load(request)
                
        authPlayer()

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
            if previousScore < currentScoreInteger {
                let minutesPortion = String(format: "%02d", previousScore / 60 )
                let secondsPortion = String(format: "%02d", previousScore % 60 )
                bestScore.text = "\(minutesPortion):\(secondsPortion)"
            } else {
                let minutesPortion = String(format: "%02d", currentScoreInteger / 60 )
                let secondsPortion = String(format: "%02d", currentScoreInteger % 60 )
                bestScore.text = "\(minutesPortion):\(secondsPortion)"
            }
        }
        
        let minutesPortion = String(format: "%02d", currentScoreInteger / 60 )
        let secondsPortion = String(format: "%02d", currentScoreInteger % 60 )
        currentScore.text = "\(minutesPortion):\(secondsPortion)"
    }


    @IBAction func callGameCenter(_ sender: Any) {
        saveHighscore(number: UserDefaults.standard.value(forKey: "userHighScore") as! Int)
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
    func saveHighscore(number: Int){
        if GKLocalPlayer.localPlayer().isAuthenticated {
            let scoreReporter = GKScore(leaderboardIdentifier: "IDGOESHERE")
            scoreReporter.value = Int64(number)
            let scoreArray : [GKScore] = [scoreReporter]
            GKScore.report(scoreArray, withCompletionHandler: nil)
            print(scoreArray)
        }
        print("saved high score???")
    }
    
    func showLeaderBoard(){
        let viewController = self
        let gcvc = GKGameCenterViewController()
        gcvc.gameCenterDelegate = self
        viewController.present(gcvc, animated: true, completion: nil)
    }
    
    func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
        gameCenterViewController.dismiss(animated: true, completion: nil)
        
    }
    
    
    


}
