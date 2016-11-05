//
//  TreasureListViewController.swift
//  TreasureHunt
//
//  Created by Tim Colla on 05/11/2016.
//  Copyright © 2016 Marinosoftware. All rights reserved.
//

import UIKit

class TreasureListViewController: UITableViewController {
    let treasureTitles = ["Hackahunt"]
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return treasureTitles.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "treasureCell", for: indexPath) as! TreasureListCell
        cell.treasureTitleLabel.text = treasureTitles[indexPath.row]
        
        return cell
    }
}
