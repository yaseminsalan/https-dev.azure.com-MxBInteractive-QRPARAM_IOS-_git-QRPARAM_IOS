//
//  AddressListeleViewController.swift
//  FirebaseSmsOnay
//
//  Created by imac2 on 1/29/19.
//  Copyright © 2019 imac2. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class AddressListeleViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var tableview: UITableView!
    
    @IBOutlet weak var SaveAddress: UIButton!
    
    @IBAction func btn_Cıkıs(_ sender: Any) {
       /* let alert = UIAlertController(title: "Çıkış", message: "Çıkış Yapmak İstediğinize Emin misiniz?", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Hayır", style: UIAlertAction.Style.default, handler: nil))
        alert.addAction(UIAlertAction(title: "Evet", style: UIAlertAction.Style.default, handler: {action in self.exitVC()}))
        self.present(alert,animated: true,completion: nil)*/
        exitVC()
        
    }
    
    @IBOutlet var adresdelete: UIButton!
    
    @IBAction func adresdelete(_ sender: Any) {
        
        deleteAdress()
    }
    func exitVC(){
        
        let storyboard :UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "SettingsVC") as! SettingsViewController
        self.present(vc, animated: true, completion: nil)
        //dismiss(animated: true, completion: nil)
        //self.navigationController?.popViewController(animated: true)
    }
    @IBAction func SaveAddress(_ sender: Any) {
       
        let storyboard :UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "SaveAddressStoryboard") as! SaveAddressViewController
        self.present(vc, animated: true, completion: nil)
    }
    var userID=0
    var addressList=[User_Address]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return addressList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? AddressListeleTableViewCell
        let adres=addressList[indexPath.row].Title
        let adres1=addressList[indexPath.row].City+" "+addressList[indexPath.row].Country+" "+String(addressList[indexPath.row].PostCode)
        let adres2=addressList[indexPath.row].FullAddress+" "+addressList[indexPath.row].County+"/"
       
        let deleteadresıd=String(addressList[indexPath.row].id);
        UserDefaults.standard.set(deleteadresıd, forKey: "adresdelete")
       
        cell?.adress_lbl.text = adres+adres2+adres1
        print("sonadres..\(cell?.adress_lbl.text)")
        cell!.viewcell.layer.cornerRadius=5
        cell!.viewcell.layer.borderWidth=2
        cell!.viewcell.layer.borderColor=UIColor.darkGray.cgColor
        cell!.viewcell.layer.backgroundColor=UIColor.white.cgColor
        
        return cell!
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
       SaveAddress.buttondesign()
    adresdelete.buttondesign()
         AddressRequest();
        tableview.tableFooterView=UIView();
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(animated)
       // addressList.removeAll()
       
    }
    func AddressRequest(){
        let userıd = UserDefaults.standard.string(forKey: "userıd")
        let url = "http://qrparam.net/User_Address_Info/Listele/?User_ID="+userıd!
        let correctURL = url.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
        
        
        Alamofire.request(correctURL!).validate().responseJSON{
            
            response in
           
            switch(response.result){
                
                
            case .success(let value):
                let addressjson=JSON(value)
                print(addressjson)
                print(addressjson.count)
                if(addressjson.count>0){
                for i in 0..<addressjson.count{
                    print(i)
                    let address=User_Address()
                    address.id = addressjson[i]["id"].intValue
                    address.Title = addressjson[i]["Title"].stringValue
                    address.Country = addressjson[i]["Country"].stringValue
                    address.City = addressjson[i]["City"].stringValue
                    address.County = addressjson[i]["County"].stringValue
                    address.PostCode = addressjson[i]["PostCode"].intValue
                    address.FullAddress = addressjson[i]["FullAddress"].stringValue
                    address.InvoiceType = addressjson[i]["InvoiceType"].stringValue
                    address.UserId = addressjson[i]["UserId"].stringValue
                    self.addressList.append(address)
                    
                }
                self.tableview.reloadData()
                
                }else{
                    let alert = UIAlertController(title: "", message: "Kayıtlı Adresiniz bulunmamaktadır.Adres Kaydetmek istermisiniz?", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "Hayır", style: UIAlertAction.Style.default,  handler: {action in self.CancelAddress()}))
                    alert.addAction(UIAlertAction(title: "Evet", style: UIAlertAction.Style.default,  handler: {action in self.saveAdres()}))
                   
                    self.present(alert, animated: true, completion: nil)
                }
                
            case.failure(let error):
                print(error)
                
            }
            
        }
        
    }
    func deleteadres(){
        let storyboard :UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "Addreslistele") as! AddressListeleViewController
        self.present(vc, animated: true, completion: nil)
    }
    func deleteAdress(){
        let deneme = UserDefaults.standard.integer(forKey:"adresdelete" )
        print("adressildelete..\(deneme)")
        let url = "http://qrparam.net/User_Address_Info/DeleteAddress/?Address_ID="+String(deneme)
        let correctURL = url.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
        
        
        Alamofire.request(correctURL!).validate().responseJSON{
            
            response in
            
            switch(response.result){
                
                
            case .success(let value):
                let addressjson=JSON(value)
             print("başarılı")
                let alert=UIAlertController(title: "İşlem Bilgi ", message: "Adres Silme İşleminiz Başarılı Bir Şekilde Gerçekleşmiştir", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Tamam", style: UIAlertAction.Style.default, handler: {action in self.deleteadres()}))
                self.present(alert,animated: true, completion: nil)
            
            case.failure(let error):
                print(error)
                
            }
            
        }
        
    }
    func saveAdres(){
        let storyboard :UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "SaveAddressStoryboard") as! SaveAddressViewController
        self.present(vc, animated: true, completion: nil)
       
    }
    func CancelAddress(){
        let storyboard :UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "SettingsVC") as! SettingsViewController
        self.present(vc, animated: true, completion: nil)
    }
    

}
