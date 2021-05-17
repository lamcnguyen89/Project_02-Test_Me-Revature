//
//  SubViewController.swift
//  Project_2
//
//  Created by admin on 5/14/21.
//

import UIKit
import SideMenu

class SubViewController: UIViewController {

    var menu: SideMenuNavigationController?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Create Side Menu
        menu = SideMenuNavigationController(rootViewController: MenuListController())
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
    
    @IBAction func subscribeToPremium(_ sender: Any) {
        var sb = UIStoryboard(name: "Main", bundle: nil)
        var wel = sb.instantiateViewController(withIdentifier: "CreditCard") as! CreditCardViewController
        self.present(wel, animated: true, completion: nil)
        
    }
    

}
