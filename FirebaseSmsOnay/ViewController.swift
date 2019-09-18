//
//  ViewController.swift
//  FirebaseSmsOnay
//
//  Created by imac2 on 12/21/18.
//  Copyright © 2018 imac2. All rights reserved.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource{
    let phonecode="";
   
    //zorunlu metotlar
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        //kaç tane sütün olduğunu belirtir
        return 1;
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        //kaç tane satır olacağını belirtir.
        return pickerData.count;
    }
    func pickerView(_ pickerView:UIPickerView,titleForRow row:Int, forComponent component:Int) -> String? {
        return pickerData[row]
    }
    func pickerView(_ pickerView:UIPickerView,didSelectRow row:Int, inComponent component:Int) {
       
      
             print("secilen \(phonecode)")
        
        
    }

    
    @IBOutlet weak var pickerview: UIPickerView!
    @IBOutlet weak var phoneNum: UITextField!
    var deneme=5432706047;
   
    
    @IBOutlet var sendCode: UIButton!
    
    
    var pickerData = ["+90","+240"]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //pickerview.delegate = self;
        //pickerview.dataSource = self;
        /*if(UserDefaults.standard.bool(forKey: "islogged")){
            print("islogged")
            let storyboard :UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "HomePage" )
            self.present(vc,animated: true)
            
         
        }*/
       //  self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        sendCode.buttondesign()
    }
  

    @IBAction func sendCode(_ sender: Any) {
        /*if deneme==5432706047{
            let telnumarası = self.phoneNum.text!
            UserDefaults.standard.set(telnumarası, forKey: "telno")
            let  storyboard:UIStoryboard=UIStoryboard(name: "Main", bundle: nil)
            let vc=storyboard.instantiateViewController(withIdentifier: "LoginVc") as! LoginViewController
            self.present(vc, animated: true, completion: nil)
        }*/
        if phoneNum.text!.count > 0 {
        
          
        let alert = UIAlertController(title:"phone number", message:"Telefon Numaranızı Doğru Girdinizmi \n \(phoneNum.text!)",preferredStyle: .alert)
        let action = UIAlertAction(title: "Evet", style: .default) {
            (UIAlertAction) in
            PhoneAuthProvider.provider().verifyPhoneNumber(self.phoneNum.text!, uiDelegate: nil) {(verificationID, error) in
            
               
                
                if error != nil {
                    print("error: \(String(describing: error?.localizedDescription))")
                 
                }else {
                    let defaults = UserDefaults.standard
                    defaults.set(verificationID, forKey: "authVID")
                    self.performSegue(withIdentifier: "code", sender: Any?.self)
                }
                    
                
            }
              //UserDefaults.standard.set(self.phoneNum.text!, forKey: "telno")
            //UserDefaults.standard.set(self.phoneNum.text!, forKey: "telno")
            let telnumarası = self.phoneNum.text!
            UserDefaults.standard.set(telnumarası, forKey: "telno")
          
            
            let telll = UserDefaults.standard.object(forKey: "telno")
            print("object  \(telll)")
           // let tel = UserDefaults.standard.integer(forKey: "telno")
          //  print("ınteger  \(tel)")
          //  let tell = UserDefaults.standard.double(forKey: "telno")
          //  print("double  \(tell)")
        }
        
        let cancel = UIAlertAction(title:"No", style: .cancel, handler: nil)
        alert.addAction(action)
        alert.addAction(cancel)
        
        self.present(alert, animated: true, completion: nil)
     
    
            
            
           
        }
            
            
            
            else{
            let alert=UIAlertController(title: "Uyarı", message: "Lütfen Telefon Numaranızı Giriniz", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Tamam", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert,animated: true,completion: nil)
        }
        
        
    }
   
    
}
