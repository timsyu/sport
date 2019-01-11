//
//  ImagesViewController.swift
//  Athletes
//
//  Created by La Cantouch on 2017/6/18.
//  Copyright © 2017年 ChiaYu. All rights reserved.
//

import UIKit

class ImagesViewController: UIViewController, UIScrollViewDelegate {
    
    var timerTest : Timer?
    var Athletes = [[String:String]]()
    var nowNum = 0

    @IBOutlet weak var bigImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
       // imagePageControl.addTarget(self, action: #selector(ImagesViewController.pageChanged), for: .valueChanged)
       
    }
    
    
    func getImage(){
        let fileManager = FileManager.default
        let docUrls =
            fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        let docUrl = docUrls.first
        
        print(nowNum)
        
        let url = docUrl?.appendingPathComponent("\(Athletes[nowNum]["name"]!).png")
        bigImageView.image = UIImage(contentsOfFile: url!.path)
        nowNum += 1
        
        if nowNum == Athletes.count{
            nowNum = 0
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewDidAppear(_ animated: Bool){
        super.viewDidAppear(animated)
        
        let fileManager = FileManager.default
        let docUrls =
            fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        let docUrl = docUrls.first
        let url = docUrl?.appendingPathComponent("Athletes.txt")
        let urls = docUrls[0] as URL
        print(urls)
        
        let array = NSArray(contentsOf: url!)
        if array != nil {
            Athletes = array as! [[String:String]]
        }
        if Athletes.count != 0 {
            nowNum = 0
            print(Athletes.count)
            getImage()
            timerTest = Timer.scheduledTimer(timeInterval: 2,
                                             target: self,
                                             selector: #selector(self.getImage),
                                             userInfo: nil,
                                             repeats: true)
        }else {bigImageView.image = nil}

    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        timerTest?.invalidate()
    }
}
