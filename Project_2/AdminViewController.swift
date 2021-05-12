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
    var selected = ""
    let data = DBHelper.inst.getData()
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return user.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        print(user[row])
        return user[row]
        
    }
 
    /*
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selected = user[row]
        print(user[row])
    }
 */
 
    

    @IBOutlet weak var score: UILabel!
    
    @IBOutlet weak var quizName: UITextField!
    
    @IBOutlet weak var question: UITextField!
    
    @IBAction func blockUser(_ sender: Any) {
        
    }
    
    @IBAction func nextQuestion(_ sender: Any) {
        
    }
    
    
    @IBAction func saveChanges(_ sender: Any) {
        
        
    }
    
    
    @IBOutlet weak var answer: UITextField!
    
    @IBOutlet weak var numberOfQuestions: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
          for st in data{
              // userDict[st.username!] = st.password
              user.append(st.username!)
          }
        // Do any additional setup after loading the view.
    }
    
    @IBAction func questionsActive(_ sender: Any) {
       var questions = DBHelper.inst.getDataQuestions()
        
        for questions in questions{
            print(questions.questions)
        }
    }
    
    @IBAction func deletetion(_ sender: Any) {
        DBHelper.inst.clearData()
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
