//
//  QuizMakerViewController.swift
//  Project_2
//
//  Created by admin on 5/12/21.
//

import UIKit

class QuizMakerViewController: UIViewController {

    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var numQ: UITextField!
    @IBOutlet weak var topic: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func submit(_ sender: Any) {
       var questions = DBHelper.inst.getDataQuestions()
        var questionHolder = [Question]()
        
        for question in questions{
            if question.qid == topic.text!{
                print(question.questions!)
                questionHolder.append(question)
            }
        }
        
        if(questionHolder.count < Int(numQ.text!)!){
            print("Need more questions, please submit more")
        } else {
            DBHelper.inst.addQuiz(name: name.text!, questions: Double(numQ.text!)!)
            if(questionHolder.count == Int(numQ.text!)!){
                for insertion in questionHolder{
                    print("Got to the update code")
                    DBHelper.inst.updateQuiz(quiz: name.text!, question: insertion)
                }
            }
            print("Attempting Retrieval")
            var quizcheck = DBHelper.inst.getOneQuiz(quiz: name.text!)
            var container = quizcheck.ztoq?.allObjects
            for printer in container!{
                print(printer)
            }
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
