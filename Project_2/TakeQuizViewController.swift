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
        
        var data = ["Which of these is a fruit?","Apple","Cat","Cactus","Tomato","Avocado"]
        
        questionLabel.text = data[0]
        choiceALabel.setTitle(data[1], for: .normal)
        choiceBLabel.setTitle(data[2], for: .normal)
        choiceCLabel.setTitle(data[3], for: .normal)
        choiceDLabel.setTitle(data[4], for: .normal)
    }


}
