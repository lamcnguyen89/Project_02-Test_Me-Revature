//
//  QuestionMakerViewController.swift
//  Project_2
//
//  Created by admin on 5/12/21.
//

import UIKit

class QuestionMakerViewController: UIViewController {
    
    
    @IBOutlet weak var Question: UITextField!
    @IBOutlet weak var ChoiceA: UITextField!
    @IBOutlet weak var ChoiceB: UITextField!
    @IBOutlet weak var ChoiceC: UITextField!
    @IBOutlet weak var ChoiceD: UITextField!
    @IBOutlet weak var Correct: UITextField!
    @IBOutlet weak var Qid: UITextField!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func Save(_ sender: Any) {
        
        if (ChoiceA.hasText == false || ChoiceB.hasText == false || ChoiceC.hasText == false || ChoiceD.hasText == false || Correct.hasText == false || Qid.hasText == false) {
            print("Missing a required field, try again")
        } else {
            let dic = ["ans1" : ChoiceA.text!, "ans2" : ChoiceB.text!, "ans3" : ChoiceC.text!, "ans4" : ChoiceD.text!, "cans" : Correct.text!]
            DBHelper.inst.addDataQuestions(qid: Qid.text!, choices: dic, questionAct: Question.text!)
            
        }
        
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
