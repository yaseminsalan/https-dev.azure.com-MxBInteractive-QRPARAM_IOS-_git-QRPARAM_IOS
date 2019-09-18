//
//  HomeViewController.swift
//  FirebaseSmsOnay
//
//  Created by imac2 on 12/26/18.
//  Copyright © 2018 imac2. All rights reserved.
//

import UIKit


class HomeViewController: UIViewController {
    
 
    
    @IBOutlet weak var btn_qrRead: UIButton!
    @IBOutlet weak var btn_orders: UIButton!
    @IBOutlet weak var btn_settings: UIButton!
    @IBOutlet weak var btn_address: UIButton!
    
    @IBOutlet weak var odemeler: UIButton!
    
    @IBAction func odemeler(_ sender: Any) {
        
        let storyboard:UIStoryboard=UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "Odemelerstoryboard") as! OdemelerTableViewController
        self.present(vc, animated: true, completion: nil)
        
    }
    var user=User_Credentials()
    var value:String?
    var degisken=true;
    
    @IBOutlet weak var btn_help: UIButton!
    @IBAction func btn_help(_ sender: Any) {
        let storyboard:UIStoryboard=UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "HelpStoryboard") as! HelpViewController
        self.present(vc, animated: true, completion: nil)
        
    }
    @IBAction func QrOpen(_ sender: Any) {
                
      self.performSegue(withIdentifier: "qrsegue", sender: self)
        
        
    }
    @IBAction func OpenSettings(_ sender: Any) {
       
        self.performSegue(withIdentifier: "settingsegue", sender: self)
    }
    
    @IBAction func btncıkıs(_ sender: Any) {
       
      /*  let storyboard :UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "LoginVc") as! LoginViewController
        self.present(vc, animated: true, completion: nil)*/
    }
    @IBAction func btnSiparisler(_ sender: Any) {
        let storyboard :UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "TableviewCV") as! TableViewController
        self.present(vc, animated: true, completion: nil)
    }
    
    
    
    override func viewDidLoad() {
      
    super.viewDidLoad()
        btn_orders.buttondesign()
        btn_address.buttondesign()
        btn_settings.buttondesign()
        btn_qrRead.buttondesign()
        odemeler.buttondesign()
         let userıd=UserDefaults.standard.string(forKey: "userıd")
        let email=UserDefaults.standard.string(forKey: "email")
        let password=UserDefaults.standard.string(forKey: "password")
        let name=UserDefaults.standard.string(forKey: "name")
        let surname=UserDefaults.standard.string(forKey: "surname")
          let telefon=UserDefaults.standard.string(forKey: "telefon")
          let birtdate=UserDefaults.standard.string(forKey: "birtdate")
        print("password...\(password)")
        print("userıd...\(userıd)")
         print("email...\(email)")
        if userıd == nil && password==nil && email==nil && name==nil && surname==nil && telefon==nil && birtdate==nil{
        UserDefaults.standard.set(user.User_ID, forKey: "userıd")
        UserDefaults.standard.set(user.User_Email, forKey: "email")
        UserDefaults.standard.set(user.User_Password, forKey: "password")
        UserDefaults.standard.set(user.User_Phone_Number, forKey: "telefon")
        UserDefaults.standard.set(user.User_Birth_Date, forKey: "birtdate")
        UserDefaults.standard.set(user.User_Name, forKey: "name")
       UserDefaults.standard.set(user.User_Surname, forKey: "surname")
        }
     
       
    }
 
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if(segue.identifier == "qrsegue"){
            guard let qrvc = segue.destination as? QRViewController else{return}
         //   qrvc.value=self.value2
            print("qrsegue")
           print("homepace ıd \(self.user.User_ID)")
            qrvc.user1=self.user
        }
       /* else if(segue.identifier == "Siparissegue"){
            guard let vc = segue.destination as? TableViewController else{return}
            //   qrvc.value=self.value2
            print("homepace ıd \(self.user.User_ID)")
            vc.user2=self.user
    }*/
        else if (segue.identifier == "settingsegue"){
            
            guard let vc = segue.destination as? SettingsViewController else{return}
           
            vc.user = self.user
    }
    


    
}
   
}








