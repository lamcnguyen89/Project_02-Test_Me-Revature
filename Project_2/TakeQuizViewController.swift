//
//  TakeQuizViewController.swift
//  Project_2
//
//  Created by Lam Nguyen on 5/13/21.
//

// Source Documentation on Radio Buttons Found at: https://github.com/DavydLiu/DLRadioButton

import UIKit
import DLRadioButton
import SideMenu

class TakeQuizViewController: UIViewController {
    
    var menu: SideMenuNavigationController?
    var quizName = DBHelper.inst.getCurrentQuiz()
    var quizCheck : Quiz?
    var container : [Question]?
    var questionCount = 0
    var timer = Timer()
    static var score = 0.0
    var seconds = 1800
    var answerPicked = ""
    

    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var scorel: UILabel!
    @IBOutlet weak var progressLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var choiceALabel: DLRadioButton!
    @IBOutlet weak var choiceBLabel: DLRadioButton!
    @IBOutlet weak var choiceCLabel: DLRadioButton!
    @IBOutlet weak var choiceDLabel: DLRadioButton!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(TakeQuizViewController.updateTimer)), userInfo: nil, repeats: true)
        questionCount = 0
        TakeQuizViewController.score = 0.0
        scorel.text = "Score: " + String(TakeQuizViewController.score)
        loadQuestion()
        
        // Create Side Menu
        menu = SideMenuNavigationController(rootViewController: MenuListController())
        menu?.leftSide = true
        menu?.setNavigationBarHidden(true, animated: false)
        SideMenuManager.default.leftMenuNavigationController = menu
        SideMenuManager.default.addPanGestureToPresent(toView: self.view)
        
        // Change Radio Button Text
        choiceALabel.titleLabel?.minimumScaleFactor = 0.5
        choiceALabel.titleLabel?.numberOfLines = 0
        choiceALabel.titleLabel?.adjustsFontSizeToFitWidth = true
        choiceBLabel.titleLabel?.minimumScaleFactor = 0.5
        choiceBLabel.titleLabel?.numberOfLines = 0
        choiceBLabel.titleLabel?.adjustsFontSizeToFitWidth = true
        choiceCLabel.titleLabel?.minimumScaleFactor = 0.5
        choiceCLabel.titleLabel?.numberOfLines = 0
        choiceCLabel.titleLabel?.adjustsFontSizeToFitWidth = true
        choiceDLabel.titleLabel?.minimumScaleFactor = 0.5
        choiceDLabel.titleLabel?.numberOfLines = 0
        choiceDLabel.titleLabel?.adjustsFontSizeToFitWidth = true
        
    }
    
    // Set Autorotation to false
    override open var shouldAutorotate: Bool {
        return false
    }
    
    // Specify the supported Orientation
    override open var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    
    @objc func updateTimer(){
        seconds -= 1
        time.text = "Time Left: " + timeMaker(time: TimeInterval(seconds))
        if seconds < 0{
            let sb : UIStoryboard = UIStoryboard(name: "UserViewController", bundle: nil)
            let wel = sb.instantiateViewController(withIdentifier: "Reset") as! ForgetPasswordViewController
            self.present(wel, animated: true, completion: nil)
            
        }
        
    }
    
    func timeMaker(time:TimeInterval) ->String{
        let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format: "%02i:%02i:%02i", hours, minutes, seconds)
    }
    
    @IBAction func didTapMenu() {
        present(menu!, animated: true)
    }
    
    @IBAction func choiceA(_ sender: Any) {
        answerPicked = (container?[questionCount].ans1!)!
    }
    
    @IBAction func choiceB(_ sender: Any) {
        answerPicked = (container?[questionCount].ans2!)!
        
    }
    
    @IBAction func choiceC(_ sender: Any) {
        answerPicked = (container?[questionCount].ans3!)!
        
    }
    
    @IBAction func choiceD(_ sender: Any) {
        answerPicked = (container?[questionCount].ans4!)!
        
    }
    
    @IBAction func submitAnswer(_ sender: Any) {
        
 
        if answerPicked.elementsEqual((container?[questionCount].cans)!){
            TakeQuizViewController.score = TakeQuizViewController.score + Double((100 / container!.count))
            print(String(TakeQuizViewController.score))
            scorel.text = "Score: " + String(TakeQuizViewController.score)
        }
        
        
        questionCount = questionCount + 1
        if questionCount == container?.count {
            var current = DBHelper.inst.getCurrentUser()
            DBHelper.inst.updateQtaken(username : current)
            print("Here getting something")
            var user = DBHelper.inst.getOneUser(user: current)
            
            if(user.score < TakeQuizViewController.score){
                var user = DBHelper.inst.getOneUser(user : current)
                if user.taken == false{
                    DBHelper.inst.addScore(quiz: quizName, name: current, score: TakeQuizViewController.score)
                    DBHelper.inst.updateTaken(username : current)
                } else {
                    var found = false
                    var scoresTemp = DBHelper.inst.getScoreDataOneGeneral(name : current)
                    print(scoresTemp.count)
                    for i in scoresTemp{
                        print(i.quiz)
                        print(quizName)
                        if(i.quiz == quizName){
                            found = true
                            
                        }
                        if (i.quiz == quizName && i.score < TakeQuizViewController.score){
                            DBHelper.inst.updateScore(quiz: quizName, name: current, score: TakeQuizViewController.score)
                        }
                    }
                    if found == false{
                        DBHelper.inst.addScore(quiz: quizName, name: current, score: TakeQuizViewController.score)
                    }
                }
            }
            var sb = UIStoryboard(name: "Main", bundle: nil)
            var wel = sb.instantiateViewController(withIdentifier: "UserViewController") as! UIViewController
            self.present(wel, animated: true, completion: nil)
            
        } else {
            var first = container?[questionCount]
            progressLabel.text = String(questionCount + 1) + " out of " + String(container!.count)
            questionLabel.text = first?.questions
            choiceALabel.setTitle(first?.ans1, for: .normal)
            choiceBLabel.setTitle(first?.ans2, for: .normal)
            choiceCLabel.setTitle(first?.ans3, for: .normal)
            choiceDLabel.setTitle(first?.ans4, for: .normal)
            
        }
        
    }
    
    
    @IBAction func exitQuiz(_ sender: Any) {
    }
    
    // Function to Load the question from the database
    func loadQuestion() {
        print(quizName)
        
        quizCheck = DBHelper.inst.getOneQuiz(quiz: quizName)
        container = quizCheck?.ztoq?.allObjects as! [Question]
        var first = container?.first
        
        questionLabel.text = first?.questions
        choiceALabel.setTitle(first?.ans1, for: .normal)
        choiceBLabel.setTitle(first?.ans2, for: .normal)
        choiceCLabel.setTitle(first?.ans3, for: .normal)
        choiceDLabel.setTitle(first?.ans4, for: .normal)
        progressLabel.text = String(questionCount + 1) + " out of " + String(container!.count)
        
        
        
    }

    

}
