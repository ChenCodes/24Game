//
//  HomeViewController.swift
//  24Game
//
//  Created by Jack Chen on 1/6/17.
//  Copyright © 2017 Jack Chen. All rights reserved.
//

import UIKit
import GameKit

class HomeViewController: UIViewController,GKGameCenterControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        authPlayer()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func callGC(_ sender: Any) {
        if (UserDefaults.standard.value(forKey: "userHighScore") != nil) {
            saveHighscore(number: UserDefaults.standard.value(forKey: "userHighScore") as! Int)
            showLeaderBoard()
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

