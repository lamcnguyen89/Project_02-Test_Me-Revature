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
        
        loadQuestion()

    
    }
    
    @IBAction func choiceA(_ sender: Any) {
        messageLabel.text = "Choice A was selected"
    }
    
    @IBAction func choiceB(_ sender: Any) {
        messageLabel.text = "Choice B was selected"
    }
    
    @IBAction func choiceC(_ sender: Any) {
        messageLabel.text = "Choice C was selected"
    }
    
    @IBAction func choiceD(_ sender: Any) {
        messageLabel.text = "Choice D was selected"
    }
    
    @IBAction func submitAnswer(_ sender: Any) {
        messageLabel.text = "Submit button was pressed"
        
    }
    
    
    @IBAction func exitQuiz(_ sender: Any) {
        messageLabel.text = "Exit button was pressed"
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
        questionCount = questionCount + 1
        
    }

    

}
