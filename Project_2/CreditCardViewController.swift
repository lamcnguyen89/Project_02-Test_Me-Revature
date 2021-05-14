
//
//  ViewController.swift
//  CreditCardView
//
//  Created by Lam Nguyen on 5/14/21.
//

import UIKit

class CreditCardViewController: UIViewController {
    
  
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
        // Do any additional setup after loading the view.
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
            
           // let sb : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            //let wel = sb.instantiateViewController(withIdentifier: "Administrator") as! AdministratorViewController
            //self.present(wel, animated: true, completion: nil)
            
        } else {
            let alert = UIAlertController(title: "Payment Error", message: "You need to enter the required payment info.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
            NSLog("The \"OK\" alert occured.")
            }))
            self.present(alert, animated: true, completion: nil)
        }
        
        
    }
    
}
