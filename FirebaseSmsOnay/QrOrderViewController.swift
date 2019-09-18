//
//  QrOrderViewController.swift
//  FirebaseSmsOnay
//
//  Created by imac1 on 22.01.2019.
//  Copyright © 2019 imac2. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class QrOrderViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
   
   
    @IBOutlet weak var tableview: UITableView!
   
    var Order_Code="";
   
    var orderList = [User_Order_Info]()

    override func viewDidLoad() {
        super.viewDidLoad()
       
      
    }
    override func viewWillAppear(_ animated: Bool) {
        getShoppingBox()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    
    @IBAction func btn_confirm(_ sender: Any) {
        
        self.performSegue(withIdentifier: "paymentsegue", sender: self)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("orderlistcount\(orderList.count)")
        return orderList.count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! QrOrderViewControllerTableViewCell
        
        
        print("orderlist\(orderList[indexPath.row].Order_Product_Name)")
        cell.label_productcode.text=String(orderList[indexPath.row].Order_Code)
        cell.label_paytype.text=orderList[indexPath.row].Order_Payment_Method
        cell.label_ordername.text=orderList[indexPath.row].Order_Product_Name
        cell.label_unitprice.text=orderList[indexPath.row].Order_Unit_Price
        cell.label_totalprice.text=String(orderList[indexPath.row].Order_Total_Price)
        cell.viewcell.layer.cornerRadius=5
        cell.viewcell.layer.borderWidth=2
        cell.viewcell.layer.borderColor=UIColor.darkGray.cgColor
        cell.viewcell.layer.backgroundColor=UIColor.gray.withAlphaComponent(0.5).cgColor
        return cell
    }
    
    
    
    func getShoppingBox(){
        
        
        
        let url = "http://qrparam.net/User_Order_Info/AnlikSiparis/?Order_Code="+String(Order_Code)
        //+String(Order_Code)
        let correcrURL = url.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        print("url\(url)")
        
        Alamofire.request(correcrURL!,method:.get).validate().responseJSON{
            response in
            
            
            switch(response.result){
                
            case .success(let value):
                let json=JSON(value)
               
                print("jsoncount\(json.count)")
                if json.count>0{
                for index in 0..<json["list"].count{
                    
                    var UserorderInfoİcerik = User_Order_Info()
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
                    print("Userordericerik\(UserorderInfoİcerik.Address_Title)")
                    self.orderList.append(UserorderInfoİcerik)
                   
                }
                
                  self.tableview.reloadData()
               
                    print("reload")}else{
                    print("qrboş")
                }
            case .failure(let error):
                
                print("bağlantı hatası")
                
                
            
            }
        }
    }
 
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier=="paymentsegue"{
            guard let vc = segue.destination as? PaymentViewController else{return}
            
            vc.order_code=String(Order_Code)
            
        }
    }
    
    
    
    

}
