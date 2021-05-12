//
//  DBHelper.swift
//  Project_2
//
//  Created by admin on 5/10/21.
//

import Foundation
import CoreData
import UIKit

class DBHelper{
    var current = ""
    static var inst = DBHelper()
    
    static var dataCheck = false
    
    
    let context = (UIApplication.shared.delegate as? AppDelegate)? .persistentContainer.viewContext
    
    func addData(object : [String:String]){
        let user = NSEntityDescription.insertNewObject(forEntityName: "User", into: context!) as! User
        user.username = object["username"]
        user.password = object["password"]
        user.score = 0.0
        do{
            try context?.save()
            print("Data Save")
            print("", user.username)
            print("",user.password)
        }
        catch{
            print("data not saved")
        }
    }
    
    func addDataQuestions(qid : String, choices : [String:String], questionAct : String){
        let question = NSEntityDescription.insertNewObject(forEntityName: "Question", into: context!) as! Question
        question.ans1 = choices["ans1"]
        question.ans2 = choices["ans2"]
        question.ans3 = choices["ans3"]
        question.ans4 = choices["ans4"]
        question.cans = choices["cans"]
        question.qid = qid
        question.questions = questionAct
        
        do{
            try context?.save()
            print("Data Save")
        }
        catch{
            print("data not saved")
        }
    }
    
    
    func addQuiz(object : [String:String], questions : Double){
        let quiz = NSEntityDescription.insertNewObject(forEntityName: "Quiz", into: context!) as! Quiz
       
        do{
            try context?.save()
            print("Data Save")
            
        }
        catch{
            print("data not saved")
        }
        
    }
    func updateData(object : [String:String]){
        
        var st = User()
        var fetchReq = NSFetchRequest<NSManagedObject>.init(entityName: "User")
        fetchReq.predicate = NSPredicate(format: "username == %@", object["username"]!)
        
        do{
            let stu = try context?.fetch(fetchReq)
            
            if(stu?.count != 0){
                st = stu?.first as! User
                st.password = object["password"]
                try context?.save()            }
            
        }
        catch{
            print("Error")
        }
        
    }
    
    func getData()-> [User]{
        var stu = [User]()
        var fetchReq = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        do{
            stu = try context?.fetch(fetchReq) as!
     [User]
        }
        catch{
            print("cannot fetch the data")
        }
        return stu
    }
    
    func getDataQuestions()-> [Question]{
        var stu = [Question]()
        var fetchReq = NSFetchRequest<NSFetchRequestResult>(entityName: "Question")
        do{
            stu = try context?.fetch(fetchReq) as! [Question]
        }
        catch{
            print("cannot fetch the data")
        }
        return stu
    }
    
    
    func clearData(){
        let rvar = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        let del = NSBatchDeleteRequest(fetchRequest: rvar)
        let qvar = NSFetchRequest<NSFetchRequestResult>(entityName: "Question")
        let qdel = NSBatchDeleteRequest(fetchRequest: qvar)

        do{
            print("Data deleted")
            try context?.execute(del)
            try context?.execute(qdel)
        }
        catch{
            print("error")
        }
    }
    
    func holdCurrentUser(name : String){
        current = name
    }
    func getCurrentUser() -> String {
        return current;
    }
    
}
