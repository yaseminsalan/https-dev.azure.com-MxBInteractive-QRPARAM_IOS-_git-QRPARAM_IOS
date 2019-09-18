//
//  SaveAddressViewController.swift
//  FirebaseSmsOnay
//
//  Created by imac2 on 1/22/19.
//  Copyright © 2019 imac2. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class SaveAddressViewController: UIViewController{

   
    @IBOutlet weak var Addresstitle: UITextField!
    @IBOutlet weak var AddressCountry: UITextField!
    @IBOutlet weak var AddressCity: UITextField!
    @IBOutlet weak var AddressCounty: UITextField!
    
    @IBOutlet weak var AddressFullAddress: UITextView!
    @IBOutlet weak var AddressPostCode: UITextField!
    
    @IBOutlet weak var btn_Addresscontrol: UILabel!
     let user=User_Address()
    var UserAddressControl=true
    override func viewDidLoad() {
        super.viewDidLoad()
        SaveAddressbtn.buttondesign()
     btn_Addresscontrol.isHidden=true
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBOutlet weak var SaveAddressbtn: UIButton!
    @IBAction func SaveAddressbtn(_ sender: Any) {
        UserAddressControl=true
        getAddressInfo()
        if UserAddressControl{
            postUserJson(user: user)
        }
    }
    
    
     @IBAction func Btn_Exit(_ sender: Any) {
       /* let alert=UIAlertController(title: "Çıkış", message: "Çıkış Yapmak İstediğinize  Emin misiniz?", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Hayır", style: UIAlertAction.Style.default, handler: nil))
        alert.addAction(UIAlertAction(title: "Evet", style: UIAlertAction.Style.default, handler: {action in self.exitVC()}))
        self.present(alert,animated: true,completion: nil)*/
        exitVC()
     }
   func exitVC(){
    let storyboard :UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    let vc = storyboard.instantiateViewController(withIdentifier: "SettingsVC") as! SettingsViewController
    self.present(vc, animated: true, completion: nil)
      //dismiss(animated: true, completion: nil)
    }
    /*
     // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func getAddressInfo(){
        
       // let user=User_Address()
        
        if (Addresstitle.text?.count)!>0{
            let ATitle=Addresstitle.text
            user.Title=ATitle!}
          else{
            UserAddressControl=false;
            btn_Addresscontrol.isHidden=false
            btn_Addresscontrol.text="Adres Başlığını Boş Bıramazsınız"
            return
            
        }
        
        if (AddressCountry.text?.count)!>0
        {
            let ACountry=AddressCountry.text
            user.Country=ACountry!}
        else{
            UserAddressControl=false;
            btn_Addresscontrol.isHidden=false
            btn_Addresscontrol.text="Ülke Adını boş Bırakmayınız"
            return
          
        }
        
        if  (AddressCity.text?.count)!>0 {
            let ACity=AddressCity.text
          
            user.City=ACity!
        }else{
            UserAddressControl=false;
            btn_Addresscontrol.isHidden=false
            btn_Addresscontrol.text="Şehir ismini Boş Bırakmayınız"
            return
        }
        
        
        if (AddressCounty.text?.count)!>0
        {let ACounty=AddressCounty.text
            user.County=ACounty!
        }else{
            UserAddressControl=false;
            btn_Addresscontrol.isHidden=false
            btn_Addresscontrol.text="İlçe ismini Boş Bırakamazsınız"
            return
        }
        
        if AddressFullAddress.text.count>0
        {let AFullAddress=AddressFullAddress.text
            user.FullAddress=AFullAddress!
        }else{
            UserAddressControl=false;
            btn_Addresscontrol.isHidden=false
            btn_Addresscontrol.text="Adresi Boş Bırakamazsınız"
            return
        }
        
        if (AddressPostCode.text?.count)!>0
        {let APostCode=AddressPostCode.text
            user.PostCode=Int(APostCode!)!}
        else{
            UserAddressControl=false
            btn_Addresscontrol.isHidden=false
            btn_Addresscontrol.text="Posta kodunu Boş Bırakamazsınız"
            return
        }
        
        
      
        
        return;
        
    }
    func saveVc(){
        if  UserDefaults.standard.bool(forKey: "backpayment"){
            let storyboard=UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "PaymentStoryboard") as! PaymentViewController
            self.present(vc,animated: true,completion: nil)
        }else{
            exitVC()
        }
        // dismiss(animated: true, completion: nil)
    }
    
    func postUserJson(user:User_Address){
        print(user.County)
      let userıd=UserDefaults.standard.string(forKey: "userıd")
      
        let url="http://qrparam.net/User_Address_Info/Insert/?Address_Title="+user.Title+"&Address_Country="+user.Country
        let url2="&Address_City="+user.City+"&Address_County="+user.County
        let url3="&Address_Post_Code="+String(user.PostCode)+"&Address_Full_Address="+user.FullAddress
        let url4="&Address_Invoice_Type=4&User_ID="+userıd!
        
        let totalurl=url+url2+url3+url4
        
        let correctURL = totalurl.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
        print(correctURL)
        Alamofire.request(correctURL!,method: .get).validate().responseJSON{
            response in
            
            switch(response.result){
                
            case .success(let value):
                let json=JSON(value)
                print(json)
                if json.count>0
                {
                   

                    let alert = UIAlertController(title: "Başarılı", message: "Adresiniz Kaydedilmiştir", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "Tamam", style: UIAlertAction.Style.default,  handler: {action in self.saveVc()}))

                    self.present(alert, animated: true, completion: nil)
                    
                    
                }
            case .failure(let error):
                print(error)
                
                
            }
        }
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
