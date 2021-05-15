//
//  AdminViewController.swift
//  Project_2
//
//  Created by admin on 5/11/21.
//

import UIKit

class AdminViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    
    
    
    //var userDict:[String:String] = [:]
    var user = [String]()
    var scoreArray = [Double]()
    var scoreArray2 = [Double]()
    static var selected = 0
    var blockArray = [Bool]()
    let data = DBHelper.inst.getData()
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return user.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return user[row]
        
    }
 
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        AdminViewController.selected = row
        print(row)
        print(user[row])
        score.text = String(scoreArray[row])
       // score.text = String(scoreArray[row])
       
       
    }
    
    
    
 
    
    @IBOutlet weak var score2: UILabel!
    
    @IBOutlet weak var score: UILabel!
    
   
    
    
    @IBAction func blockUser(_ sender: Any) {
        blockArray[AdminViewController.selected] = true
        var users = user[AdminViewController.selected]
        DBHelper.inst.updateBlock(object: users)
        print(user[AdminViewController.selected], " blocked!")
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        var data1 = DBHelper.inst.getScoreData()
        var adder = 0
        var k = 0
         
        for j in data{
            if j.username?.isEmpty == false{
                adder += 1
                scoreArray.append(0.0)
                
            }
        }
        
        print(adder)
        
        
        for i in data1{
            if i.score != 0.0{
   //             scoreArray[k] = i.score
                k += 1
            }
             
         }
        
          for st in data{
            
            scoreArray2.append(st.score2)
            blockArray.append(st.block)
            user.append(st.username!)
          }
        
        // Do any additional setup after loading the view.
    }
    
    /*
    @IBAction func questionsActive(_ sender: Any) {
       var questions = DBHelper.inst.getDataQuestions()
        
        for questions in questions{
            print(questions.questions)
        }
    }
 */
    
    @IBAction func generateQuiz(_ sender: Any) {
        let dic = ["ans1" : "A single use variable", "ans2" : "An array", "ans3" : "A blueprint for a class", "ans4" : "None of the above", "cans" : "A blueprint for a class"]
        DBHelper.inst.addDataQuestions(qid: "Swift", choices: dic, questionAct: "What is a protocol?")
        let dic2 = ["ans1" : "an Android iOS", "ans2" : "an Apple OS", "ans3" : "A Windows OS", "ans4" : "None of the above", "cans" : "an Apple OS"]
        DBHelper.inst.addDataQuestions(qid: "Swift", choices: dic, questionAct: "What is iOS")
        let dic3 = ["ans1" : "Coding language for Java", "ans2" : "A database centered language", "ans3" : "Coding language for Apple Devices", "ans4" : "None of the above", "cans" : "Coding language for Apple Devices"]
        DBHelper.inst.addDataQuestions(qid: "Swift", choices: dic, questionAct: "What is Swift?")
        
        var questions = DBHelper.inst.getDataQuestions()
        var questionHolder = [Question]()
        
        for question in questions{
            if question.qid == "Swift"{
                print(question.questions!)
                questionHolder.append(question)
            }
        }
        
        DBHelper.inst.addQuiz(name: "Swift Quiz", questions: 3.0)
        if(questionHolder.count == 3){
            for insertion in questionHolder{
                print("Got to the update code")
                DBHelper.inst.updateQuiz(quiz: "Swift Quiz", question: insertion)
            }
            print("Attempting Retrieval Same Size")
            var quizcheck = DBHelper.inst.getOneQuiz(quiz: "Swift Quiz")
            var container = quizcheck.ztoq?.allObjects
            for printer in container!{
                print(printer)
            }
            
        } else {
            var newQuestionHolder = [Question]()
            while newQuestionHolder.count < 3{
                var pulled = questionHolder.randomElement()
                if newQuestionHolder.contains(pulled!){
                    print("Already Inside")
                } else {
                    newQuestionHolder.append(pulled!)
                }
            }
            
            for insertion in newQuestionHolder{
                print("Got to the update code")
                DBHelper.inst.updateQuiz(quiz: "Swift Quiz", question: insertion)
            }
            print("Attempting Retrieval Same Size")
            var quizcheck = DBHelper.inst.getOneQuiz(quiz: "Swift Quiz")
            var container = quizcheck.ztoq?.allObjects as! [Question]
            for printer in container{
                print(printer)
            }
        }
        
        let dic4 = ["ans1" : "Inheritance", "ans2" : "Polymorphism", "ans3" : "Abstraction", "ans4" : "Severance", "cans" : "Severance"]
        DBHelper.inst.addDataQuestions(qid: "Java", choices: dic, questionAct: "Which choice is not a pillar of OOP?")
        let dic5 = ["ans1" : "A variable", "ans2" : "An integer", "ans3" : "A string holder", "ans4" : "None of the above", "cans" : "None of the above"]
        DBHelper.inst.addDataQuestions(qid: "Java", choices: dic, questionAct: "What is a function?")
        let dic6 = ["ans1" : "Coding language", "ans2" : "A database", "ans3" : "Coding language for Apple Devices", "ans4" : "None of the above", "cans" : "Coding language"]
        DBHelper.inst.addDataQuestions(qid: "Java", choices: dic, questionAct: "What is Java?")
        
        var questions2 = DBHelper.inst.getDataQuestions()
        var questionHolder2 = [Question]()
        
        for question in questions2{
            if question.qid == "Java"{
                print(question.questions!)
                questionHolder2.append(question)
            }
        }
        
        DBHelper.inst.addQuiz(name: "Java Quiz", questions: 3.0)
        if(questionHolder2.count == 3){
            for insertion in questionHolder2{
                print("Got to the update code")
                DBHelper.inst.updateQuiz(quiz: "Java Quiz", question: insertion)
            }
            print("Attempting Retrieval Same Size")
            var quizcheck = DBHelper.inst.getOneQuiz(quiz: "Java Quiz")
            var container = quizcheck.ztoq?.allObjects
            for printer in container!{
                print(printer)
            }
            
        } else {
            var newQuestionHolder = [Question]()
            while newQuestionHolder.count < 3{
                var pulled = questionHolder2.randomElement()
                if newQuestionHolder.contains(pulled!){
                    print("Already Inside")
                } else {
                    newQuestionHolder.append(pulled!)
                }
            }
            
            for insertion in newQuestionHolder{
                print("Got to the update code")
                DBHelper.inst.updateQuiz(quiz: "Java Quiz", question: insertion)
            }
            print("Attempting Retrieval Same Size")
            var quizcheck = DBHelper.inst.getOneQuiz(quiz: "Java Quiz")
            var container = quizcheck.ztoq?.allObjects as! [Question]
            for printer in container{
                print(printer)
            }
        }
    }
    @IBAction func deletetion(_ sender: Any) {
        DBHelper.inst.clearData()
    }
    /*
    @IBAction func scoresViewer(_ sender: Any) {
       var data = DBHelper.inst.getScoreData()
        
        for i in data {
            print(i.user! + " On Quiz: " + i.quiz!)
            print("Score: " + String(i.score))
        }
 
    }
 */
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
