//
//  QuizMakerViewController.swift
//  Project_2
//
//  Created by admin on 5/12/21.
//

import UIKit
import SideMenu

class QuizMakerViewController: UIViewController {
    
    var menu:SideMenuNavigationController?
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var numQ: UITextField!
    @IBOutlet weak var topic: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load Side Menu into View
        menu = SideMenuNavigationController(rootViewController: AdminMenuListController())
        menu?.leftSide = true
        menu?.setNavigationBarHidden(true, animated: false)
        SideMenuManager.default.leftMenuNavigationController = menu
        SideMenuManager.default.addPanGestureToPresent(toView: self.view)
        
    }
    
    @IBAction func didTapMenu() {
        present(menu!, animated: true)
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
                print("Attempting Retrieval Same Size")
                var quizcheck = DBHelper.inst.getOneQuiz(quiz: name.text!)
                var container = quizcheck.ztoq?.allObjects
                for printer in container!{
                    print(printer)
                }
                
            } else {
                var newQuestionHolder = [Question]()
                while newQuestionHolder.count < Int(numQ.text!)!{
                    var pulled = questionHolder.randomElement()
                    if newQuestionHolder.contains(pulled!){
                        print("Already Inside")
                    } else {
                        newQuestionHolder.append(pulled!)
                    }
                }
                
                for insertion in newQuestionHolder{
                    print("Got to the update code")
                    DBHelper.inst.updateQuiz(quiz: name.text!, question: insertion)
                }
                print("Attempting Retrieval Same Size")
                var quizcheck = DBHelper.inst.getOneQuiz(quiz: name.text!)
                var container = quizcheck.ztoq?.allObjects as! [Question]
                for printer in container{
                    print(printer)
                }
            }
    }
        // There is a bug with this notification. You have to add a catch statement to make sure that there is actually a quiz present before running a notification. Else this function will crash.
        notify()
       
    }
    
    // There is a bug with this notification. You have to add a catch statement to make sure that there is actually a quiz present before running a notification. Else this function will crash.
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


}
