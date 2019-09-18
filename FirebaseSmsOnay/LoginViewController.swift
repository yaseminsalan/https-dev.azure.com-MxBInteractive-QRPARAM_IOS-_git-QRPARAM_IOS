//
//  LoginViewController.swift
//  qrpay
//
//  Created by imac1 on 19.12.2018.
//  Copyright © 2018 imac1. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import MessageUI



class LoginViewController: UIViewController {
    

 
    
    
    
    var emailcontrol=false
    var passwordcontrol=false
    var switchon=0;
    var deviceId="";
        var switchoff=0;
    @IBAction func tf_email(_ sender: Any) {
        
        if (tf_username.text?.count)!>0{
            emailcontrol=true
        }
        else{
            emailcontrol=false
        }
    }
    
    
   
    @IBOutlet var stateSwitch: UISwitch!
    @IBAction func benihatırla(_ sender: UISwitch) {
        
        if stateSwitch.isOn==true
        {
            switchon=1
            UserDefaults.standard.set(switchon, forKey: "swichoncntl")
            
            print(switchon)
        }
        else{
            switchoff=2
            UserDefaults.standard.set("", forKey: "swichoncntl")
            print(switchoff)
        }
        
    }
    
    @IBAction func tf_passwordaction(_ sender: Any) {
        if (tf_password.text?.count)!>=5{
            passwordcontrol=true
        }
        else{
            passwordcontrol=false
        }
    }
    @IBOutlet weak var btn_sign: UIButton!
    @IBOutlet weak var tf_username: UITextField!
    @IBOutlet weak var label_mistake: UILabel!
    @IBOutlet weak var tf_password: UITextField!
    var user:User_Credentials = User_Credentials()
    var value2:String=""
    @IBAction func btn_login(_ sender: Any) {
        
        label_mistake.isHidden=true
        if logincontrol(){
       login()
           
        }
        
    }
    func passwordvc(){
        let storyboard :UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ForgotpasswordStoryboard") as! ForgotPasswordViewController
        self.present(vc, animated: true, completion: nil)
    }
    @IBOutlet var forgotpassword: UIButton!
    @IBAction func forgotpassword(_ sender: Any) {
        let storyboard :UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "ForgotpasswordStoryboard") as! ForgotPasswordViewController
        self.present(vc, animated: true, completion: nil)
    }
    override func viewDidLoad() {
       
        
       deviceId = UIDevice.current.identifierForVendor!.uuidString
    
        let swichondurum = UserDefaults.standard.integer(forKey: "swichoncntl")
        print("kontrol \(swichondurum)")
         let swichofdurum = UserDefaults.standard.integer(forKey: "swichoncntl")
        let textmail = UserDefaults.standard.string(forKey: "usermail")
        print(textmail)
        if swichondurum==1{
            
            tf_username.text=textmail
            stateSwitch.isOn=true;
            
            print("sonuçbir")
        }else if swichofdurum==2{
            
            print("textmail \(textmail)")
            stateSwitch.isOn=false;
            tf_username.text=""
            print("sonuçbir değil")
        }
        stateSwitch.addTarget(self, action: #selector(benihatırla), for: .valueChanged)
        btn_sign.buttondesign()
        forgotpassword.buttondesign()
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: false)

user.Password="aaaa"
     
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    func logincontrol()->Bool{
        
        if(tf_username.text?.count)!>0{
            if(tf_password.text?.count)!>=5{
                return true
            }
            else{
                label_mistake.text="Kullanıcı adı veya şifre hatalı"
                label_mistake.isHidden=false
                return false
            }
            
        }
        else{
            label_mistake.isHidden=false
            label_mistake.text="Kullanıcı adı veya şifre hatalı"
            return false
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    
    
    
 
    func login()  {
        
        
        
        
        
        
        
        
        
        let session = URLSession.shared
        let url = "http://test.qrparam.net/api/Login"
        let request = NSMutableURLRequest(url: NSURL(string: url)! as URL)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
      
        var params :[String: Any]?
        params = ["Email" : "barbarosistif@gmail.com", "Password":"123456","DeviceId":"aass"]
        //params = ["Email" : tf_username.text, "Password":tf_password.text,"DeviceId":deviceId]
        do{
            request.httpBody = try JSONSerialization.data(withJSONObject: params, options: JSONSerialization.WritingOptions())
            let task = session.dataTask(with: request as URLRequest as URLRequest, completionHandler: {(data, response, error) in
                if let response = response {
                    let nsHTTPResponse = response as! HTTPURLResponse
                    let statusCode = nsHTTPResponse.statusCode
                    print ("status code = \(statusCode)")
                }
                if let error = error {
                    print ("\(error)")
                }
                if let data = data {
                    do{
                        
                        if let json = try JSONSerialization.jsonObject(with: data) as? [String: String] {
                            DispatchQueue.main.async {
                       
                            
                            let userlogin = User_Login()
                        
                            print("data\(json["status"])")
                            
                             
                            
                            
                           if json["status"] == "OK" {
                                print("print false içine girdi")
                                let storyboard :UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                                let vc = storyboard.instantiateViewController(withIdentifier: "HomePage") as! HomeViewController
                                self.performSegue(withIdentifier: "HomePageSegue", sender: self)
                           }    else if json["status"] == "ERROR"
                           {
                             if json["data"]=="1"{
                                let alert = UIAlertController(title:"Hata", message:"Kullanıcı Adı veya Şifre Yalnış. Lütfen Bilgileriniz Kontrol Ediniz",preferredStyle: .alert)
                                let action = UIAlertAction(title: "Tamam", style: .default)
                                alert.addAction(action)
                                self.present(alert,animated: true,completion: nil)
                                
                                self.label_mistake.text="Kullanıcı adı veya şifre hatalı"
                                self.label_mistake.isHidden=false
                                
                            }
                            else if json["data"]=="2"{
                                print("print true içine girdi")
                                
                                let alert = UIAlertController(title:"Bilgi", message:"Bu Kulllanıcı Adı ve Şifre Bilgileri Başka cihaz adına kayıtlıdır.",preferredStyle: .alert)
                                let action = UIAlertAction(title: "Tamam", style: .default)
                                alert.addAction(action)
                                self.present(alert,animated: true,completion: nil)
                            }
                            else if json["data"]=="3"{
                                let alert = UIAlertController(title: "Bilgi", message: "Şifre Değiştirme İşleminiz Üzerinden Uzun Bir Süre geçti güvenliğiniz için Şifre Değiştirme Sayfasına Yönlendiriliyorsunuz..", preferredStyle: UIAlertController.Style.alert)
                                alert.addAction(UIAlertAction(title: "Tamam", style: UIAlertAction.Style.default,  handler: {action in self.passwordvc()}))
                                self.present(alert, animated: true, completion: nil)
                            }
                                
                            else if json["data"]=="4"{
                                let alert = UIAlertController(title:"Hata", message:"Mail Aktivasyonunuzu Gerçekleştirmeniz Gerekiyor",preferredStyle: .alert)
                                let action = UIAlertAction(title: "Tamam", style: .default)
                                alert.addAction(action)
                                self.present(alert,animated: true,completion: nil)
                                
                            }
                            else if json["data"]=="404"{
                                let alert=UIAlertController(title: "Bağlantı Hatası", message: "Şuan Bağlantı Sağlanamıyor Lütfen İnternet Bağlantınızı Kontrol Ediniz", preferredStyle:UIAlertController.Style.alert)
                                let action=UIAlertAction(title: "Tamam", style: .default, handler: nil)
                                alert.addAction(action)
                                self.present(alert,animated:true,completion: nil )}
                            
                            
                                }
                           else{
                            print("bilinmeyen hata")
                                }
                                
                            }
                        
                        
                        
                          
                        }
                        
                    }catch _ {
                        print ("jsondan dönen yanıtta sorun var")
                    }
                }
            })
            task.resume()
        }catch _ {
            print ("sorun oluştu")
        }
   
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
        if(segue.identifier == "HomePageSegue"){
             guard let homvc = segue.destination as? HomeViewController else{return}
           //  homvc.value=self.value2
            print("segue")
           
             homvc.user=self.user
        }
    
        
        
    }

}

extension UIButton{
    
    func buttondesign(){
        
        self.layer.cornerRadius=10
        self.backgroundColor=UIColor(red: 144/255, green: 116/255, blue: 255/255, alpha: 1)
        self.layer.borderColor=UIColor.purple.withAlphaComponent(0.8).cgColor
        self.layer.borderWidth=2
        self.layer.shadowColor=UIColor.purple.cgColor
        self.layer.shadowRadius=4
        self.layer.shadowOffset=CGSize(width: 0, height: 0)
        self.layer.shadowOpacity=0.8
    }
    
    
    
    
    
    

   
    
}





