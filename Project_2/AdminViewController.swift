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
    var quizName = [String]()
    static var selected:Int?
    static var namselected:Int?
    var blockArray = [Bool]()
    let data = DBHelper.inst.getData()
    var data1 = DBHelper.inst.getScoreData()
    
    
    @IBOutlet weak var score2: UILabel!
    @IBOutlet weak var score: UILabel!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadQuizScores()
        
        // Create and Load SideMenu
        menu = SideMenuNavigationController(rootViewController: AdminMenuListController())
        menu?.leftSide = true
        menu?.setNavigationBarHidden(true, animated: false)
        SideMenuManager.default.leftMenuNavigationController = menu
        SideMenuManager.default.addPanGestureToPresent(toView: self.view)
        
    }
    
    // Set Autorotation to false
    override open var shouldAutorotate: Bool {
        return false
    }
    
    // Specify the supported Orientation
    override open var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    @IBAction func didTapMenu() {
        present(menu!, animated: true)
    }
    
    @IBAction func blockUser(_ sender: Any) {
        if AdminViewController.selected != nil && user.isEmpty != true{
            print(AdminViewController.selected)
            blockArray[AdminViewController.selected!] = true
            var users = user[AdminViewController.selected!]
            DBHelper.inst.updateBlock(object: users)
            print(user[AdminViewController.selected!], " blocked!")
        }
    }
        
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        var num = 0
        if pickerView.tag == 1 {
               num = user.count
            } else {
                num = quizName.count
            }
        return num
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        var nam = ""
        if pickerView.tag == 1 {
            nam = user[row]
        } else {
            nam = quizName[row]
        }
        return nam
        
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        var userRow:Int?
        var quizRow:Int?
        score.text = String(0.0)
        if pickerView.tag == 1 {
           
            quizRow = row
            if quizRow != nil{
            AdminViewController.selected = quizRow!
            }
           // score.text = String(scoreArray[row])
            
        } else {
            
            userRow = row
            if userRow != nil{
            AdminViewController.namselected = userRow!
            }
            //score.text = String(scoreArray[row])
            
            
        }

       // print(AdminViewController.selected!, "here")
       // print(AdminViewController.namselected!, "also here")
        if AdminViewController.selected != nil && AdminViewController.namselected != nil{
            
            var hold = DBHelper.inst.getScoreData()
            var high = 0.0
            
            for i in hold{
                if(i.user == user[AdminViewController.selected!] && i.quiz == quizName[AdminViewController.namselected!]){
                    print(i.score)
                            if high < i.score{
                                high = i.score
                                print(high)
                        }
                    
                    }
                
            }
        
        score.text = String(high)
        }
    }
    
    func loadQuizScores() {
        /*
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
 */
        
        for st in data{
            
            //scoreArray2.append(st.score2)
            
            blockArray.append(st.block)
            user.append(st.username!)
        }
        var test = ""
        
        for i in data1{
            if test != i.quiz!{
                test = i.quiz!
                quizName.append(i.quiz!)
                
            }
            
        }
        
    }
    }
    

    



