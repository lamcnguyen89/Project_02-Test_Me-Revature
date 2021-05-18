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
    var currentQuiz = ""
    static var inst = DBHelper()
    
    static var dataCheck = false
    
    
    let context = (UIApplication.shared.delegate as? AppDelegate)? .persistentContainer.viewContext
    
    func addData(object : [String:String]){
        let user = NSEntityDescription.insertNewObject(forEntityName: "User", into: context!) as! User
        user.username = object["username"]
        user.password = object["password"]
        user.score = 0.0
        user.qtaken = 0
        user.taken = false
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
    
    func addScore(quiz : String, name : String, score : Double){
        let scores = NSEntityDescription.insertNewObject(forEntityName: "ScoreHolder", into: context!) as! ScoreHolder
        scores.user = name
        scores.quiz = quiz
        scores.score = score

        do{
            try context?.save()
        }
        catch{
            print("data not saved")
        }
    }
    
    func updateScore(quiz : String, name : String, score : Double){
        var st = ScoreHolder()
        var fetchReq = NSFetchRequest<NSManagedObject>.init(entityName: "ScoreHolder")
        print("Fetched")
        fetchReq.predicate = NSPredicate(format: "quiz == %@", quiz)
        fetchReq.predicate = NSPredicate(format: "user == %@", name)
        print("Predicated")
        
        do{
            let stu = try context?.fetch(fetchReq)
            st = stu?.first as! ScoreHolder
            st.score = score
            try context?.save()
            print("Updated Questions For Quiz")
        }
        catch{
            print("Error")
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
    
    
    func addQuiz(name: String, questions : Double){
        let quiz = NSEntityDescription.insertNewObject(forEntityName: "Quiz", into: context!) as! Quiz
        quiz.name = name
        quiz.questions = questions
        do{
            try context?.save()
            print("Data Saved for Quiz")
            
        }
        catch{
            print("data not saved")
        }
        
    }
    
    func updateQuiz(quiz : String, question : Question){
        
        var st = Quiz()
        print("st made")
        var fetchReq = NSFetchRequest<NSManagedObject>.init(entityName: "Quiz")
        print("Fetched")
        fetchReq.predicate = NSPredicate(format: "name == %@", quiz)
        print("Predicated")
        
        do{
            let stu = try context?.fetch(fetchReq)
            st = stu?.first as! Quiz
            print("It shall try to make relationship")
            st.addToZtoq(question)
            try context?.save()
            print("Updated Questions For Quiz")
        }
        catch{
            print("Error")
        }
        
    }
    
    
    func getOneQuiz(quiz : String) -> Quiz{
        
        var st = Quiz()
        var fetchReq = NSFetchRequest<NSManagedObject>.init(entityName: "Quiz")
        fetchReq.predicate = NSPredicate(format: "name == %@", quiz)
        
        do{
            let stu = try context?.fetch(fetchReq)
            st = stu?.first as! Quiz
            
        }
        catch{
            print("Error")
        }
        return st
        
    }
 /*

    func getOneQuiz(quiz : String) -> Quiz{
        
        var st = Quiz()
        var fetchReq = NSFetchRequest<NSManagedObject>.init(entityName: "Quiz")
        fetchReq.predicate = NSPredicate(format: "name == %@", quiz)
        
        do{
            let stu = try context?.fetch(fetchReq) as! [Quiz]
            
            if(stu.count != 0) {
                st = stu.first!
            }
            
        }
        catch{
            print("Error")
        }
        return st
        
    }
 */
    
    static var found = 0
    func getOneUser(user : String) -> User{
        
        var st = User()
        var fetchReq = NSFetchRequest<NSManagedObject>.init(entityName: "User")
        fetchReq.predicate = NSPredicate(format: "username == %@", user)
        fetchReq.fetchLimit = 1
        do{
            let req = try context?.fetch(fetchReq) as! [User]
            
            if(req.count != 0 ) {
                st = req.first!
                
                DBHelper.found = 1
            } else {
                DBHelper.found = 0
            }
        }
        catch{
            print("Error")
        }
        return st
        
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
    
    func updateDataSub(object : String){
        
        var st = User()
        var fetchReq = NSFetchRequest<NSManagedObject>.init(entityName: "User")
        fetchReq.predicate = NSPredicate(format: "username == %@", object)
        
        do{
            let stu = try context?.fetch(fetchReq)
            
            if(stu?.count != 0){
                st = stu?.first as! User
                st.subtype = true
                try context?.save()
                
            }
            
        }
        catch{
            print("Error")
        }
        
    }
    
    func updateBlock(object : String){
        
        var st = User()
        var fetchReq = NSFetchRequest<NSManagedObject>.init(entityName: "User")
        fetchReq.predicate = NSPredicate(format: "username == %@", object)
        
        do{
            let stu = try context?.fetch(fetchReq)
            
            if(stu?.count != 0){
                st = stu?.first as! User
                st.block = true
                try context?.save()
                
            }
            
        }
        catch{
            print("Error")
        }
        
    }
    func updateDataScore(username : String, object : Double){
        print("Here")
        var st = User()
        var fetchReq = NSFetchRequest<NSManagedObject>.init(entityName: "User")
        fetchReq.predicate = NSPredicate(format: "username == %@", username)
        
        do{
            let stu = try context?.fetch(fetchReq)
            
            if(stu?.count != 0){
                print("I should also be here")
                st = stu?.first as! User
                st.score = object
                try context?.save()
                
            }
            
        }
        catch{
            print("Error")
        }
        
    }
    
    func updateQtaken(username : String){
        
        var st = User()
        var fetchReq = NSFetchRequest<NSManagedObject>.init(entityName: "User")
        fetchReq.predicate = NSPredicate(format: "username == %@", username)
        
        do{
            let stu = try context?.fetch(fetchReq)
            
            if(stu?.count != 0){
                st = stu?.first as! User
                st.qtaken = st.qtaken + 1
                try context?.save()
                
            }
            
        }
        catch{
            print("Error")
        }
        
    }
    
    func updateTaken(username : String){
        
        var st = User()
        var fetchReq = NSFetchRequest<NSManagedObject>.init(entityName: "User")
        fetchReq.predicate = NSPredicate(format: "username == %@", username)
        
        do{
            let stu = try context?.fetch(fetchReq)
            
            if(stu?.count != 0){
                st = stu?.first as! User
                st.taken = true
                st.qtaken = st.qtaken + 1
                try context?.save()
                
            }
            
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
    
    static var found2 = 0
    func getScoreData()-> [ScoreHolder]{
        var stu = [ScoreHolder]()
        var fetchReq = NSFetchRequest<NSManagedObject>.init(entityName: "ScoreHolder")

        do{
            stu = try context?.fetch(fetchReq) as!
     [ScoreHolder]
            
            
            
        }
        catch{
            print("cannot fetch the data")
        }
        return stu
    }
    /*
    
    func getScoreDataOne()->ScoreHolder{
        var star = ScoreHolder()
        var st = ScoreHolder()
        var fetchReq = NSFetchRequest<NSManagedObject>.init(entityName: "ScoreHolder")
        //print("Fetched")
        //fetchReq.predicate = NSPredicate(format: "quiz == %@", quiz)
        //fetchReq.predicate = NSPredicate(format: "user == %@", name)
        //print("Predicated")
        
        do{
            
            
            
            let req = try context?.fetch(fetchReq) as! [ScoreHolder]
            if(req.count != 0 ) {
                star = req.first!
                
                DBHelper.found2 = 1
            } else {
                DBHelper.found2 = 0
            }
        }
        catch{
            print("cannot fetch the data")
        }
        return st
        
    }
 */
    /*
     static var found = 0
     func getOneUser(user : String) -> User{
         
         var st = User()
         var fetchReq = NSFetchRequest<NSManagedObject>.init(entityName: "User")
         fetchReq.predicate = NSPredicate(format: "username == %@", user)
         fetchReq.fetchLimit = 1
         do{
             let req = try context?.fetch(fetchReq) as! [User]
             
             if(req.count != 0 ) {
                 st = req.first!
                 
                 DBHelper.found = 1
             } else {
                 DBHelper.found = 0
             }
         }
         catch{
             print("Error")
         }
         return st
         
     }
     */
    
    
    
    func getScoreDataOneGeneral(name : String)->[ScoreHolder]{
        var st = [ScoreHolder]()
        var fetchReq = NSFetchRequest<NSManagedObject>.init(entityName: "ScoreHolder")
        print("Fetched")
        fetchReq.predicate = NSPredicate(format: "user == %@", name)
        print("Predicated")
        
        do{
            
            st = try context?.fetch(fetchReq) as! [ScoreHolder]
        }
        catch{
            print("cannot fetch the data")
        }
        return st
        
    }
    
    func getQuiz()-> [Quiz]{
        var stu = [Quiz]()
        var fetchReq = NSFetchRequest<NSFetchRequestResult>(entityName: "Quiz")
        do{
            stu = try context?.fetch(fetchReq) as!
     [Quiz]
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
        let quizvar = NSFetchRequest<NSFetchRequestResult>(entityName: "Quiz")
        let quizdel = NSBatchDeleteRequest(fetchRequest: quizvar)
        let scorevar = NSFetchRequest<NSFetchRequestResult>(entityName: "ScoreHolder")
        let scoredel = NSBatchDeleteRequest(fetchRequest: scorevar)
        
        do{
            print("Data deleted")
            try context?.execute(del)
            try context?.execute(qdel)
            try context?.execute(quizdel)
            try context?.execute(scoredel)
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
    
    func holdCurrentQuiz(name : String){
        currentQuiz = name
    }
    func getCurrentQuiz() -> String {
        return currentQuiz;
    }
}
