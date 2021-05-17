//
//  ForgetPasswordViewController.swift
//  Project_2
//
//  Created by admin on 5/12/21.
//

import UIKit

class ForgetPasswordViewController: UIViewController {

    @IBOutlet weak var user: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var password2: UITextField!
    @IBOutlet weak var warning: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // Set Autorotation to false
    override open var shouldAutorotate: Bool {
        return false
    }
    
    // Specify the supported Orientation
    override open var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    
    @IBAction func back(_ sender: Any) {
        
        let sb : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let wel = sb.instantiateViewController(withIdentifier: "Login") as! LoginViewController
        self.present(wel, animated: true, completion: nil)
        
    }
    
    @IBAction func submit(_ sender: Any) {
        var u = user.text!
        var p1 = password.text!
        var p2 = password2.text!
        var uu = ""
        var pp = ""
        var userDict:[String:String] = [:]
        if(u.isEmpty == false && p1.isEmpty == false && p2.isEmpty == false){
            if(password.text! == password2.text!){
                let data = DBHelper.inst.getData()
                for st in data{
                   userDict[st.username!] = st.password
                }
                for (i,v) in userDict{
                            if(i == user.text!){
                                warning.text = "User Matched!"
                                userDict.updateValue(password2.text!, forKey: i)
                                uu = i
                                pp = password2.text!
                                
                                //print(pc.text!, i)
                                   
                                
                                let redir = UIStoryboard(name:"Main", bundle:nil).instantiateViewController(withIdentifier: "Login")
                                present(redir, animated:true, completion: nil)
                                }
                                else{
                                        warning.text = "No Match"
                                }
                    }
                  
            }
            else{
                warning.text = "Passwords Do Not Match"
            }
        }
        else{
            warning.text = "Fields Not Filled"
        }
        if(uu.count > 0 && pp.count > 0){
            let dic = ["username": uu, "password": pp]
            DBHelper.inst.updateData(object: dic as! [String:String])
            
        }
    }


}
