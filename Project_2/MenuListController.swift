//
//  MenuListController.swift
//  Project_2
//
//  Created by Lam Nguyen on 5/15/21.
//

import UIKit
import SideMenu

public class MenuListController: UITableViewController {
    
    var items = ["Logout",
                 "Choose Quiz",
                 "Rankings"
                 ]
    
    let darkColor = UIColor(red: 33/255.0, green: 33/255.0, blue: 33/255.0, alpha: 1)
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = darkColor
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = items[indexPath.row]
        cell.textLabel?.textColor = UIColor(red: 41/255 , green: 255/255 ,blue: 173/255 , alpha: 1.0)
        cell.backgroundColor = darkColor
        cell.textLabel?.adjustsFontSizeToFitWidth = true
        cell.textLabel?.font = UIFont.systemFont(ofSize: 25.0, weight: .semibold)
        
        return cell
    }
    
    public override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Determine what to do when a cell in a particular section is selected.
        switch indexPath.row {
        
        case 0:
            // Logout
            if  LoginViewController.login == true{
                LoginViewController.loginManager.logOut()
                
                print("User logout succesfully")
                let sb : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let wel = sb.instantiateViewController(withIdentifier: "Login") as! LoginViewController
                self.dismiss(animated: true) {
                () -> Void in
            // Perform Segue or push some view with your code
                UIApplication.shared.keyWindow?.rootViewController = wel
                }
                
                
            }
                else{
                let sb : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let wel = sb.instantiateViewController(withIdentifier: "Login") as! LoginViewController
                self.dismiss(animated: true) {
                () -> Void in
            // Perform Segue or push some view with your code
                UIApplication.shared.keyWindow?.rootViewController = wel
            }
            }
        case 1:
            // Choose Quiz
            let sb : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let wel = sb.instantiateViewController(withIdentifier: "UserViewController") as! UserViewController
            self.dismiss(animated: true) {
                () -> Void in
            // Perform Segue or push some view with your code
                UIApplication.shared.keyWindow?.rootViewController = wel
            }
        case 2:
            // Rankings
            let sb : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let wel = sb.instantiateViewController(withIdentifier: "UserSideRanking") as! UserSideRankingViewController
            self.dismiss(animated: true) {
                () -> Void in
            // Perform Segue or push some view with your code
                UIApplication.shared.keyWindow?.rootViewController = wel
            }
            
        default:
            print("TableView Cell was clicked")
            
        }
    }
    
}
