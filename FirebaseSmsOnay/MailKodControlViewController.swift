//
//  MailKodControlViewController.swift
//  FirebaseSmsOnay
//
//  Created by imac2 on 5/23/19.
//  Copyright © 2019 imac2. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class MailKodControlViewController: UIViewController {
    var userıd=0;
    var kodcontrol=0;
    var UserInfoControl=true
    override func viewDidLoad() {
        super.viewDidLoad()
        kodOnayla.buttondesign()

        // Do any additional setup after loading the view.
    }
    

   
    
    
    @IBOutlet var kodControl: UITextField!
    
    @IBAction func kodOnayla(_ sender: Any) {
        UserInfoControl=true
        getKodMailInfo()
        
        if UserInfoControl{
            
            sendKodMail()
            
        }
        
    }
    
    @IBOutlet var lbluyarı: UILabel!
    
    @IBOutlet var kodOnayla: UIButton!
    
    func getKodMailInfo() {
        
        
        
        if (kodControl.text?.count)!>0
        {let kod=kodControl.text
           kodcontrol=Int(kod!)!}
        else{UserInfoControl=false;
            lbluyarı.isHidden=false
            lbluyarı.text="Lütfen E-Posta Adresinize Gelen Kodu Giriniz."
            return}
    }
    
  
    func sendKodMail()
    {
        let usermail = UserDefaults.standard.string(forKey: "usermail")
        print(usermail)
       
let url="http://qrparam.net/User_Credentials/getCode/?User_Email="+usermail!+"&codeForPassword="+String(kodcontrol)
        let correctURL=url.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        print(correctURL)
        Alamofire.request(correctURL!,method: .get).validate().responseJSON{
            response in
            
            switch(response.result){
                
            case .success(let value):
                let json = JSON(value)
                print("jsonveri\(json)")
     
               
                if json["User_ID"].stringValue == "false"
                { print("döngü içi")
                   let alert=UIAlertController(title: "Uyarı", message: "Lütfen doğrulama kodunuzu Kontrol ediniz.", preferredStyle:UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "Tamam", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert,animated:true,completion: nil )
      
                }
                else{
                    print("userıdgönderilen kısım")
                   var userıd=json["User_ID"].intValue
                    print("yeniuserıd\(userıd)")
                    UserDefaults.standard.set(userıd, forKey: "usersifre")
                    let storyboard=UIStoryboard(name: "Main", bundle: nil)
                    let vc = storyboard.instantiateViewController(withIdentifier: "sendpasswordStoryboard") as! SendPasswordViewController
                    self.present(vc,animated: true,completion: nil)
                }
                
                
            case.failure(let error):
                
                print(error)
                let alert=UIAlertController(title: "Uyarı", message: "Bağlantı Hatası Lütfen Daha Sonra Tekrar Deneyiniz.", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Tamam", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert,animated: true,completion: nil)
                
                
                
            }
        }
    }
   
    

}
