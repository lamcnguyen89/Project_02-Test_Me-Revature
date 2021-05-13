//
//  TakeQuizViewController.swift
//  Project_2
//
//  Created by Lam Nguyen on 5/13/21.
//

// Source Documentation on Radio Buttons Found at: https://github.com/DavydLiu/DLRadioButton

import UIKit
import DLRadioButton

class TakeQuizViewController: UIViewController {
    var quizName = DBHelper.inst.getCurrentQuiz()
    var quizCheck : Quiz?
    var container : [Question]?
    var questionCount = 0
    var timer = Timer()
    var score = 0.0
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
    @IBOutlet weak var questionCategory: UILabel!
    
    @IBOutlet weak var messageLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(TakeQuizViewController.updateTimer)), userInfo: nil, repeats: true)
        questionCount = 0
        score = 0.0
        scorel.text = "Score: " + String(score)
        loadQuestion()

    
    }
    
    @objc func updateTimer(){
        seconds -= 1
        time.text = "Time Left: " + timeMaker(time: TimeInterval(seconds))
        
    }
    
    func timeMaker(time:TimeInterval) ->String{
        let hours = Int(time) / 3600
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format: "%02i:%02i:%02i", hours, minutes, seconds)
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
        
        if answerPicked == container?[questionCount].cans{
            score = score + 33
            scorel.text = "Score: " + String(score)
        }
        
        
        questionCount = questionCount + 1
        if questionCount == container?.count {
            var current = DBHelper.inst.getCurrentUser()
            var user = DBHelper.inst.getOneUser(user: current)
            
            if(user.score < score){
                DBHelper.inst.updateDataScore(username: current, object: score)
                
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
