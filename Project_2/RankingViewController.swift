//
//  RankingViewController.swift
//  Project_2
//
//  Created by admin on 5/14/21.
//

import UIKit
import SideMenu

class RankingViewController: UIViewController {

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
        menu = SideMenuNavigationController(rootViewController: AdminMenuListController())
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
            
            var scoreArray = [Double]()
            var nameArray = [String]()
           
            
            for i in curScores{
                //print(i.user!)
                //print(i.score)
                
                scoreArray.append(i.score)
                nameArray.append(i.user!)
            }
            
            var bestName = nameArray[0]
            var bestScore = scoreArray[0]
            var SbestName = nameArray[1]
            var SbestScore = scoreArray[1]
            var TbestName = nameArray[2]
            var TbestScore = scoreArray[2]
            var p = 0
            
            print(bestName)
            print(bestScore)
            print(SbestName)
            print(SbestScore)
            print(TbestName)
            print(TbestScore)
            
            for s in scoreArray{
                if(bestScore < scoreArray[p]){
                    bestScore = scoreArray[p]
                    bestName = nameArray[p]
                }else{
                    if(bestScore < SbestScore){
                        bestScore = SbestScore
                        bestName = SbestName
                    }else if(bestScore < TbestScore){
                        bestScore = TbestScore
                        bestName = TbestName
                    }
                    
                }
                if(SbestScore < scoreArray[p] && bestScore > scoreArray[p]){
                    SbestScore = scoreArray[p]
                    SbestName = nameArray[p]
                }else{
                    if(SbestScore > bestScore){
                        SbestScore = bestScore
                        SbestName = bestName
                    }else if(SbestScore < TbestScore){
                        SbestScore = TbestScore
                        SbestName = TbestName
                    }
                    
                }
                
                //work in the below block for 3rd
                if(TbestScore < scoreArray[p] && bestScore > scoreArray[p] && SbestScore > scoreArray[p]){
                    TbestScore = scoreArray[p]
                    TbestName = nameArray[p]
                }else{
                    if(TbestScore > bestScore){
                        TbestScore = bestScore
                        TbestName = bestName
                    }else if(TbestScore > SbestScore){
                        TbestScore = SbestScore
                        TbestName = SbestName
                    }
                    
                }
                
                
                p += 1
            }
            print(bestName)
            print(bestScore)
            print(SbestName)
            print(SbestScore)
            print(TbestName)
            print(TbestScore)
            
            
            /*
                if bestScore != 0.0{
                    SbestScore = i.score
                    SbestName = i.user!
                }
                if bestScore != 0.0 && SbestScore != 0.0{
                    TbestScore = i.score
                    TbestName = i.user!
                }
               
        
                if(i.score > bestScore){
                        bestName = i.user!
                        bestScore = i.score
                }
                if(bestScore < SbestScore){
                    bestScore = SbestScore
                }
                if(bestScore < TbestScore){
                    bestScore = TbestScore
                }
                if i.score > bestScore{
                    SbestName = i.user!
                    SbestScore = i.score
                }
                if(SbestScore > TbestScore){
                    SbestScore = TbestScore
                }
                if(SbestScore > bestScore){
                    SbestScore = bestScore
                }
                if i.score > TbestScore{
                    TbestName = i.user!
                    TbestScore = i.score
                }
                if(TbestScore > bestScore){
                    TbestScore = bestScore
                }
                if(TbestScore > SbestScore){
                    TbestScore = SbestScore
                }
                print(bestName)
                print(bestScore)
                print(SbestName)
                print(SbestScore)
                print(TbestName)
                print(TbestScore)
                */
                    /*else {
                        print(i.user! + "'s score was not hight enough")
                    }
 */
              
                
                
            
            
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
