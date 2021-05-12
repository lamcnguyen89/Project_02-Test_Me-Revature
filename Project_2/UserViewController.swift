//
//  UserViewController.swift
//  Project_2
//
//  Created by admin on 5/11/21.
//

import UIKit

class UserViewController: UIViewController {

    @IBOutlet weak var user: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        user.text = "Welcome " +  DBHelper.inst.current
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
