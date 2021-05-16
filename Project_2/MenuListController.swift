//
//  MenuListController.swift
//  Project_2
//
//  Created by Lam Nguyen on 5/15/21.
//

import UIKit
import SideMenu

public class MenuListController: UITableViewController {
    
    var items = ["First","Second","Third","Fourth","Fifth","Sixth"]
    
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
        cell.textLabel?.textColor = .white
        cell.backgroundColor = darkColor
        
        return cell
    }
    
    public override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Determine what to do when a cell in a particular section is selected.
        switch indexPath.row {
        
        case 0:
            // If the cell in the first section is selected, this will trigger the segue with the "First" Identifier
            //self.performSegue(withIdentifier: "First", sender: nil)
            print("First Button was clicked")
            let sb : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let wel = sb.instantiateViewController(withIdentifier: "First") as! FirstViewController
            self.present(wel, animated: true, completion: nil)
        case 1:
            // If the cell in the first section is selected, this will trigger the segue with the "First" Identifier
           // self.performSegue(withIdentifier: "Second", sender: nil)
            print("Second Button was clicked")
        case 2:
            print("Third Button was clicked")
        case 3:
            print("Fourth Button was clicked")
        case 4:
            print("Fifth Button was clicked")
        case 5:
            print("Sixth Button was clicked")
        default:
            print("TableView Cell was clicked")
        }
    }
    
}
