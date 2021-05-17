//
//  UserSideRankingViewController.swift
//  Project_2
//
//  Created by Lam Nguyen on 5/16/21.
//

import UIKit
import SideMenu

class UserSideRankingViewController: UIViewController {

    var menu:SideMenuNavigationController?
    @IBOutlet weak var Rank1: UILabel!
    @IBOutlet weak var Rank2: UILabel!
    @IBOutlet weak var Rank3: UILabel!
    @IBOutlet weak var Quiz: UILabel!
    var current : Quiz?
    var allQuizzes = DBHelper.inst.getQuiz()
    var index = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if allQuizzes.count == 0{
            Quiz.text = "No current quizzes"
        } else{
            Rank2.text = ""
            Rank3.text = ""
            displayRank()
        }
        // Load Side Menu into View
        menu = SideMenuNavigationController(rootViewController: MenuListController())
        menu?.leftSide = true
        menu?.setNavigationBarHidden(true, animated: false)
        SideMenuManager.default.leftMenuNavigationController = menu
        SideMenuManager.default.addPanGestureToPresent(toView: self.view)
                
    }
    
    // Set Autorotation to false
    override open var shouldAutorotate: Bool {
        return false
    }
    
    // Specify the supported Orientation
    override open var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    @IBAction func didTapMenu() {
        present(menu!, animated: true)
    }
    
    func displayRank(){
        if index == allQuizzes.count{
            index = 0
        }
        current = allQuizzes[index]
        Quiz.text = (current?.name!)! + " Ranking"
        var overallScores = DBHelper.inst.getScoreData()
        var curScores = [ScoreHolder]()
        
        for i in overallScores{
            if(i.quiz == current?.name){
                curScores.append(i)
            }
        }
        
        
        switch curScores.count {
        case 0:
            Rank1.text = "No User Recorded Ranks"
        case 1:
            Rank1.text = curScores[0].user! + " has the best score of " + String(curScores[0].score)
        case 2:
            print("Here")
            var first = curScores[0]
            var second = curScores[1]
            
            if first.score > second.score{
                Rank1.text = first.user! + " has the best score of " + String(first.score)
                Rank2.text = second.user! + " has the best score of " + String(second.score)
            } else {
                Rank2.text = first.user! + " has the best score of " + String(first.score)
                Rank1.text = second.user! + " has the best score of " + String(second.score)
            }
            
            
            
        default:
            
            var bestName = ""
            var bestScore = 0.0
            var SbestName = ""
            var SbestScore = 0.0
            var TbestName = ""
            var TbestScore = 0.0
            
            
            for i in curScores{
                print(i.user!)
                print(i.score)
                if bestScore == 0.0 && i.score > 0{
                    bestName = i.user!
                    bestScore = i.score
                } else if SbestScore == 0.0 && i.score > 0{
                    SbestScore = i.score
                    SbestName = i.user!
                } else if TbestScore == 0.0 && i.score > 0{
                    TbestScore = i.score
                    TbestName = i.user!
                } else {
                    if(i.score > bestScore){
                        bestName = i.user!
                        bestScore = i.score
                    } else if i.score > bestScore{
                        SbestName = i.user!
                        SbestScore = i.score
                    } else if i.score > TbestScore{
                        TbestName = i.user!
                        TbestScore = i.score
                    } else {
                        print(i.user! + "'s score was not hight enough")
                    }
                }
            }
            
            Rank3.text = bestName + " has the best score of " + String(bestScore)
            Rank2.text = SbestName + " has the second best score of " + String(SbestScore)
            Rank1.text = TbestName + " has the third best score of " + String(TbestScore)
        }
        
        
    }
    
    @IBAction func next(_ sender: Any) {
        index = index + 1
        Rank2.text = ""
        Rank3.text = ""
        displayRank()
    }

}
