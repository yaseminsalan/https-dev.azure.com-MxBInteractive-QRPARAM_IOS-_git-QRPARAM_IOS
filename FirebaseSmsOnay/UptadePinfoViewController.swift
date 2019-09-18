//
//  UptadePinfoViewController.swift
//  FirebaseSmsOnay
//
//  Created by imac1 on 15.01.2019.
//  Copyright © 2019 imac2. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class UptadePinfoViewController: UIViewController {

    
    @IBOutlet weak var label_birdhdate: UILabel!
    @IBOutlet weak var label_phone: UILabel!
    @IBOutlet weak var label_email: UILabel!
    @IBOutlet weak var label_surname: UILabel!
    @IBOutlet weak var label_name: UILabel!
    
    @IBOutlet weak var btn_cgangepassword: UIButton!
    var user = User_Credentials()
    // var UserOrderInfoKisilist = [User_Credentials]();
    @IBAction func btn_changepassword(_ sender: Any) {
      
        
        self.performSegue(withIdentifier: "seguepassword", sender: self)
    }
    
    @IBAction func btn_exit(_ sender: Any) {
        /*let alert=UIAlertController(title: "Çıkış", message: "Çıkış Yapmak İstediğinize Emin misiniz?", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Evet", style: UIAlertAction.Style.default, handler: {action in self.exitVC()}))
        alert.addAction(UIAlertAction(title: "Hayır", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true,completion: nil)*/
        UserInfoRequest();
        exitVC()
    }
    func exitVC(){
        let storyboard :UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "SettingsVC") as! SettingsViewController
        self.present(vc, animated: true, completion: nil)
        //navigatıoncontroller olduğu için "dismiss" yerine aşağıdaki kod kullanılır
        //dismiss(animated: true, completion: nil)
      // self.navigationController?.popViewController(animated: true)
    }
    override func viewDidLoad() {
        
        super.viewDidLoad()
          btn_cgangepassword.buttondesign()
         UserInfoRequest()
      
     

        
    }
   /* override func viewWillAppear(_ animated: Bool) {
     super.viewWillAppear(animated)
     //UserorderInfolist.removeAll()
             fillLabel()
     }*/

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    
 
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier=="seguepassword"{
            guard  let vc = segue.destination as? PasswordChangeViewController else {return}
            vc.password=user.Password
            vc.userid=user.UserId
        }
    }
    
    
    func UserInfoRequest()
    {
        //  let email=UserDefaults.standard.string(forKey: "email")
        // let password=UserDefaults.standard.string(forKey: "password")
       // print("kisibilgi..\(password)")
       // let email=UserDefaults.standard.string(forKey: "email")
       // let password=UserDefaults.standard.string(forKey: "password")
        let userıd=UserDefaults.standard.string(forKey: "userıd")
       
        let url="http://qrparam.net/User_Credentials/ListtoID/?User_ID="+userıd!
        print(url)
      
        Alamofire.request(url,method:.get).validate().responseJSON{
            response in
            
            switch response.result{
                
                
            case .success(let value):
                let json=JSON(value)
                print(json)
                print("success")
             
                if json.count>0{
                    self.user = User_Credentials()
                    self.user.Email=json["Email"].stringValue
                    self.user.Tc=json["Tc"].intValue
                    self.user.Gender = json["Gender"].stringValue
                    self.user.PhoneNumber=json["PhoneNumber"].intValue
                    self.user.BirthDate=json["BirthDate"].stringValue
                    self.user.Name = json["Name"].stringValue
                    self.user.Surname = json["Surname"].stringValue
                    self.user.UserId = json["UserId"].intValue
                    self.user.Password =  json["Password"].stringValue
                 
                    
                    
                    print("gelenveriler\(self.user.Name)")
                    self.label_name.text=self.user.Name
                    self.label_surname.text=self.user.Surname
                    self.label_email.text=self.user.Email
                    self.label_phone.text=String(self.user.PhoneNumber)
                    self.label_birdhdate.text=self.user.BirthDate

                    
                    
                }
                
            case .failure(let error):
                print(error)

    

            }
        }
    }
}
