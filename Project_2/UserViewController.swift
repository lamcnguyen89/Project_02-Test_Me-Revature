//
//  UserViewController.swift
//  Project_2
//
//  Created by admin on 5/11/21.
//

import UIKit
import SideMenu


class UserViewController: UIViewController,  UIPickerViewDelegate, UIPickerViewDataSource {
    
    var menu: SideMenuNavigationController?
    var quizArray = DBHelper.inst.getQuiz()
    var quizNames = [String]()
    
    @IBOutlet weak var user: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert]){
            (granted, error) in
            if granted {
                print("yes")
            }
            else{
                print("no", error)
            }
        }
        
        user.text = "Welcome " +  DBHelper.inst.current
        // Do any additional setup after loading the view.
        
        for st in quizArray{
            quizNames.append(st.name!)
        }
        
        DBHelper.inst.holdCurrentQuiz(name: quizNames[0])
        
        // Create Side Menu
        menu = SideMenuNavigationController(rootViewController: MenuListController())
        menu?.leftSide = true
        menu?.setNavigationBarHidden(true, animated: false)
        SideMenuManager.default.leftMenuNavigationController = menu
        SideMenuManager.default.addPanGestureToPresent(toView: self.view)
    }
    
    @IBAction func didTapMenu() {
        present(menu!, animated: true)
    }
    
    @IBAction func quiz(_ sender: Any) {
        var user = DBHelper.inst.getOneUser(user: DBHelper.inst.current)
        print(String(user.qtaken))
        print(user.subtype)
        if user.subtype == false && user.qtaken > 2.0{
            var sb = UIStoryboard(name: "Main", bundle: nil)
            var wel = sb.instantiateViewController(withIdentifier: "Free") as! UIViewController
            self.present(wel, animated: true, completion: nil)
        } else {
            var sb = UIStoryboard(name: "Main", bundle: nil)
            var wel = sb.instantiateViewController(withIdentifier: "Quiz") as! UIViewController
            self.present(wel, animated: true, completion: nil)
            
        }
        
    }
    
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
}


