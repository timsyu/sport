//
//  AthleteViewController.swift
//  Athletes
//
//  Created by La Cantouch on 2017/6/18.
//  Copyright © 2017年 ChiaYu. All rights reserved.
//

import UIKit

class AthleteViewController: UIViewController {

    var athleteInfoDic:[String:String]!
    
    @IBOutlet weak var photoImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var birthdayLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var sportLabel: UILabel!
    
    @IBOutlet weak var sportImageView: UIImageView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        sportLabel.text = athleteInfoDic["sport"]!
        nameLabel.text = athleteInfoDic["name"]!
        birthdayLabel.text = athleteInfoDic["birthday"]!
        heightLabel.text = athleteInfoDic["height"]!
        weightLabel.text = athleteInfoDic["weight"]!
        sportImageView.image = UIImage(named: athleteInfoDic["sportImg"]!+".png")
        self.navigationItem.title = athleteInfoDic["name"]!
        
        
        let fileManager = FileManager.default
        let docUrls =
            fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        let docUrl = docUrls.first
        let url = docUrl?.appendingPathComponent("\(athleteInfoDic["name"]!).png")
        
        
        photoImageView.image = UIImage(contentsOfFile: url!.path)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
