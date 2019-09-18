//
//  AddressUptadeViewController.swift
//  FirebaseSmsOnay
//
//  Created by imac1 on 15.01.2019.
//  Copyright © 2019 imac2. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class AddressUptadeViewController: UITableViewController{
    
    var UserId=0;

    override func viewDidLoad() {
        super.viewDidLoad()

     
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    
    
    
    func getAddress() -> [Address] {
        
      var userAddress = [Address]()
        let url = "http://qrparam.net/User_Address_Info/Listele/?User_ID="+String(UserId)
        let correctUrl=url.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
        
        Alamofire.request(url).validate().responseJSON{
            response in
            
            switch(response.result){
                
            case .success(let value):
                
                    let addressjson=JSON(value)
                    if(addressjson.count>0){
                    for i in 0...addressjson.count{
                        
                        var address = Address()
                        address.Address_City=addressjson[i]["Address_City"].stringValue
                        address.Address_Country=addressjson[i]["Address_Country"].stringValue
                        address.Address_County=addressjson[i]["Address_County"].stringValue
                        address.Address_Full_Address=addressjson[i]["Address_Full_Address"].stringValue
                        address.Address_Invoice_Type=addressjson[i]["Address_Invoice_Type"].stringValue
                        address.Address_Post_Code=addressjson[i]["Address_Post_Code"].stringValue
                        address.Address_Title=addressjson[i]["Address_Title"].stringValue
                        address.User_Address_ID=addressjson[i]["User_Address_ID"].stringValue
                       userAddress.append(address)
                    }
                }
                    else{
                        print("Adres bulunumadı")
                }
                
                
            case .failure(let error):
                
                print(error)
                
            }
        }
        
    }
    

   

}
