//
//  SettingsViewController.swift
//  FirebaseSmsOnay
//
//  Created by imac1 on 15.01.2019.
//  Copyright © 2019 imac2. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    var user = User_Credentials()
    @IBOutlet weak var btn_uptadeAddress: UIButton!
    @IBOutlet weak var btn_uptadeinfo: UIButton!
    @IBOutlet weak var btn_register_CreditCard: UIButton!
    
    @IBOutlet weak var SavenewAddress: UIButton!
    
    
    @IBAction func newcreditcard(_ sender: Any) {
       // UserDefaults.standard.set(false, forKey: "backpayment")
        print("btn içi")
        let storyboard :UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "CreditCartListeleStr") as! KrediKartiListeleViewController
        self.present(vc, animated: true, completion: nil)
    }
    
    
    @IBOutlet var newcreditcard: UIButton!
    
    @IBAction func btn_updateAddress(_ sender: Any) {
        self.performSegue(withIdentifier: "Addresslistele", sender: self)
        
    }
    
    @IBAction func btn_register_CreditCard(_ sender: Any) {
       
        UserDefaults.standard.set(false, forKey: "backpayment")
        let storyboard :UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "RegCreditCard") as! SaveCreditCardController
        self.present(vc, animated: true, completion: nil)
    }
    @IBAction func btn_uptadeinfo(_ sender: Any) {
       self.performSegue(withIdentifier: "UpdatePinfo", sender: self)
        
    }
    
    
    @IBAction func SavenewAddress(_ sender: Any) {
       
        let storyboard :UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "SaveAddressStoryboard") as! SaveAddressViewController
        self.present(vc, animated: true, completion: nil)
        
    }
    
    @IBAction func btn_exit(_ sender: Any) {
        
       /* let alert=UIAlertController(title: "Çıkış", message: "Çıkış yapmak istediğinize emin misiniz?", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Evet", style: UIAlertAction.Style.default, handler: {action in self.exitVC()}))
        alert.addAction(UIAlertAction(title: "Hayır", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true,completion: nil)*/
        exitVC()
    }
    func exitVC(){
        
        let storyboard :UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "HomePage") as! HomeViewController
        self.present(vc, animated: true, completion: nil)
        //dismiss(animated: true, completion: nil)
       //self.navigationController?.popViewController(animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        btn_uptadeinfo.buttondesign()
        btn_uptadeAddress.buttondesign()
        btn_register_CreditCard.buttondesign()
        SavenewAddress.buttondesign()
        newcreditcard.buttondesign()
     
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
        if segue.identifier == "UpdatePinfo"{
            guard let vc = segue.destination as? UptadePinfoViewController else {return}
            vc.user = self.user
        }
        else if segue.identifier == "Addresslistele"{
            guard let vc = segue.destination as? AddressListeleViewController else {return}
            vc.userID=user.UserId
        }
       /* else if segue.identifier == "segueRegCard"{
            guard let vc = segue.destination as? SaveCreditCardController else{return}
            vc.userID=user.User_ID
        }*/
        
    }

    
    

}
