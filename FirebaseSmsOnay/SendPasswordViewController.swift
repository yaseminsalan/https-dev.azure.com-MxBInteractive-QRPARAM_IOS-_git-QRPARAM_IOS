//
//  SendPasswordViewController.swift
//  FirebaseSmsOnay
//
//  Created by imac2 on 5/23/19.
//  Copyright © 2019 imac2. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class SendPasswordViewController: UIViewController {
   var user1=0;
   var sifrecontrol=0;
    var newsifrecontrol=0;
     var UserInfoControl=true
    override func viewDidLoad() {
        super.viewDidLoad()
        newpassword.buttondesign()

        // Do any additional setup after loading the view.
    }
    
    @IBOutlet var sifreuyarı: UILabel!
    
    @IBOutlet var firstpassword: UITextField!
    
    @IBOutlet var nextpasswoord: UITextField!
    
    
    @IBOutlet var newpassword: UIButton!
    @IBAction func newpassword(_ sender: Any) {
        UserInfoControl=true
        getKodMailInfo()
        
        if UserInfoControl{
            
            sendNewSifre()
            
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
    
    func getKodMailInfo() {
        
        
        
        if (firstpassword.text?.count)!>0
        {let kod=firstpassword.text
            sifrecontrol=Int(kod!)!}
        else{UserInfoControl=false;
            sifreuyarı.isHidden=false
            sifreuyarı.text="Lütfen Şifrenizi Boş Bırakmayınız."
            return}
        
        if (nextpasswoord.text?.count)!>0
        {let sifre=nextpasswoord.text
            newsifrecontrol=Int(sifre!)!}
        else{UserInfoControl=false;
            sifreuyarı.isHidden=false
            sifreuyarı.text="Lütfen Şifrenizi Boş Bırakmayınız."
            return}
   if newsifrecontrol==sifrecontrol{
            UserInfoControl=true
        }else{
            UserInfoControl=false
    sifreuyarı.isHidden=false
    sifreuyarı.text="Şifreniz Eşleşmedi."
        }
        
    }
    func saveVc(){
        
        let storyboard=UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "LoginVc") as! LoginViewController
        self.present(vc,animated: true,completion: nil)
    }
    
    func sendNewSifre()
    {
       let usersıfreıd = UserDefaults.standard.string(forKey: "usersifre")
        
        
        let url="http://qrparam.net/User_Credentials/ChangePassword/?User_ID="+usersıfreıd!+"&User_Password="+String(newsifrecontrol)
        let correctURL=url.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        print(correctURL)
        Alamofire.request(correctURL!,method: .get).validate().responseJSON{
            response in
            
            switch(response.result){
                
            case .success(let value):
                let json = JSON(value)
                print("jsonveri\(json)")
                print("Başarılıveri")
                if json["User_Password"] == "true"
                {
                    let alert = UIAlertController(title: "Bilgi", message: "Şifre Değiştirme İşleminiz Başarılı Bir Şekilde Gerçekleşmiştir.", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "Tamam", style: UIAlertAction.Style.default,  handler: {action in self.saveVc()}))
                    
                    
                    self.present(alert, animated: true, completion: nil)
                    
                }
                else
                {
      
                    let alert = UIAlertController(title: "Bağlantı Hatası", message: "İşleminiz Şuan Gerçekleştirilemiyor Lütfen Daha Sonra Tekrar Deneyiniz.", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "Tamam", style: UIAlertAction.Style.default,  handler: {action in self.saveVc()}))
                    
                    
                    self.present(alert, animated: true, completion: nil)
             
                }
                
                
                
            case .failure(let error):
                
                print(error)
                
                
                
            }
        }
    }
    
    
    

}
