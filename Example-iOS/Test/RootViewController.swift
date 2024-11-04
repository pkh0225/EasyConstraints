//
//  RootViewController.swift
//  EasyConstraintTest
//
//  Created by 박길호(파트너) - 서비스개발담당App개발팀 on 2022/10/31.
//  Copyright © 2022 pkh. All rights reserved.
//

import UIKit

class RootViewController: UITableViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath) as UITableViewCell
        
        
        switch indexPath.row {
        case 0:
            cell.textLabel?.text = "Constraints Test"
        case 1:
            cell.textLabel?.text = "viewDidAppear Test"
        default:
            cell.textLabel?.text = "none"
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        switch indexPath.row {
        case 0:
            let vc = storyboard.instantiateViewController(withIdentifier: "AutoLayoutController") as! AutoLayoutController
            self.navigationController?.pushViewController(vc, animated: true)
        default:
            break
        }
    }
}
