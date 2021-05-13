//
//  UserViewController.swift
//  Project_2
//
//  Created by admin on 5/11/21.
//

import UIKit

class UserViewController: UIViewController,  UIPickerViewDelegate, UIPickerViewDataSource {
    var quizArray = DBHelper.inst.getQuiz()
    var quizNames = [String]()
    
    
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return quizNames.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return quizNames[row]
        
    }
 
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print(quizNames[row])
        DBHelper.inst.holdCurrentQuiz(name : quizNames[row])
       
    }

    @IBOutlet weak var user: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        user.text = "Welcome " +  DBHelper.inst.current
        // Do any additional setup after loading the view.
        
        for st in quizArray{
            quizNames.append(st.name!)
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
