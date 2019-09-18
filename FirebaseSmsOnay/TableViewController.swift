//
//  TableViewController.swift
//  MarketApi
//
//  Created by imac1 on 5.12.2018.
//  Copyright © 2018 imac1. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON



class TableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
   

    
    
   

    
    var UserorderInfolist = [User_Order_Info]()
   // var user2 = User_Credentials()
    @objc var methodname:Int=0

    @IBAction func btn_cıkıs(_ sender: Any) {
        /*let alert = UIAlertController(title: "Çıkış", message: "Çıkış Yapmak İstediğinize Emin misiniz?", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Hayır", style:.default, handler: nil))
        alert.addAction(UIAlertAction(title: "Evet", style: UIAlertAction.Style.default, handler: {action in self.exitVC()
        }))
        self.present(alert,animated: true, completion: nil)*/
        exitVC()
    }
   
    @IBOutlet weak var tableview: UITableView!
    func exitVC(){
        let storyboard :UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "HomePage") as! HomeViewController
        self.present(vc, animated: true, completion: nil)
        //dismiss(animated: true, completion: nil)
        //self.navigationController?.popViewController(animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getData();
        self.tableview.delegate=self
        self.tableview.dataSource=self
      //  tableview.tableFooterView=UIView();
        
        
        
    }
    /*override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //UserorderInfolist.removeAll()
        
    }*/
    
    
    // MARK: - Table view data source
    
     func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1;
    }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return UserorderInfolist.count;
    }
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.section).")
        print("Cell cliked value is \(indexPath.row)")
        
        
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            
            let controller = storyboard.instantiateViewController(withIdentifier: "SiparisDetay") as! OrderdetailViewController
        
            self.present(controller,animated: true,completion: nil)
          //  self.navigationController?.pushViewController(controller, animated: true)
            
        
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell
        print("listecount \(UserorderInfolist.count)")
        print("cell\(UserorderInfolist[indexPath.row].Order_Datee)")
       // cell.Ordercode.text=String(UserorderInfolist[indexPath.row].Order_Code);
        cell.Orderdate.text=UserorderInfolist[indexPath.row].Order_Datee;
        cell.OrderStatus.text=String(UserorderInfolist[indexPath.row].Order_Status);
        cell.OrderWebSite.text=String(UserorderInfolist[indexPath.row].Order_Web_Site);
        print("product name   \(UserorderInfolist[indexPath.row].Order_Product_Name)")
       let ordercode=String(UserorderInfolist[indexPath.row].Order_Code);
        UserDefaults.standard.set(ordercode, forKey: "ordercode")
      //  print("siparistarih \(UserorderInfolist[].Order_Product_Name)")
        
        
      //  cell.SiparişDetay.tag=indexPath.row
        

      // cell.SiparişDetay.addTarget(self, action: #selector(getter: methodname), for: .touchUpInside)
        

        return cell
    }
    //String(user2.User_ID)
    func homebackVc(){
        let storyboard=UIStoryboard(name: "Main", bundle: nil)
        let vc=storyboard.instantiateViewController(withIdentifier: "HomePage") as! HomeViewController
        self.present(vc,animated: true,completion: nil)
    }
  
    func getData(){

        let userıd=UserDefaults.standard.string(forKey: "userıd")
        print("siparişuser \(userıd)")
        var UserorderInfo = User_Order_Info()
        let url="http://qrparam.net/User_Order_Info/GecmisSiparisler/?User_ID="+userıd!
        let corecturl=url.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        
        Alamofire.request(corecturl!, method: .get).validate().responseJSON { response in
            print(corecturl)
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                if json.count > 0{
                    print("siparişler içerik json \(json)")
                    for index in 0..<json.count{
                        UserorderInfo = User_Order_Info()
                        print("jsonboyut \(json.count)")
                        print("index \(index)")
                        UserorderInfo.Order_ID=json[index]["Order_ID"].intValue
                        UserorderInfo.Order_Code=json[index]["Order_Code"].stringValue
                        UserorderInfo.Order_Datee=json[index]["Order_Datee"].stringValue
                        UserorderInfo.Order_Product_Name=json[index]["Order_Product_Name"].stringValue
                        UserorderInfo.Order_Status=json[index]["Order_Status"].intValue
                        UserorderInfo.Order_Unit=json[index]["Order_Unit"].stringValue
                        UserorderInfo.Order_Unit_Price=json[index]["Order_Unit_Price"].stringValue
                        UserorderInfo.Order_Product_Amount=json[index]["Order_Product_Amount"].intValue
                        UserorderInfo.Order_Product_Tax_Ratio=json[index]["Order_Product_Tax_Ratio"].stringValue
                        UserorderInfo.Order_Product_Tax_Price=json[index]["Order_Product_Tax_Price"].stringValue
                        UserorderInfo.Order_Product_Price=json[index]["Order_Product_Price"].stringValue
                        UserorderInfo.Order_Shipping_Price=json[index]["Order_Shipping_Price"].floatValue
                        UserorderInfo.Order_Total_Price=json[index]["Order_Total_Price"].floatValue
                        UserorderInfo.Order_Payment_Method=json[index]["Order_Payment_Method"].stringValue
                        UserorderInfo.Shopping_Box_ID=json[index]["Shopping_Box_ID"].intValue
                        UserorderInfo.Order_Web_Site=json[index]["Order_Web_Site"].stringValue
                        self.UserorderInfolist.append(UserorderInfo)
                        print("siparişadıson\(UserorderInfo.Order_Product_Name)")
                        print("listesiparışiiçi \(self.UserorderInfolist[index].Order_Product_Name)")
                        
                    }
                  
                    self.tableview.reloadData();
                    
                }else{
                    let alert=UIAlertController(title: "Sipariş Bilgi", message: "Hiç Siparişiniz Bulunmamaktadır..!", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "Tamam", style: UIAlertAction.Style.default, handler: {action in self.homebackVc()}))
                    self.present(alert,animated: true,completion: nil)
                }
            case .failure(let error):
                print(error)
            }
            
        }
    }
   
    
}





