//
//  AdminMenuListController.swift
//  Project_2
//
//  Created by Lam Nguyen on 5/16/21.
//

import UIKit
import SideMenu

class AdminMenuListController: UITableViewController {
    
    var items = [
                 "Logout",
                 "Auto Generate Quiz",
                 "New Quiz",
                 "New Question",
                 "Rankings",
                 "Clear Data",
                 "Admin Home"
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
            
        case 1:
        // Autogenerate Quiz
            // Create an alert if this cell is clicked
                let alert = UIAlertController(title: "Autogenerate Quiz", message: "Do you want to autogenerate a quiz?", preferredStyle: .alert)
            // Create an action to Allow Quiz Autogeneration
            alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: {
                action in
                print("Quiz Generated")
                self.generateQuiz()
                
                let sb : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let wel = sb.instantiateViewController(withIdentifier: "AdminViewController") as! AdminViewController
                self.dismiss(animated: true) {
                    () -> Void in
                    // Perform Segue or push some view with your code
                    UIApplication.shared.keyWindow?.rootViewController = wel
                }
            }))
            // Create action to prevent autogeneration
            alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: {
                action in
                print("Quiz NOT Generated")
                let sb : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let wel = sb.instantiateViewController(withIdentifier: "AdminViewController") as! AdminViewController
                self.dismiss(animated: true) {
                    () -> Void in
                    // Perform Segue or push some view with your code
                    UIApplication.shared.keyWindow?.rootViewController = wel
                    }
                }))
            //Instantiate the alert
            self.present(alert, animated: true)
            
        case 2:
            // Create A New Quiz
            print("New Button was clicked")
            let sb : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let wel = sb.instantiateViewController(withIdentifier: "QuizMaker") as! QuizMakerViewController
            self.dismiss(animated: true) {
                () -> Void in
                // Perform Segue or push some view with your code
                UIApplication.shared.keyWindow?.rootViewController = wel
            }
        case 3:
            
            // Create A New Question
            print("New Button was clicked")
            let sb : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let wel = sb.instantiateViewController(withIdentifier: "QuestionMaker") as! QuestionMakerViewController
            self.dismiss(animated: true) {
                () -> Void in
                // Perform Segue or push some view with your code
                UIApplication.shared.keyWindow?.rootViewController = wel
            }
            
        case 4:
            
           // View User Rankings
            print("View User Ranking Button was clicked")
            let sb : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let wel = sb.instantiateViewController(withIdentifier: "Ranking") as! RankingViewController
            self.dismiss(animated: true) {
                () -> Void in
                // Perform Segue or push some view with your code
                UIApplication.shared.keyWindow?.rootViewController = wel
            }
            
        case 5:
            
            // Delete all Data
            // Autogenerate Quiz
                // Create an alert if this cell is clicked
                    let alert = UIAlertController(title: "Delete all", message: "Do you want to delete all the data?", preferredStyle: .alert)
                // Create an action to Allow Quiz Autogeneration
                alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: {
                    action in
                    print("Data Deleted")
                    DBHelper.inst.clearData()
                    let sb : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let wel = sb.instantiateViewController(withIdentifier: "AdminViewController") as! AdminViewController
                    self.dismiss(animated: true) {
                        () -> Void in
                        // Perform Segue or push some view with your code
                        UIApplication.shared.keyWindow?.rootViewController = wel
                    }
                }))
                // Create action to prevent autogeneration
                alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: {
                    action in
                    print("Data not deleted")
                    let sb : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let wel = sb.instantiateViewController(withIdentifier: "AdminViewController") as! AdminViewController
                    self.dismiss(animated: true) {
                        () -> Void in
                        // Perform Segue or push some view with your code
                        UIApplication.shared.keyWindow?.rootViewController = wel
                        }
                    }))
                //Instantiate the alert
                self.present(alert, animated: true)
                
        case 6:
            // Go back to the User Admin Page
            let sb : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let wel = sb.instantiateViewController(withIdentifier: "AdminViewController") as! AdminViewController
            self.dismiss(animated: true) {
                () -> Void in
                // Perform Segue or push some view with your code
                UIApplication.shared.keyWindow?.rootViewController = wel
            }
            
        default:
            
            print("TableView Cell was clicked")

        }
    }
    
    func notify() {
        let cont = UNMutableNotificationContent()
        var n = [String]()
        var store = DBHelper.inst.getQuiz()
        for s in store{
            n.append(s.name!)
        }
        cont.title = n[n.count - 1]
        cont.subtitle = "A Quiz Has Been Created"
        cont.body = "Click here to take a Quiz"
        
        guard let imageurl = Bundle.main.url(forResource: "quiz", withExtension: "png") else{return}
        do{
            let att = try UNNotificationAttachment(identifier:"quiz", url: imageurl, options:.none)
            cont.attachments = [att]
            
        }
        catch let err{
            print(err)
        }
        
        
        let tg = UNTimeIntervalNotificationTrigger(timeInterval: 20, repeats: false)
        let req = UNNotificationRequest(identifier:"notification.is.01", content:cont, trigger:tg)
        UNUserNotificationCenter.current().add(req,withCompletionHandler: nil)
        
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
        self.notify()
        
    }
}
