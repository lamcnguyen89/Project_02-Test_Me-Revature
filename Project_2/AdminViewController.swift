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
        score.text = String(scoreArray[row])
        score2.text = String(scoreArray2[row])
        print(user[row])
       
    }
 
 
    
    @IBOutlet weak var score2: UILabel!
    
    @IBOutlet weak var score: UILabel!
    
   
    
    
    @IBAction func blockUser(_ sender: Any) {
        blockArray[AdminViewController.selected] = true
        print(user[AdminViewController.selected], " blocked!")
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var data1 = DBHelper.inst.getScoreData()
         
         for i in data1 {
            scoreArray.append(i.score)
            
             
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
