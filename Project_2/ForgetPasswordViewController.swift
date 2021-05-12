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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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