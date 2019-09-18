//
//  PaymentViewController.swift
//  FirebaseSmsOnay
//
//  Created by imac1 on 24.01.2019.
//  Copyright © 2019 imac2. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class PaymentViewController: UIViewController {
    
//MARK StartVeriables
    @IBOutlet weak var btn_addressChoose: UIButton!
    @IBOutlet weak var btn_cardchoose: UIButton!
    var tapCardChoose=true
    var tapAddressChoose=true
    
    var order_code="";
    var user_ıd=0
    //MARK Veriables
     var addressList=[User_Address]()
    var selectedaddress=""
    var selectedcard=""
     var cardList=[CreditCard]()
     var scroolview=UIScrollView()
    
    @IBOutlet weak var lblsite: UILabel!
    
    @IBOutlet weak var lblfatura: UILabel!
    
    @IBOutlet weak var lblteslimat: UILabel!
    @IBAction func btn_onayla(_ sender: Any) {
        
        if(selectedaddress != "" && selectedcard != ""){
            Siparisonay()
        }
        else{
            let alert=UIAlertController(title: "Uyarı", message: "Siparişi onaylamadan önce kredi kartı ve adres bilgisini seçmelisiniz..!", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Tamam", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert,animated: true,completion: nil)
        }
        
       
    }
    func Siparisonay()
    {
      
         let userıd=UserDefaults.standard.string(forKey: "userıd")
        print("ordercode..\(order_code)")
          print("userıd..\(userıd)")
        let url="http://qrparam.net/User_Order_Info/SiparisOnayla/?Order_Code="+String(order_code)+"&User_ID="+userıd!+"&Address_ID="+selectedaddress
        let correctURL=url.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        Alamofire.request(correctURL!,method: .get).validate().responseJSON{
            response in
            
            switch(response.result){
               
            case .success(let value):
                  let json=JSON(value)
                print("Başarılı")
                  if json["err"] == "basarili"
                  {
                    let alert=UIAlertController(title: "Bilgi", message: "Ödeme İşleminiz Başarılı Bir Şekilde Gerçekleşmiştir.", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "Tamam", style: UIAlertAction.Style.default, handler: {action in self.homecv()}))
                    self.present(alert,animated: true,completion: nil)
                    
                  }else{
                    let alert=UIAlertController(title: "Bilgi", message: "İşleminiz Şuan Gerçekleştirilemiyor..!", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "Tamam", style: UIAlertAction.Style.default, handler: {action in self.homecv()}))
                    self.present(alert,animated: true,completion: nil)
                }
                
            case .failure(let error):
                
                print(error)
                
                
            }
        }
    }
    func homecv(){
       
        
       self.performSegue(withIdentifier: "turntohome", sender: self)
    }
    @IBAction func btn_chooseAddress(_ sender: Any) {
      
        
          let y = btn_addressChoose.frame.origin.y+btn_addressChoose.frame.size.height
       
        if tapAddressChoose{
            showScroolAddress(x:10, y: Int(y), width: Int(view.frame.width-20), list: addressList)
            tapAddressChoose=false
            tapCardChoose=false
        }
        
        else{
            scroolview.isHidden=true
            tapAddressChoose=true
            tapCardChoose=true
            }
    
    }
    
    @IBAction func btn_chooseCard(_ sender: Any) {
      
        let y = self.btn_cardchoose.frame.origin.y+self.btn_cardchoose.frame.size.height
        
       
            if tapCardChoose{
               self.showScroolCreditCard(x:10, y: Int(y), width: Int(self.view.frame.width-20), list: self.cardList)
            tapCardChoose=false
            tapAddressChoose=false
                    }
            else{
            scroolview.isHidden=true
            tapCardChoose=true
            tapAddressChoose=true
                    }
        }

    
    func goToRegCardVc(){
       
        let storyboard=UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "RegCreditCard") as! SaveCreditCardController
        self.present(vc,animated:true,completion:nil )
    }
    func saveAdres(){
        let storyboard :UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "SaveAddressStoryboard") as! SaveAddressViewController
        self.present(vc, animated: true, completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UserDefaults.standard.set(true, forKey: "backpayment")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        AddressRequest()
        CreditCardRequest()
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
    func showScroolAddress(x:Int,y:Int,width:Int,list:[User_Address]){
        scroolview=UIScrollView()
        scroolview.isHidden=false
        scroolview.frame=CGRect(x: x, y: y, width: width, height: list.count*60)
        scroolview.contentSize=CGSize(width: width, height: list.count*60)
        scroolview.backgroundColor=UIColor.gray
        scroolview.isScrollEnabled=true
        for i in 0..<list.count{
            
            let button = UIButton()
            button.frame=CGRect(x: x, y:10+(i*55), width: width-20, height: 50)
            button.setTitle(String(addressList[i].Title), for: .normal)
            button.setTitleColor(.black, for: .normal)
            button.addTarget(self, action: #selector(tapToAddressButton(_:)), for: .touchUpInside)
            button.tag=addressList[i].id
            button.backgroundColor=UIColor.white
            button.layer.cornerRadius=5
            scroolview.addSubview(button)
        }
        
      
        
        self.view.addSubview(scroolview)
    }
    
   @objc func tapToAddressButton(_ sender: UIButton){
    
    for i in 0..<addressList.count{
        
        if Int(addressList[i].id)==sender.tag{
            scroolview.isHidden=true
            btn_addressChoose.setTitle(addressList[i].Title, for: .normal)
            self.tapAddressChoose=true
            self.tapCardChoose=true
            selectedaddress=String(addressList[i].id)
            print("son adres  \(selectedaddress)");
            lblteslimat.text=String(addressList[i].Title)
            lblfatura.text=String(addressList[i].Title)
        }
        
    }
        
    }
    func showScroolCreditCard(x:Int,y:Int,width:Int,list:[CreditCard]){
        
        scroolview=UIScrollView()
        scroolview.isHidden=false
        scroolview.frame=CGRect(x: x, y: y, width: width, height: list.count*60)
        scroolview.contentSize=CGSize(width: width, height: list.count*100)
        scroolview.backgroundColor=UIColor.gray
        scroolview.isScrollEnabled=true
        for i in 0..<list.count{
            
            let button = UIButton()
            button.frame=CGRect(x: x, y:10+(i*55), width: width-20, height: 50)
            button.setTitle(String(cardList[i].Card_Name), for: .normal)
            button.setTitleColor(.black, for: .normal)
            button.backgroundColor=UIColor.white
            button.addTarget(self, action: #selector(tapToCardButton(_:)), for: .touchUpInside)
            button.tag=Int(cardList[i].Cards_ID)!
            button.layer.cornerRadius=5
            scroolview.addSubview(button)
        }
        
        self.view.addSubview(scroolview)
    }
    
    @objc func tapToCardButton(_ sender: UIButton){
        for i in 0..<cardList.count{
            if Int(cardList[i].Cards_ID)==sender.tag{
                scroolview.isHidden=true
                btn_cardchoose.setTitle(cardList[i].Card_Name, for: .normal)
                self.tapAddressChoose=true
                self.tapCardChoose=true
                selectedcard=cardList[i].Cards_ID;
                break;
                
            }
        }
    }
    
    func CreditCardRequest(){
        cardList.removeAll()
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
                    var creditCard=CreditCard()
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
                    
                    }
                 
                    
                    
                }else{
                    let alert=UIAlertController(title: "Kart Bilgi ", message: "Kayıtlı Kartınız Bulunmamaktadır.Kart Kaydetme Sayfasına Yönlendiriliyorsunuz", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "Tamam", style: UIAlertAction.Style.default, handler: {action in self.goToRegCardVc()}))
                    self.present(alert,animated: true, completion: nil)
                }
               
                
                case .failure(let error):
                print(error)
            }
            
            
        }
        
    }

    
    
    func AddressRequest(){
        let userId = UserDefaults.standard.string(forKey: "userıd")
        let url = "http://qrparam.net/User_Address_Info/Listele/?User_ID="+userId!
        let correctURL = url.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
        
        
        Alamofire.request(correctURL!).validate().responseJSON{
            
            response in
            
            switch(response.result){
                
                
            case .success(let value):
                let addressjson=JSON(value)
                print(addressjson)
                print(addressjson.count)
                if addressjson.count>0{
                for i in 0...addressjson.count-1{
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
                    self.lblfatura.text = self.addressList[addressjson.count-1].Title;
                    self.selectedaddress=String(self.addressList[addressjson.count-1].id);
                    self.lblteslimat.text=self.addressList[addressjson.count-1].Title;
                   
                    
                }else{
                   let alert=UIAlertController(title: "Adres Bilgi ", message: "Kayıtlı Adresiniz Bulunmamaktadır.Adres Kaydetme Sayfasına Yönlendiriliyorsunuz", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "Tamam", style: UIAlertAction.Style.default, handler: {action in self.saveAdres()}))
                    self.present(alert,animated: true, completion: nil)
                }
               // self.scroolview.reloadData();
                //self.scroolview.reloadInputViews()
              //  self.btn_addressChoose.reloadInputViews()
                
                
                
            case.failure(let error):
                print(error)
                
            }
            
        }
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier=="turntohome"{
            guard let vc = segue.destination as? QrOrderViewController else{return}
            vc.Order_Code=order_code
        }
    }
}
