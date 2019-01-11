//
//  AddTableViewController.swift
//  Athletes
//
//  Created by La Cantouch on 2017/6/18.
//  Copyright © 2017年 ChiaYu. All rights reserved.
//

import UIKit

class AddTableViewController: UITableViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    

    @IBOutlet weak var selectPhoto: UIButton!
    
    @IBOutlet weak var selectDate: UIDatePicker!
    
    @IBOutlet weak var sportTextField: UITextField!
    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var heightTextField: UITextField!
    
    @IBOutlet weak var weightTextField: UITextField!
    
    
    
    
    @IBAction func getPhoto(_ sender: Any) {
        let controller = UIImagePickerController()
        controller.sourceType = .photoLibrary
        controller.delegate = self
        present(controller, animated: true, completion: nil)
    
    }
    
    @IBOutlet weak var b1Btn: UIButton!
    @IBOutlet weak var b2Btn: UIButton!
    @IBOutlet weak var b5Btn: UIButton!
    @IBOutlet weak var b3Btn: UIButton!
    @IBOutlet weak var b4Btn: UIButton!
    @IBOutlet weak var b6Btn: UIButton!
    @IBOutlet weak var b7Btn: UIButton!
    @IBOutlet weak var b8Btn: UIButton!
    @IBOutlet weak var b9Btn: UIButton!
    @IBOutlet weak var b10Btn: UIButton!
    
    
    
    
    
    var setImage = false
    var sportImg = "nil"
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        // 結束編輯 把鍵盤隱藏起來
        self.view.endEditing(true)
        
        return true
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as? UIImage
        selectPhoto.setBackgroundImage(image, for: .normal)
        selectPhoto.setTitle(nil, for: .normal)
        setImage = true
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func done(_ sender: Any) {
        
        if setImage == false{
            let controller = UIAlertController(title: nil, message: "選擇一張相片", preferredStyle: UIAlertControllerStyle.alert)
            let message  = "請選擇一張相片"
            var messageMutableString = NSMutableAttributedString()
            messageMutableString = NSMutableAttributedString(string: message as String, attributes: [NSFontAttributeName:UIFont(name: "Hannotate TC", size: 18.0)!])
            controller.setValue(messageMutableString, forKey: "attributedMessage")
            
            let action = UIAlertAction(title:"OK",style:UIAlertActionStyle.default,handler:{(action) in})
            controller.addAction(action)
            present(controller,animated:true,completion:nil)
            return
        }
        if sportTextField.text!.characters.count  == 0 || nameTextField.text!.characters.count == 0  || heightTextField.text!.characters.count == 0 || weightTextField.text!.characters.count  == 0 {
            
            let controller = UIAlertController(title: nil, message: "未填寫完成", preferredStyle: .alert)
            let message  = "未填寫完成"
            var messageMutableString2 = NSMutableAttributedString()
            messageMutableString2 = NSMutableAttributedString(string: message as String, attributes: [NSFontAttributeName:UIFont(name: "Hannotate TC", size: 18.0)!])
            controller.setValue(messageMutableString2, forKey: "attributedMessage")
            
            
            let action = UIAlertAction(title: "OK", style: .default, handler: nil)
            controller.addAction(action)
            
            present(controller, animated: true, completion: nil)
            
            return
        }
        
        
        
        let image = selectPhoto.backgroundImage(for: .normal)
        
        
        
        
        let data = UIImagePNGRepresentation(image!)
        
        let fileManager = FileManager.default
        let docUrls =
            fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        let docUrl = docUrls.first
        let url = docUrl?.appendingPathComponent("\(nameTextField.text!).png")
        
        
        try? data?.write(to: url!)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        
        
        let dic = ["sport":sportTextField.text!,
                   "name":nameTextField.text!,
                   "height":heightTextField.text!,
                   "weight":weightTextField.text!,
                   "birthday":dateFormatter.string(from: selectDate.date),
                   "sportImg":sportImg
        ]
        
        
        let notiName = Notification.Name("addAthlete")
        NotificationCenter.default.post(name: notiName, object: nil, userInfo: dic)
        self.navigationController?.popViewController(animated: true)
        
        

    }
    
    @IBAction func b1(_ sender: Any) {
        removeAllSelect()
        b1Btn.alpha = 1
        sportImg = "b1"
    }

    @IBAction func b2(_ sender: Any) {
        removeAllSelect()
        b2Btn.alpha = 1
        sportImg = "b2"
    }
    
    @IBAction func b5(_ sender: Any) {
        removeAllSelect()
        b5Btn.alpha = 1
        sportImg = "b5"
    }

    @IBAction func b3(_ sender: Any) {
        removeAllSelect()
        b3Btn.alpha = 1
        sportImg = "b3"
    }
    
    @IBAction func b4(_ sender: Any) {
        removeAllSelect()
        b4Btn.alpha = 1
        sportImg = "b4"
    }
    
    @IBAction func b6(_ sender: Any) {
        removeAllSelect()
        b6Btn.alpha = 1
        sportImg = "b6"
    }
    
    @IBAction func b7(_ sender: Any) {
        removeAllSelect()
        b7Btn.alpha = 1
        sportImg = "b7"
    }
    
    @IBAction func b8(_ sender: Any) {
        removeAllSelect()
        b8Btn.alpha = 1
        sportImg = "b8"
    }
    
    @IBAction func b9(_ sender: Any) {
        removeAllSelect()
        b9Btn.alpha = 1
        sportImg = "b9"
    }
    
    @IBAction func b10(_ sender: Any) {
        removeAllSelect()
        b10Btn.alpha = 1
        sportImg = "b10"
    }
    
    
    func removeAllSelect(){
        b1Btn.alpha = 0.3
        b2Btn.alpha = 0.3
        b3Btn.alpha = 0.3
        b4Btn.alpha = 0.3
        b5Btn.alpha = 0.3
        b6Btn.alpha = 0.3
        b7Btn.alpha = 0.3
        b8Btn.alpha = 0.3
        b9Btn.alpha = 0.3
        b10Btn.alpha = 0.3
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        removeAllSelect()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func sportTextFieldAction(_ sender: Any) {
        self.view.endEditing(true)
        return
    }
    
    @IBAction func nameTextFieldAction(_ sender: Any) {
        self.view.endEditing(true)
        return
    }

    @IBAction func heightTextFieldAction(_ sender: Any) {
        self.view.endEditing(true)
        return
    }
    
    
    @IBAction func weightTextFieldAction(_ sender: Any) {
        self.view.endEditing(true)
        return
    }
}
