//
//  AthleteTableViewController.swift
//  Athletes
//
//  Created by La Cantouch on 2017/6/18.
//  Copyright © 2017年 ChiaYu. All rights reserved.
//

import UIKit

class AthleteTableViewController: UITableViewController {
    
    
    var toChange = false
    
    var Athletes = [[String:String]]()
    
   override func viewDidAppear(_ animated: Bool) { super.viewDidAppear(animated)

        if toChange {
            toChange = false
            let indexPath = IndexPath(row: 0, section: 0)
            self.tableView.insertRows(at: [indexPath], with: .automatic)
            
        }
    }

    func updateFile() {
        let fileManager = FileManager.default
        let docUrls =
            fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        let docUrl = docUrls.first
        let url = docUrl?.appendingPathComponent("Athletes.txt")
        print("url \(url)")
        let result = (Athletes as NSArray).write(to: url!, atomically: true)
        print("result \(result)")
    }
    
    
    func addAthleteNoti(noti:Notification) {
        let dic = noti.userInfo as! [String:String]
        Athletes.insert(dic, at: 0)
        updateFile()
        
        toChange = true
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        
        let fileManager = FileManager.default
        let docUrls =
            fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        let docUrl = docUrls.first
        let url = docUrl?.appendingPathComponent("Athletes.txt")
        let array = NSArray(contentsOf: url!)
        if array != nil {
            Athletes = array as! [[String:String]]
        }
        
        
        let notiName = Notification.Name("addAthlete")
        NotificationCenter.default.addObserver(self, selector: #selector(AthleteTableViewController.addAthleteNoti(noti:)), name: notiName, object: nil)
        
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return Athletes.count
        
        
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "AthleteCell", for: indexPath) as! AthleteTableViewCell
        let dic = Athletes[indexPath.row]
        
        let fileManager = FileManager.default
        let docUrls =
            fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        let docUrl = docUrls.first
        let url = docUrl?.appendingPathComponent("\(dic["name"]!).png")
        
        
        cell.athleteImageView.image = UIImage(contentsOfFile: url!.path)
        cell.nameLabel.text = dic["name"]

        self.view.endEditing(true)
        
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        Athletes.remove(at: indexPath.row)
        updateFile()
        
        
        self.tableView.deleteRows(at: [indexPath], with: .automatic)
        
        
        
    }

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "sendData" {
            let indexPath = self.tableView.indexPathForSelectedRow
            let dic:[String:String]
            dic = Athletes[indexPath!.row]
            
            
            let controller = segue.destination as! AthleteViewController
            controller.athleteInfoDic = dic
            
        }
        
    }

}
