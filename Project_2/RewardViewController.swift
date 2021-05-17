//
//  RewardViewController.swift
//  Project_2
//
//  Created by admin on 5/17/21.
//

import UIKit

class RewardViewController: UIViewController {

    @IBOutlet weak var nameCert: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        nameCert.text = DBHelper.inst.getCurrentUser()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func Sub(_ sender: Any) {
        DBHelper.inst.updateDataSub(object: DBHelper.inst.getCurrentUser())
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
