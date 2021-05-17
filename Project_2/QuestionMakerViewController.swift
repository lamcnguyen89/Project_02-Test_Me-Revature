//
//  QuestionMakerViewController.swift
//  Project_2
//
//  Created by admin on 5/12/21.
//

import UIKit
import SideMenu

class QuestionMakerViewController: UIViewController {
    
    var menu:SideMenuNavigationController?
    @IBOutlet weak var Question: UITextField!
    @IBOutlet weak var ChoiceA: UITextField!
    @IBOutlet weak var ChoiceB: UITextField!
    @IBOutlet weak var ChoiceC: UITextField!
    @IBOutlet weak var ChoiceD: UITextField!
    @IBOutlet weak var Correct: UITextField!
    @IBOutlet weak var Qid: UITextField!
    @IBOutlet weak var msg: UILabel!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Create and Load SideMenu
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

    @IBAction func Save(_ sender: Any) {
        
        if (ChoiceA.hasText == false || ChoiceB.hasText == false || ChoiceC.hasText == false || ChoiceD.hasText == false || Correct.hasText == false || Qid.hasText == false) {
            msg.text = "Missing a required field, try again"
        } else {
            let dic = ["ans1" : ChoiceA.text!, "ans2" : ChoiceB.text!, "ans3" : ChoiceC.text!, "ans4" : ChoiceD.text!, "cans" : Correct.text!]
            DBHelper.inst.addDataQuestions(qid: Qid.text!, choices: dic, questionAct: Question.text!)
            
            msg.text = "Question added!"
            
            Question.text = ""
            ChoiceA.text = ""
            ChoiceB.text = ""
            ChoiceC.text = ""
            ChoiceD.text = ""
            Correct.text = ""
            Qid.text = ""
        }
        
    }


}
