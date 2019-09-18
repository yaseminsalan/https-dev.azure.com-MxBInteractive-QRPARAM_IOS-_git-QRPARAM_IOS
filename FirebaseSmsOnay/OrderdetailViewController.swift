//
//  OrderdetailViewController.swift
//  FirebaseSmsOnay
//
//  Created by imac2 on 1/30/19.
//  Copyright © 2019 imac2. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
class OrderdetailViewController: UIViewController,UITableViewDelegate ,UITableViewDataSource{
    
    var UserorderInfoİceriklist = [User_Order_Info]();
    var UserOrderInfoAddresslist = [User_Address]();
    var user3 = User_Credentials()
    let navigationBar=0;
    let address:String=""
    // var labell:UILabel=UILabel()

    
    @IBOutlet weak var btn_exit: UIButton!
    @IBOutlet weak var Lbl_adres: UILabel!
    @IBOutlet weak var tableview: UITableView!
    var adresbilgi=""
    
    @IBAction func btn_exit(_ sender: Any) {
       /* let alert = UIAlertController(title: "Çıkış", message: "Çıkış Yapmak İstediğinize Emin misiniz?", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Hayır", style: UIAlertAction.Style.default, handler: nil))
        alert.addAction(UIAlertAction(title: "Evet", style: UIAlertAction.Style.default, handler: {action in self.exitVC()}))
        self.present(alert,animated: true,completion: nil)*/
        exitVC()
    }
    
    
    func exitVC(){
        let storyboard :UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "TableviewCV") as! TableViewController
        self.present(vc, animated: true, completion: nil)
        //dismiss(animated: true, completion: nil)
        //self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func address_viewbtn(_ sender: Any) {
        let alert=UIAlertController(title: "Sipariş Adresi", message: adresbilgi, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Tamam", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return UserorderInfoİceriklist.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // #warning Incomplete implementation, return the number of rows
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! OrderdetailTableViewCell
        
        
        print("listecount2 \(UserorderInfoİceriklist.count)")
        
      
        print ("title\(UserorderInfoİceriklist[indexPath.row].Order_Web_Site)")
        
        cell.ordercode.text=String(UserorderInfoİceriklist[indexPath.row].Order_Code);
        cell.orderproductname.text=UserorderInfoİceriklist[indexPath.row].Order_Product_Name;
        cell.orderunitprice.text=String(UserorderInfoİceriklist[indexPath.row].Order_Unit_Price);
        cell.orderpaymentmethod.text=UserorderInfoİceriklist[indexPath.row].Order_Payment_Method;
        cell.ordertotalprıce.text=String(UserorderInfoİceriklist[indexPath.row].Order_Total_Price);
        
        
        cell.viewcell.layer.cornerRadius=5
        cell.viewcell.layer.borderWidth=2
        cell.viewcell.layer.borderColor=UIColor.darkGray.cgColor
        //cell.viewcell.layer.backgroundColor=UIColor.gray.withAlphaComponent(0.5).cgColor
        cell.viewcell.layer.backgroundColor=UIColor.white.withAlphaComponent(0.5).cgColor
        
        
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData2();
        self.tableview.delegate=self
        self.tableview.dataSource=self
        tableview.tableFooterView=UIView();
        

        // Do any additional setup after loading the view.
    }
    
    func getData2(){
     
        let ordercode=UserDefaults.standard.string(forKey: "ordercode")
        print("ensonordercode  \(ordercode)");
        let userıd=UserDefaults.standard.string(forKey: "userıd")
        print("orderdegeri....\(userıd)")
        let UserorderInfoİcerik = User_Order_Info()
        let UserorderInfoAddress = User_Address()
        Alamofire.request("http://qrparam.net/User_Order_Info/GecmisSiparislerIcerik/?Order_Code="+ordercode!+"&User_ID="+userıd!, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                
                if json.count > 0{
                    
                    
                    print(json)
                    for index in 0..<json["list"].count{
                        print("index \(index)")
                        
                        UserorderInfoİcerik.Order_ID=json["list"][index]["Order_ID"].intValue
                        UserorderInfoİcerik.Order_Code=json["list"][index]["Order_Code"].stringValue
                        UserorderInfoİcerik.Order_Datee=json["list"][index]["Order_Date"].stringValue
                        UserorderInfoİcerik.Order_Product_Name=json["list"][index]["Order_Product_Name"].stringValue
                        UserorderInfoİcerik.Order_Status=json["list"][index]["Order_Status"].intValue
                        UserorderInfoİcerik.Order_Unit=json["list"][index]["Order_Unit"].stringValue
                        UserorderInfoİcerik.Order_Unit_Price=json["list"][index]["Order_Unit_Price"].stringValue
                        UserorderInfoİcerik.Order_Product_Amount=json["list"][index]["Order_Product_Amount"].intValue
                        UserorderInfoİcerik.Order_Product_Tax_Ratio=json["list"][index]["Order_Product_Tax_Ratio"].stringValue
                        UserorderInfoİcerik.Order_Product_Tax_Price=json["list"][index]["Order_Product_Tax_Price"].stringValue
                        UserorderInfoİcerik.Order_Product_Price=json["list"][index]["Order_Product_Price"].stringValue
                        UserorderInfoİcerik.Order_Shipping_Price=json["list"][index]["Order_Shipping_Price"].floatValue
                        UserorderInfoİcerik.Order_Total_Price=json["list"][index]["Order_Total_Price"].floatValue
                        UserorderInfoİcerik.Order_Payment_Method=json["list"][index]["Order_Payment_Method"].stringValue
                        UserorderInfoİcerik.Shopping_Box_ID=json["list"][index]["Shopping_Box_ID"].intValue
                        UserorderInfoİcerik.Order_Web_Site=json["list"][index]["Order_Web_Site"].stringValue
                        UserorderInfoAddress.id=json["addr"][index]["id"].intValue
                        UserorderInfoAddress.Title=json["addr"][index]["Title"].stringValue
                        UserorderInfoAddress.Country=json["addr"][index]["Country"].stringValue
                        UserorderInfoAddress.City=json["addr"][index]["City"].stringValue
                        UserorderInfoAddress.County=json["addr"][index]["County"].stringValue
                        UserorderInfoAddress.PostCode=json["addr"][index]["PostCode"].intValue
                        UserorderInfoAddress.FullAddress=json["addr"][index]["FullAddress"].stringValue
                        UserorderInfoAddress.InvoiceType=json["addr"][index]["InvoiceType"].stringValue
                        
                        self.UserorderInfoİceriklist.append(UserorderInfoİcerik)
                        self.UserOrderInfoAddresslist.append(UserorderInfoAddress)
                        // var User_ID:Int = 0
                        print("orderıd..\(UserorderInfoİcerik.Order_ID)")
                        
                        //   print("içerde\(address)")
                        print("adress..\(self.UserOrderInfoAddresslist[0].Title)")
                        
                    }
                    
                    let string1=self.UserOrderInfoAddresslist[0].Title
                    let string2=self.UserOrderInfoAddresslist[0].FullAddress
                    let string3=self.UserOrderInfoAddresslist[0].County+" "+self.UserOrderInfoAddresslist[0].City+" "+self.UserOrderInfoAddresslist[0].Country
                    let string4=self.UserOrderInfoAddresslist[0].PostCode
                    print("string..\(string4)")
                    //self.Lbl_adres.text="Adress:"+string1+"\n"+string2+" "+string3+"\n Posta kodu:"+String(string4)
                   // print("label...\(self.Lbl_adres.text)")
                    //string1+string2+string3+String(string4)
                    self.adresbilgi="Adress:"+string1+"\n"+string2+" "+string3+"\n Posta kodu:"+String(string4)
                    
                    
                    self.tableview.reloadData();
                    print(self.UserorderInfoİceriklist[0].Order_Product_Name)
                    // let address=UserorderInfoİceriklist.Address_Title
                }
            case .failure(let error):
                print(error)
            }
            
        }
    }
    
}

