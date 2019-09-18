//
//  ForgotPasswordViewController.swift
//  FirebaseSmsOnay
//
//  Created by imac2 on 5/23/19.
//  Copyright © 2019 imac2. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ForgotPasswordViewController: UIViewController {

    var mailgonder="";
      var UserInfoControl=true
    let user=User_Credentials()

    @IBOutlet var Lbluyarı: UILabel!
    
    @IBOutlet var textmail: UITextField!
    @IBOutlet var forgotpassword: UIButton!
    @IBAction func forgotpassword(_ sender: Any) {
              Lbluyarı.isHidden=true
        UserInfoControl=true
          getMailInfo()
        
        if UserInfoControl{
            
           sendMail(user: user)
             //print("mail\(user.Email)")
        }
       
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    override func viewDidLoad() {
        super.viewDidLoad()
        forgotpassword.buttondesign()
 
      
        
    }
    func saveVc(){
     
            let storyboard=UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "MailkodStoryboard") as! MailKodControlViewController
            self.present(vc,animated: true,completion: nil)
        }
    func  getMailInfo(){
    if  (textmail.text?.count)!>0{
    let mail=textmail.text
    
    // validate an email for the right format
    func isValidEmail(mail:String) -> Bool {
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    
    let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    return emailTest.evaluate(with: mail)
    }
    if  isValidEmail(mail:mail!){
    user.Email=mail!
    print("dogru")
    print(user.Email)
    
    }else{UserInfoControl=false;
    
    Lbluyarı.isHidden=false
    Lbluyarı.text="mail formatında giriniz"
    return
    }
    }else{
    UserInfoControl=false;
    Lbluyarı.isHidden=false
    Lbluyarı.text="mail Boş bırakılamaz"
    return
        }}

    func sendMail(user:User_Credentials)
    {
        print("girdiiçrii")
        let url="http://qrparam.net/User_Credentials/forgetPassword/?User_Email="+user.Email
        let correctURL=url.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        Alamofire.request(correctURL!,method: .get).validate().responseJSON{
            response in
            
            switch(response.result){
                
            case .success(let value):
                let json = JSON(value)
                print("jsonveri\(json)")
                print(correctURL)
                      print("Başarılı")
                if json["info"] == "true"
                {
                     UserDefaults.standard.set(user.User_Email, forKey: "usermail")
                 
                    let alert = UIAlertController(title: "Başarılı", message: "Adresinize Doğrulama Kodu Gönderilmiştir.", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "Tamam", style: UIAlertAction.Style.default,  handler: {action in self.saveVc()}))
                   
                    
                    self.present(alert, animated: true, completion: nil)
                }else
                {
                    let alert = UIAlertController(title: "Bağlantı hatası", message: "", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "Tamam", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
                
                
          
                
            case .failure(let error):
                
                print(error)
                
                
            }
        }
    }
    
   
        
        
        
        
    }

