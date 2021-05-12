//
//  SignUpViewController.swift
//  Project_2
//
//  Created by admin on 5/11/21.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var Username: UITextField!
    @IBOutlet weak var Password: UITextField!
    @IBOutlet weak var Password_Again: UITextField!
    
    @IBOutlet weak var warning: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func Save(_ sender: Any) {
        var u : String = Username.text!
        var p : String = Password.text!
        var pp : String = Password_Again.text!
        if(u.isEmpty == false && p.isEmpty == false && pp.isEmpty == false){
            if(p == pp){
                let dic = ["username" : Username.text, "password" : Password.text]
                DBHelper.inst.addData(object: dic as! [String:String])
                var sb = UIStoryboard(name: "Main", bundle: nil)
                var wel = sb.instantiateViewController(withIdentifier: "Login") as! UIViewController
                self.present(wel, animated: true, completion: nil)
            }
            else{
                warning.text = "Passwords did not match, try again"
                warning.backgroundColor = UIColor.white
            }
            
        }
        else{
            warning.text = "Passwords did not match, try again"
            warning.backgroundColor = UIColor.white
            
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
