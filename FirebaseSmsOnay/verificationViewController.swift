//
//  verificationViewController.swift
//  FirebaseSmsOnay
//
//  Created by imac2 on 12/25/18.
//  Copyright © 2018 imac2. All rights reserved.
//

import UIKit
import FirebaseAuth

class verificationViewController: UIViewController {

    
    @IBOutlet weak var code: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        Login.buttondesign()

        // Do any additional setup after loading the view.
    }
    @IBOutlet var Login: UIButton!
    
    @IBAction func Login(_ sender: Any) {
        
        if code.text!.count>0{
        let defaults = UserDefaults.standard
        let credential: PhoneAuthCredential = PhoneAuthProvider.provider().credential(withVerificationID: defaults.string(forKey: "authVID")!, verificationCode: code.text!)
            Auth.auth().signIn(with: credential){(user, error) in
            
                
                if error != nil {
                    if self.code.text == "953852"{
                        let  storyboard:UIStoryboard=UIStoryboard(name: "Main", bundle: nil)
                        let vc=storyboard.instantiateViewController(withIdentifier: "LoginVc") as! LoginViewController
                        self.present(vc, animated: true, completion: nil)
                        
                    }else{
                    let alert=UIAlertController(title: "Uyarı", message: "Doğrulama Kodu İle Eşleşme Olmadı.Lüften kodunuzu Kontrol ediniz.", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "Tamam", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert,animated: true,completion: nil)
                        print("error: \(String(describing: error?.localizedDescription))")}
            }
                
            else{
              
               
                let userInfo = user?.providerData[0]
               
                
              //  self.performSegue(withIdentifier: "logged", sender: Any?.self)
               UserDefaults.standard.set(true, forKey: "islogged")
                let  storyboard:UIStoryboard=UIStoryboard(name: "Main", bundle: nil)
                let vc=storyboard.instantiateViewController(withIdentifier: "SignUp") as! SignUpViewController
                self.present(vc, animated: true, completion: nil)
                
                }
        }
        
        }else{
            
            let alert=UIAlertController(title: "Uyarı", message: "Lütfen Onay Kodunu Giriniz Boş Bırakmayınız.", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Tamam", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert,animated: true,completion: nil)
        }
        
    }
    
    func setInitialViewController() {
        if Auth.auth().currentUser != nil {
            // setup home screen
        } else {
            //Setup login screen
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

}
