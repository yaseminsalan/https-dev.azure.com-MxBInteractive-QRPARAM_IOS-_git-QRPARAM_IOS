//
//  SignUpViewController.swift
//  qrpay
//
//  Created by imac1 on 25.12.2018.
//  Copyright © 2018 imac1. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON


class SignUpViewController: UIViewController,UITextFieldDelegate {

    
    var deviceId="";
    @IBOutlet weak var TF_tc: UITextField!
    @IBOutlet weak var TF_name: UITextField!
    @IBOutlet weak var TF_surname: UITextField!
    @IBOutlet weak var TF_password: UITextField!
    @IBOutlet weak var TF_mail: UITextField!
    @IBOutlet weak var TF_phonenumber: UITextField!
    @IBOutlet weak var TF_gender: UISegmentedControl!
    @IBOutlet weak var TF_birdth: UITextField!
    
    @IBOutlet weak var MailBilgi_lbl: UILabel!
    
   
    @IBOutlet weak var btn_nextlogin: UIButton!
    @IBAction func btn_nextlogin(_ sender: Any) {
        UserDefaults.standard.set(true, forKey: "kayıtlıhesap")
        let storyboard=UIStoryboard(name: "Main", bundle: nil)
     let vc=storyboard.instantiateViewController(withIdentifier: "LoginVc") as! LoginViewController
        self.present(vc,animated: true,completion: nil)
    }
    
    @IBOutlet weak var btn_SignUp: UIButton!
    let user=User_Credentials()
   var UserInfoControl=true
    @IBAction func btn_SignUp(_ sender: Any) {
       
    UserInfoControl=true
      getUserInfo()
        
       if UserInfoControl{
       
         postUserJson(user: user)
        }
        
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        deviceId = UIDevice.current.identifierForVendor!.uuidString
        print("DEVİCE ID\(deviceId)")
       // if UserDefaults.standard.bool(forKey: "kayıtlıhesap"){
            let storyboard :UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "LoginVc") as! LoginViewController
            self.present(vc, animated: true, completion: nil)
      //  }else{
         MailBilgi_lbl.isHidden=true
         btn_SignUp.buttondesign()
          btn_nextlogin.buttondesign()
     
        self.navigationController?.setNavigationBarHidden(true, animated: false)
      
        if(UserDefaults.standard.bool(forKey: "isSignUp")){

            let storyboard :UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
           let vc = storyboard.instantiateViewController(withIdentifier: "HomePage")
            self.present(vc,animated: true)
        }
        // let telno = UserDefaults.standard.object(forKey: "telno")
       // print("telno...\(telno)")
        let telno = UserDefaults.standard.object(forKey: "telno")
    
        TF_phonenumber.text = telno as? String
        
       // let phonenumber=TF_phonenumber.text
       // user.User_Phone_Number=Int(phonenumber!)!
            // print("telno   \(user.User_Phone_Number)")
            
       // }
    }
    func exitVC(){
        dismiss(animated: true, completion: nil)
    }
   /* func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField.tag == 1{
      print("öclx")
        }else if textField.tag == 2{
            UserInfoControl=false;
            MailBilgi_lbl.isHidden=false
            MailBilgi_lbl.text="İsminizi Boş Bırakamayınız"
           
        }else{
          
            UserInfoControl=false;
            MailBilgi_lbl.isHidden=false
            MailBilgi_lbl.text="Soyisminizi Boş Bırakmayınız"
        }
        
        textField.resignFirstResponder()
        return true
    }*/
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func getUserInfo() {
    
       
        
        if (TF_tc.text?.count)!>0
        {let tc=TF_tc.text
            user.Tc=Int(tc!)!}
        else{UserInfoControl=false;
            MailBilgi_lbl.isHidden=false
            MailBilgi_lbl.text="TC Boş Bırakamayınız"
            return}
      
     
        if (TF_name.text?.count)!>0 {
            let name=TF_name.text
            let upperString = name!.uppercased(with: Locale(identifier: "tr"))
            user.Name=upperString
            print(user.Name)
        }
        else{UserInfoControl=false;
            MailBilgi_lbl.isHidden=false
            MailBilgi_lbl.text="İsminizi Boş Bırakamayınız"
            return}
        
        if (TF_surname.text?.count)!>0 {
            let surname=TF_surname.text
            let upperString1 = surname!.uppercased(with:Locale(identifier: "tr"))
            user.Surname=upperString1
            print(user.Surname)
            //  TF_password.becomeFirstResponder()
        }
        else{UserInfoControl=false;
            MailBilgi_lbl.isHidden=false
            MailBilgi_lbl.text="Soyisminizi Boş Bırakmayınız"
            return}
        
        if  (TF_mail.text?.count)!>0{
            let mail=TF_mail.text
            
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
                
                MailBilgi_lbl.isHidden=false
                MailBilgi_lbl.text="mail formatında giriniz"
                 return
            }
        }else{
            UserInfoControl=false;
            MailBilgi_lbl.isHidden=false
            MailBilgi_lbl.text="mail Boş bırakılamaz"
             return
        }
        
        if  (TF_password.text?.count)!>0{
            let password=TF_password.text
            func isValidPassword(password:String?) -> Bool {
                guard password != nil else { return false }
                
                let passwordTest = NSPredicate(format: "SELF MATCHES %@", "(?=.*[A-Z])(?=.*[0-9])(?=.*[a-z]).{8,}")
                return passwordTest.evaluate(with: password)
            }
            if  isValidPassword(password:password){
                user.Password=password!
                print("yeni..\(user.Password)")}
        
            
            else{UserInfoControl=false;
                MailBilgi_lbl.isHidden=false
                MailBilgi_lbl.text="paswordu uygun formatta giriniz"
                return}
            // print("şifre..\(user.User_Password)")
        } else{UserInfoControl=false;
            MailBilgi_lbl.isHidden=false
            MailBilgi_lbl.text="şifre boş bırakılamaz"
            return}
        
      
       if (TF_phonenumber.text?.count)!>0{
            let phonenumber=TF_phonenumber.text
            user.PhoneNumber=Int(phonenumber!)!
           
        }else{
            UserInfoControl=false;
            MailBilgi_lbl.isHidden=false
            MailBilgi_lbl.text="Telefon Numarası Boş Bırakılamaz"
            return
        }
        
        if (TF_birdth.text?.count)!>0
        {let birdth=TF_birdth.text
            user.BirthDate=birdth!}
       else{UserInfoControl=false;
            MailBilgi_lbl.isHidden=false
            MailBilgi_lbl.text="Doğum Tarihini boş Bırakamazsınız"
            return}
      /*  if let gender:Int=TF_gender.selectedSegmentIndex{
            if gender==0
            {
                user.User_Gender="Erkek"
            }
            else{
                user.User_Gender="Kadın"
            }
        }
        else{UserInfoControl=false;
            MailBilgi_lbl.isHidden=false
            MailBilgi_lbl.text="Cinsiyetinizi Seçiniz"
            return}*/
        return
    
    }
   

  
    func postUserJson(user:User_Credentials){
      print(user.Name)
        let url="http://qrparam.net/User_Credentials/Insert/?User_Name="+user.Name+"&User_Surname="+user.Surname
        let url2="&User_Email="+user.Email+"&User_Password="+user.Password
        let url3="&User_Phone_Number="+String(user.PhoneNumber)
        let url4="&User_Gender=belirsiz"+"&User_Birth_Date="+user.BirthDate
        let url5="&User_Credential_Number="+String(user.Tc)+"&Pass1=0"+"&Pass2=1"+"&Device_ID="+deviceId
        
        let totalurl=url+url2+url3+url4+url5
        
     let correctURL = totalurl.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
        print(correctURL)
        Alamofire.request(correctURL!,method: .get).validate(statusCode: 200..<600).responseJSON{
            response in
            
            switch(response.result){
                
            case .success(let value):
                let json=JSON(value)
                print(json)
                if json["cr_error"] == "kimlikhatali"
                {
                    let alert = UIAlertController(title: "Hatalı Bilgi!", message: "Kimlik Bilgilerinizi Kontrol Ediniz", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "Tamam", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }else if json["cr_error"] == "epostakayitli"
                {
                    let alert = UIAlertController(title: "Hatalı Bilgi!", message: " adresi ile daha önce kayıt yapılmıştır.", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "Tamam", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
                else {
                    self.sendConfirmMail()
                    let storyboard=UIStoryboard(name: "Main", bundle: nil)
                    let vc=storyboard.instantiateViewController(withIdentifier: "LoginVc")
                    self.present(vc,animated: true,completion: nil);
                    
                }
                UserDefaults.standard.set("true", forKey: "isSignUp")
            case .failure(let error):
                print(error)
                
                
            }
        }
    
    }
    
    
    func sendConfirmMail()
    {
        let url="http://qrparam.net/User_Credentials/SendConfirmMail/?User_Email="+TF_mail.text!
        let correctURL=url.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        Alamofire.request(correctURL!,method: .get).validate().responseJSON{
            response in

            switch(response.result){
                
            case .success(let value):
                
                print("Başarılı")
                
            case .failure(let error):
                
                print(error)
    
                
            }
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
 
    
    
}
