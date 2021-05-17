//
//  RewardViewController.swift
//  Project_2
//
//  Created by admin on 5/17/21.
//

import UIKit
import SideMenu

class RewardViewController: UIViewController {

    var menu:SideMenuNavigationController?
    @IBOutlet weak var nameCert: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameCert.text = DBHelper.inst.getCurrentUser()

        // Load Side Menu into View
        menu = SideMenuNavigationController(rootViewController: MenuListController())
        menu?.leftSide = true
        menu?.setNavigationBarHidden(true, animated: false)
        SideMenuManager.default.leftMenuNavigationController = menu
        SideMenuManager.default.addPanGestureToPresent(toView: self.view)
        
    }
    
    
    @IBAction func didTapMenu(_ sender: Any) {
        present(menu!, animated: true)
    }
    
    // Set Autorotation to false
    override open var shouldAutorotate: Bool {
        return false
    }
    
    // Specify the supported Orientation
    override open var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    @IBAction func Sub(_ sender: Any) {
        DBHelper.inst.updateDataSub(object: DBHelper.inst.getCurrentUser())
    }
    

}
