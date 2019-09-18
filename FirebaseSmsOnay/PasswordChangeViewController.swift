//
//  PasswordChangeViewController.swift
//  FirebaseSmsOnay
//
//  Created by imac1 on 15.01.2019.
//  Copyright © 2019 imac2. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class PasswordChangeViewController: UIViewController {
    
    var password=""
    var userid=0
    @IBOutlet weak var label_error: UILabel!
    
    @IBOutlet weak var btn_change: UIButton!
    @IBAction func btn_change(_ sender: Any) {
        btn_change.buttondesign()
        
        checkCurrentPasssword()
        
    }
    @IBOutlet weak var newpasswordagain: UITextField!
    @IBOutlet weak var newpassword: UITextField!
    @IBOutlet weak var currentpassword: UITextField!
    
    @IBAction func btn_Cıkıs(_ sender: Any) {
       /* let alert = UIAlertController(title: "Çıkış", message: "Çıkış Yapmak İstediğinize Emin misiniz?", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Hayır", style: UIAlertAction.Style.default, handler: nil))
        alert.addAction(UIAlertAction(title: "Evet", style: UIAlertAction.Style.default, handler: {action in self.exitVC()}))
        self.present(alert,animated:true,completion: nil)*/
        exitVC()
    }
    func exitVC(){
        let storyboard :UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "UptadePinfoVC") as! UptadePinfoViewController
        self.present(vc, animated: true, completion: nil)
        //dismiss(animated: true, completion: nil)
        //self.navigationController?.popViewController(animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        btn_change.buttondesign()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
      
    }
    

    func checkCurrentPasssword() {
        let userıd=UserDefaults.standard.string(forKey: "userıd")
        let url = "http://qrparam.net/User_Credentials/PasswordControl/?User_ID="+userıd!+"&User_Password="+password
        let correctURL=url.addingPercentEncoding(withAllowedCharacters:NSCharacterSet.urlQueryAllowed )
        
        Alamofire.request(correctURL!).validate().responseJSON{
            response in
            
            switch(response.result){
                
            case .success(let value):
                let json = JSON(value)
                if json.count>0{
                    if self.newpassword.text==self.newpasswordagain.text{
                        self.sendNewPassRequest(newpassword: self.newpasswordagain.text!)
                    }
                    else{
                        self.label_error.text="Yeni şifre eşleşmedi"
                    }
                }
                else{
                    self.label_error.text="Mevcut Şifre Hatalı"
                }
            case .failure(let error):
                self.label_error.text="Bağlantı Hatası..."
              
                
            }
            
            
        }
        
    }
    
    
    func sendNewPassRequest(newpassword:String){
        let userıd=UserDefaults.standard.string(forKey: "userıd")
        let url = "http://qrparam.net/User_Credentials/ChangePassword/?User_ID="+userıd!+"&User_Password="+newpassword
        
        Alamofire.request(url).validate().responseJSON{
            response in
            
            switch(response.result){
                
            case.success(let value):
                let json=JSON(value)
                
                if(json["User_Password"].stringValue==newpassword){
                    self.turnSettings()
                }
                else {
                    print(json["user_password"].stringValue)
                }
                
            case .failure(let error):
                print(error)
                
        }
        
        
    }

}

    
    func turnSettings()
    {
       navigationController?.popViewController(animated: true)
        
    }


}



