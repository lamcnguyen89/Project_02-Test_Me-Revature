//
//  LoginViewController.swift
//  Project_2
//
//  Created by admin on 5/10/21.
//

import UIKit
import FBSDKLoginKit


class LoginViewController: UIViewController {

    static let loginManager: LoginManager = LoginManager()
    
    static var login = false
    
    @IBOutlet weak var msg: UILabel!
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var pass: UITextField!
    @IBOutlet weak var diff: UISwitch!
    
    let ud = UserDefaults.standard
    static var state = false
    
    let data =  DBHelper.inst.getDataQuestions()
    
    
    
    struct GlobalVariable{
        static var userDict:[String:String] = [:]
        static var adminDict:[String:String] = ["admin":"admin"]
        static var us:String = ""
        static var p:String = ""
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        LoginViewController.state = ud.bool(forKey: "state")
        diff.setOn(LoginViewController.state, animated: true)
        if(diff.isOn == true){
            setIDP()
            
        }
        
        // Put code here to autogenerate quiz
        let admin = AdminMenuListController()
        admin.generateQuiz()
        
    }
    
    // Set Autorotation to false
    override open var shouldAutorotate: Bool {
        return false
    }
    
    // Specify the supported Orientation
    override open var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    @IBAction func loginFb(_ sender: Any) {
        
        if AccessToken.current == nil {
                   //Session is not active
                   
            LoginViewController.loginManager.logIn(permissions: ["public_profile","email"], from: self, handler: { result,error   in
                if error != nil {
               
                } else if result!.isCancelled {
              print("login cancelled by user")
                } else {
                    LoginViewController.login = true
                    print("login successfully")
                    let token = result?.token?.tokenString
                           let req = FBSDKLoginKit.GraphRequest(graphPath: "me", parameters: ["fields":"email,name"], tokenString: token, version: nil, httpMethod: .get)
                           req.start {(connection,result,error)
                               in
                            print(result!)
                           }
                    
                    let redir = UIStoryboard(name:"Main", bundle:nil).instantiateViewController(withIdentifier: "UserViewController")
                    self.present(redir, animated:true, completion: nil)
                }
            })
            
               } else {
                print("already logged in")
                let redir = UIStoryboard(name:"Main", bundle:nil).instantiateViewController(withIdentifier: "UserViewController")
                self.present(redir, animated:true, completion: nil)
               
               }
    }
    @IBAction func signUp(_ sender: Any) {
        let sb : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let wel = sb.instantiateViewController(withIdentifier: "signUp") as! SignUpViewController
        self.present(wel, animated: true, completion: nil)
    }
 
    
    
    @IBAction func resetPassword(_ sender: Any) {
        let sb : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let wel = sb.instantiateViewController(withIdentifier: "Reset") as! ForgetPasswordViewController
        self.present(wel, animated: true, completion: nil)
        
    }
 
    
    @IBAction func login(_ sender: Any) {
        let data = DBHelper.inst.getData()
        for st in data{
            LoginViewController.GlobalVariable.userDict[st.username!] = st.password
        }
        
        let user = DBHelper.inst.getOneUser(user: userName.text!)
        
        if(userName.text == "admin" && pass.text == "admin") {
            let redir = UIStoryboard(name:"Main", bundle:nil).instantiateViewController(withIdentifier: "AdminViewController")
            present(redir, animated:true, completion: nil)
        }
        
        
        if DBHelper.found == 1 {
            
            for (i,v) in LoginViewController.GlobalVariable.userDict{
                
                    if(userName.text! == i && pass.text! == v && user.block == false){
                            LoginViewController.GlobalVariable.us = userName.text!
                            LoginViewController.GlobalVariable.p = pass.text!
                            DBHelper.inst.holdCurrentUser(name: userName.text!)
                            let redir = UIStoryboard(name:"Main", bundle:nil).instantiateViewController(withIdentifier: "UserViewController")
                            present(redir, animated:true, completion: nil)
                        
                    }
                    else{
                        
                        if user.block == true{
                            msg.text = "User is blocked, please contact an admin"
                        }
                        else{
                            msg.text = "Wrong User ID or Password"
                        }
                    }
            }
        } else {
            
            msg.text = "Please enter a valid username"
            
        }
        
      
    }
    
    
    @IBAction func save(_ sender: Any) {
        if(diff.isOn == true){
            if(userName.text != nil && pass.text != nil){
                ud.set(userName.text!, forKey: "id")
                ud.set(pass.text!, forKey: "p")
                print("Data Saved", userName.text!, pass.text!)
            }
            else{
                userName.text = ud.string(forKey:"id")
                pass.text = ud.string(forKey: "p")
                print("Data Displayed")
            }
        }
        else{
            ud.removeObject(forKey: "id")
            ud.removeObject(forKey: "p")
            userName.text = nil
            pass.text = nil
            print("Data Removed")
        }
        
        if(diff.isOn){
            LoginViewController.state = true
        }
        else{
            LoginViewController.state =  false
        }
        ud.set(LoginViewController.state, forKey: "state")

        
    }
    
    func setIDP(){
        userName.text = ud.string(forKey:"id")
        pass.text = ud.string(forKey: "p")
        print("Data Displayed",userName.text!, pass.text!)    }
}
