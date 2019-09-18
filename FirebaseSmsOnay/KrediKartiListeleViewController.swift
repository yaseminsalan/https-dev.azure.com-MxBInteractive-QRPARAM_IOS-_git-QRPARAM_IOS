//
//  KrediKartiListeleViewController.swift
//  FirebaseSmsOnay
//
//  Created by imac2 on 3/19/19.
//  Copyright © 2019 imac2. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
class KrediKartiListeleViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
      var cardList=[CreditCard]()

   

    @IBOutlet var tableview: UITableView!
    
    @IBOutlet var SaveCreditCart: UIButton!
    
  
    
    @IBAction func SaveCreditCart(_ sender: Any) {
        let storyboard :UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "SaveAddressStoryboard") as! SaveAddressViewController
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func cartdelete(_ sender: Any) {
        deleteCard()
    }
    @IBAction func Backbtn(_ sender: Any) {
        let storyboard :UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "SettingsVC") as! SettingsViewController
        self.present(vc, animated: true, completion: nil)
        //dismiss(animated: true, completion: nil)
        //self.navigationController?.popViewController(animated: true)
    }
   
   
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cardList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cardCell", for: indexPath) as? KrediKartiListeleTableViewCell
         print("girşi cell")
        cell?.cartname.text=cardList[indexPath.row].Card_Name
        cell?.cartno.text=cardList[indexPath.row].Card_Number
        cell?.carttype.text=cardList[indexPath.row].Card_Type
        
        print(cardList[indexPath.row].Card_Name)
       /* cell?.carttype.text=cardList[indexPath.row].Card_Type
        cell?.cartnumber.text=cardList[indexPath.row].Card_Number
        cell?.carthavename.text=cardList[indexPath.row].Credit_Card_Name
        cell?.exprirationdate.text=cardList[indexPath.row].Card_Exprition_Year
        cell?.securitycode.text=cardList[indexPath.row].Card_CVV
        print("cartguvenlik\(cardList[indexPath.row].Card_CVV)")
        print("cartbilgi")*/
        let deletecardıd=String(cardList[indexPath.row].Cards_ID);
        UserDefaults.standard.set(deletecardıd, forKey: "carddelete")
        cell!.viewcell.layer.cornerRadius=5
        cell!.viewcell.layer.borderWidth=2
        cell!.viewcell.layer.borderColor=UIColor.darkGray.cgColor
        cell!.viewcell.layer.backgroundColor=UIColor.white.cgColor
    
        
        return cell!
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
   
     
       CreditCardRequest()
       // tableview.register(UITableViewCell.self, forCellReuseIdentifier: "cardCell")
        self.tableview.delegate=self
        self.tableview.dataSource=self
      
        tableview.tableFooterView=UIView();
    
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // addressList.removeAll()
       
    }
    func CreditCardRequest(){
      //  cardList.removeAll()
        let userıd=UserDefaults.standard.string(forKey: "userıd")
        let correctUrl="http://qrparam.net/User_Credit_Cards_Info/ListToCard/?User_ID="+userıd!
        print(correctUrl)
        Alamofire.request(correctUrl,method:.get).validate().responseJSON{
            
            response in
            
            switch(response.result){
                
            case .success(let value):
                let json=JSON(value)
                print("CardJson\(json)")
                if json["card"].count>0{
                    for i in 0..<json["card"].count{
                        let creditCard=CreditCard()
                        creditCard.Card_CVV=json["card"][i]["Card_CVV"].stringValue
                        creditCard.Card_Exprition_Month=json["card"][i]["Card_Exprition_Month"].stringValue
                        creditCard.Cards_ID=json["card"][i]["Cards_ID"].stringValue
                        creditCard.Card_Exprition_Year=json["card"][i]["Card_Exprition_Year"].stringValue
                        creditCard.Card_Name=json["card"][i]["Card_Name"].stringValue
                        creditCard.Card_Number=json["card"][i]["Card_Number"].stringValue
                        creditCard.Credit_Card_Name=json["card"][i]["Credit_Card_Name"].stringValue
                        creditCard.Card_Type=json["card"][i]["Card_Type"].stringValue
                        print("cardname--\(json["card"][i]["Card_Name"].stringValue)")
                        self.cardList.append(creditCard)
                        print("listele \(creditCard.Card_CVV)")
                    }
                    self.tableview.reloadData()
                   
                    
                }else{
                    let alert = UIAlertController(title: "", message: "Kayıtlı Kartınız bulunmamaktadır.Kart Kaydetmek istermisiniz?", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "Hayır", style: UIAlertAction.Style.default,  handler: {action in self.CancelCard()}))
                    alert.addAction(UIAlertAction(title: "Evet", style: UIAlertAction.Style.default,  handler: {action in self.saveCard()}))
                    
                    self.present(alert, animated: true, completion: nil)
                  
                }
                
             
               
            case .failure(let error):
                print(error)
            }
            
            
        }
        
    }
    func deleteCard(){
        let cartsil = UserDefaults.standard.integer(forKey:"carddelete" )
        print("adressildelete..\(cartsil)")
        let url = "http://qrparam.net/User_Credit_Cards_Info/DeleteCreditCard/?Card_ID="+String(cartsil)
        let correctURL = url.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
        
        
        Alamofire.request(correctURL!).validate().responseJSON{
            
            response in
            
            switch(response.result){
                
                
            case .success(let value):
                let addressjson=JSON(value)
                print("başarılı")
                let alert=UIAlertController(title: "İşlem Bilgi ", message: "Kart Silme İşleminiz Başarılı Bir Şekilde Gerçekleşmiştir", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Tamam", style: UIAlertAction.Style.default, handler: {action in self.deletecart()}))
                self.present(alert,animated: true, completion: nil)
                
            case.failure(let error):
                print(error)
                
            }
            
        }
        
    }

    func saveCard(){
        let storyboard :UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "RegCreditCard") as! SaveCreditCardController
        self.present(vc, animated: true, completion: nil)
        
    }
    func deletecart(){
        let storyboard :UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "CreditCartListeleStr") as! KrediKartiListeleViewController
        self.present(vc, animated: true, completion: nil)
        
    }
    func CancelCard(){
        let storyboard :UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "SettingsVC") as! SettingsViewController
        self.present(vc, animated: true, completion: nil)
    }
    
    
}
