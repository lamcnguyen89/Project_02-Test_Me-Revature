//
//  AdminViewController.swift
//  Project_2
//
//  Created by admin on 5/11/21.
//

import UIKit
import SideMenu

class AdminViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    var menu:SideMenuNavigationController?
    var user = [String]()
    var scoreArray = [Double]()
    var scoreArray2 = [Double]()
    static var selected = 0
    var blockArray = [Bool]()
    let data = DBHelper.inst.getData()
    var data1 = DBHelper.inst.getScoreData()
    
    
    @IBOutlet weak var score2: UILabel!
    @IBOutlet weak var score: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadQuizScores()
        
        
        menu = SideMenuNavigationController(rootViewController: AdminMenuListController())
        menu?.leftSide = true
        menu?.setNavigationBarHidden(true, animated: false)
        SideMenuManager.default.leftMenuNavigationController = menu
        SideMenuManager.default.addPanGestureToPresent(toView: self.view)
        
    }
    
    
    @IBAction func blockUser(_ sender: Any) {
        blockArray[AdminViewController.selected] = true
        var users = user[AdminViewController.selected]
        DBHelper.inst.updateBlock(object: users)
        print(user[AdminViewController.selected], " blocked!")
        
    }
    
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
    }
    
    func loadQuizScores() {
        var adder = 0
        var k = 0
         
        for j in data{
            if j.username?.isEmpty == false{
                adder += 1
                scoreArray.append(0.0)
            }
        }
        
        for i in data1{
            if i.score != 0.0{
                k += 1
            }
         }
        
          for st in data{
            
            scoreArray2.append(st.score2)
            blockArray.append(st.block)
            user.append(st.username!)
          }
    }
    

    
}

class AdminMenuListController: UITableViewController {
    
    var items = [
                 "Logout",
                 "Auto Generate Quiz",
                 "Create New Quiz",
                 "Create A New Question",
                 "View Quiz Rankings",
                 "Delete All Data"
                ]
    
    let darkColor = UIColor(red: 33/255.0, green: 33/255.0, blue: 33/255.0, alpha: 1)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = darkColor
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = items[indexPath.row]
        cell.textLabel?.textColor = .white
        cell.backgroundColor = darkColor
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Determine what to do when a cell in a particular section is selected.
        switch indexPath.row {
        
        case 0:
            
            // Logout
            print("Logout Button was clicked")
            let sb : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let wel = sb.instantiateViewController(withIdentifier: "Login") as! LoginViewController
            self.dismiss(animated: true) {
                () -> Void in
                // Perform Segue or push some view with your code
                UIApplication.shared.keyWindow?.rootViewController = wel
            }
            
            self.present(wel, animated: true, completion: nil)
            
        case 1:
            // Autogenerate Quiz
            print("Autogenerate Button was clicked")
            generateQuiz()
            
        case 2:
            // Create A New Quiz
            print("New Button was clicked")
            let sb : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let wel = sb.instantiateViewController(withIdentifier: "QuizMaker") as! QuizMakerViewController
            self.present(wel, animated: true, completion: nil)
            
        case 3:
            
            // Create A New Question
            print("New Button was clicked")
            let sb : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let wel = sb.instantiateViewController(withIdentifier: "QuestionMaker") as! QuestionMakerViewController
            self.present(wel, animated: true, completion: nil)
            
        case 4:
            
           // View User Rankings
            print("View User Ranking Button was clicked")
            let sb : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let wel = sb.instantiateViewController(withIdentifier: "Ranking") as! RankingViewController
            self.present(wel, animated: true, completion: nil)
            
        case 5:
            
            // Delete all Data
            print("Delete Button was clicked")
            DBHelper.inst.clearData()
            
        default:
            
            print("TableView Cell was clicked")
            
        }
    }
    
    // Function To Autogenerate a Default
    func generateQuiz() {
        let dic = ["ans1" : "A single use variable", "ans2" : "An array", "ans3" : "A blueprint for a class", "ans4" : "None of the above", "cans" : "A blueprint for a class"]
        DBHelper.inst.addDataQuestions(qid: "Swift", choices: dic, questionAct: "What is a protocol?")
        let dic2 = ["ans1" : "an Android iOS", "ans2" : "an Apple OS", "ans3" : "A Windows OS", "ans4" : "None of the above", "cans" : "an Apple OS"]
        DBHelper.inst.addDataQuestions(qid: "Swift", choices: dic2, questionAct: "What is iOS")
        let dic3 = ["ans1" : "Coding language for Java", "ans2" : "A database centered language", "ans3" : "Coding language for Apple Devices", "ans4" : "None of the above", "cans" : "Coding language for Apple Devices"]
        DBHelper.inst.addDataQuestions(qid: "Swift", choices: dic3, questionAct: "What is Swift?")
        
        var questions = DBHelper.inst.getDataQuestions()
        var questionHolder = [Question]()
        
        for question in questions{
            if question.qid == "Swift"{
                print(question.questions!)
                questionHolder.append(question)
            }
        }
        print(questionHolder.count)
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
        DBHelper.inst.addDataQuestions(qid: "Java", choices: dic4, questionAct: "Which choice is not a pillar of OOP?")
        let dic5 = ["ans1" : "A variable", "ans2" : "An integer", "ans3" : "A string holder", "ans4" : "None of the above", "cans" : "None of the above"]
        DBHelper.inst.addDataQuestions(qid: "Java", choices: dic5, questionAct: "What is a function?")
        let dic6 = ["ans1" : "Coding language", "ans2" : "A database", "ans3" : "Coding language for Apple Devices", "ans4" : "None of the above", "cans" : "Coding language"]
        DBHelper.inst.addDataQuestions(qid: "Java", choices: dic6, questionAct: "What is Java?")
        
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
}
