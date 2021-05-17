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


