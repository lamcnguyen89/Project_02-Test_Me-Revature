
//
//  ViewController.swift
//  CreditCardView
//
//  Created by Lam Nguyen on 5/14/21.
//

import UIKit
import SideMenu

class CreditCardViewController: UIViewController {
    
    var menu: SideMenuNavigationController?
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var creditNumber: UITextField!
    @IBOutlet weak var expMonth: UITextField!
    @IBOutlet weak var expYear: UITextField!
    @IBOutlet weak var address: UITextField!
    @IBOutlet weak var address2: UITextField!
    @IBOutlet weak var city: UITextField!
    @IBOutlet weak var state: UITextField!
    @IBOutlet weak var zip: UITextField!
    @IBOutlet weak var phone: UITextField!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    
    
    @IBAction func submitInfo(_ sender: Any) {
        
        if(
            name.text != nil &&
            creditNumber.text != nil &&
            expMonth.text != nil &&
            expYear.text != nil &&
            expYear.text != nil &&
            address.text != nil &&
            city.text != nil &&
            state.text != nil &&
            zip.text != nil &&
            phone.text != nil
        ) {
           print("Card information submitted")
            DBHelper.inst.updateDataSub(object: DBHelper.inst.getCurrentUser())
           let sb : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
           let wel = sb.instantiateViewController(withIdentifier: "UserViewController") as! UserViewController
           self.present(wel, animated: true, completion: nil)
            
        } else {
            let alert = UIAlertController(title: "Payment Error", message: "You need to enter the required payment info.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
            NSLog("The \"OK\" alert occured.")
            }))
            self.present(alert, animated: true, completion: nil)
        }
        
        
    }
    
}
