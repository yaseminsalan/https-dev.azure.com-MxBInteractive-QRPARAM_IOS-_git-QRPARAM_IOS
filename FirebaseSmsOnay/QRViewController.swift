//
//  QRViewController.swift
//  qrpay
//
//  Created by imac1 on 21.12.2018.
//  Copyright © 2018 imac1. All rights reserved.
//

import UIKit
import AVFoundation
import Alamofire
import SwiftyJSON

class QRViewController: UIViewController,AVCaptureMetadataOutputObjectsDelegate {
    


    
    var videoPreviewLayer:AVCaptureVideoPreviewLayer?
    var qrCodeFrameView:UIView?
    var user1 = User_Credentials()
   // var timer: Timer!;
    var yeniArr=0;
    var isStartQr=false;
    let captureSession = AVCaptureSession()
    var userorderinfo=User_Order_Info()


    override func viewDidLoad() {
        
        super.viewDidLoad()
      // print("qr1 \(user1.User_ID)")
        
       startQr()
        
    }

   
    
    func startQr(){
        isStartQr=true;
        
        guard let captureDevice = AVCaptureDevice.default(for: .video) else {
            return
        }
        /* guard  let inputu = try? AVCaptureDeviceInput(device: captureDevice) else {
         return
         
         }*/
        do{
            //önceki aygıt nesnesini kullanarak AVCaptureDeviceInput sınıfının nir örneği alındı
            let input = try AVCaptureDeviceInput(device: captureDevice)
            //Giriş cihazını yakalama oturumuna ayarla
            captureSession.addInput(input)
            
            //Bir AVCaptureMetadataoutput nesnesini başlatın ve yakalama oturumu içi çıkış aygıtı olarak ayarlayın
            let captureMetadataOutput = AVCaptureMetadataOutput()
            captureSession.addOutput(captureMetadataOutput)
            
            
            //Delegeyi ayarlayın ve geri aramayı yürütmek için varsayılan gönderi kuyruğunu kullanın
            captureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            captureMetadataOutput.metadataObjectTypes = [AVMetadataObject.ObjectType.qr]
            
            
            
            //cihazın kamerası tarafından yakalanan videoyu ekranda görüntülememiz için aşağıdaki kodu ekledik
            videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
            videoPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
            videoPreviewLayer?.frame = view.layer.bounds
            view.layer.addSublayer(videoPreviewLayer!)
            captureSession.startRunning()
            //QR kodunu vurgulamak için önce bir UIView nesnesi oluşturacağız ve sınırını yeşile ayarlayacağız.
            
            qrCodeFrameView = UIView()
            //UIView nesnesinin boyutu varsayılan olarak sıfır olarak ayarlandığından qrCodeFrameView değişkeni ekranda görünmez. Daha sonra, bir QR kodu algılandığında, boyutunu değiştirir ve yeşil bir kutuya dönüştürürüz.
            print("dış")
            if let qrCodeFrameView = qrCodeFrameView {
                print("iç")
                qrCodeFrameView.layer.borderColor = UIColor.green.cgColor
                qrCodeFrameView.layer.borderWidth = 2
                view.addSubview(qrCodeFrameView)
               // view.bringSubview(toFront: qrCodeFrameView)
              
            }
        } catch {
            //herhangi bir hata oluşursa , sadece hatayı yazdırın ve daha fazla devam etmeyin
            print(error)
            return
        }
        
        
        
        
        
        // Do any additional setup after loading the view.
     //   view.bringSubview(toFront:messageLabel)
       // view.bringSubview(toFront:topbar)
    
        
    }
    //qr kodu tanıdığında bunu çağırır
    //Yöntemin ikinci parametresi (yani metadataObjects), okunan tüm meta veri nesnelerini içeren bir dizi nesnesidir. bu dizinin sıfır olmadığından ve en az bir nesne içerdiğinden emin olmak. Aksi takdirde, qrCodeFrameView boyutunu sıfır olarak sıfırlar ve messageLabel öğesini varsayılan mesajına ayarlarız.
    func metadataOutput(_ output:AVCaptureMetadataOutput, didOutput metadataObjects:[AVMetadataObject],from connection: AVCaptureConnection){
        // Check if the metadataObjects array is not nil and it contains at least one object.
        if metadataObjects.count == 0 {
            qrCodeFrameView?.frame = CGRect.zero
            print("qr algılanamadı")
           // messageLabel.text = "QR kodu algılanmadı"
            return
        }
        
        // Meta veri nesnesi
        let metadataObj = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
        
        if metadataObj.type == AVMetadataObject.ObjectType.qr {
            //  Bulunan meta veriler, QR kodu meta verilerine eşitse, durum etiketinin metnini güncelleyin ve sınırları ayarlayın.
            let barCodeObject = videoPreviewLayer?.transformedMetadataObject(for: metadataObj)
            qrCodeFrameView?.frame = barCodeObject!.bounds
            
            //Son olarak, QR kodun okunabilir bilgilere çözüyoruz.
            // Kodlanan bilgilere bir AVMetadataMachineReadableCode nesnesinin stringValue özelliği kullanılarak erişilebilir.
            if metadataObj.stringValue != nil {
                //messageLabel.text = metadataObj.stringValue
 
                var value = metadataObj.stringValue
                captureSession.stopRunning();
                if((value?.count)!>0){
                    print(value!)
                
                  print(value?.count)
                
                    var fullNameArr = value?.components(separatedBy: "#->")
               
                var key:String = String((fullNameArr?[0])!)
                print("key \(key)")
                  
                    if key == "qrpay"{
                         var i=1
                        print("gelendizi \(fullNameArr?[1])")
                        for _ in 1...((fullNameArr?.count)!-1){
                            print("boyutu \(fullNameArr?.count)")
                            var yeniArr = fullNameArr?[i].components(separatedBy: "#-/")
                     
                            var ordercode = yeniArr?[0].components(separatedBy: "#-:")
                            var ordercode1=ordercode?[1]
                            var productname = yeniArr?[1].components(separatedBy: "#-:")
                            var productname1:String = String((productname?[1])!)
                            var shoppingid = yeniArr?[2].components(separatedBy: "#-:")
                            var shoppingid1:Int=Int(String((shoppingid?[1])!))!
                            print(ordercode1)
                            print(productname1)
                            print(shoppingid1)
                            
                        
                           
                            userorderinfo.Order_Code=String(ordercode1!)
                            userorderinfo.Order_Product_Name=productname1
                            userorderinfo.Shopping_Box_ID=Int(shoppingid1)
                           
                            postUserJson(userorderInfo: userorderinfo)
                           
                             i+=1
                        }
                        
                        self.performSegue(withIdentifier: "shoppingbox", sender: self)

                       
                    }
               
                    
                    
                  
                    
                }
            }
        }}
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func postUserJson(userorderInfo:User_Order_Info){
        
        let url="http://qrparam.net/User_Order_Info/QRKontrol/?Order_Code="+String(userorderInfo.Order_Code)+"&Order_Product_Name="+userorderInfo.Order_Product_Name
        let url1="&Shopping_Box_ID="+String(userorderInfo.Shopping_Box_ID)
        let totalurl=url+url1
        let correctURL = totalurl.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
        print(correctURL)
        Alamofire.request(correctURL!,method: .get).validate().responseJSON{
            response in
            
            switch(response.result){
                
            case .success(let value):
                let json=JSON(value)
                
                self.postUserJson1(userorderInfo:userorderInfo)
                /*  if json.count>0
                 {
                 let storyboard=UIStoryboard(name: "Main", bundle: nil)
                 let vc=storyboard.instantiateViewController(withIdentifier: "LoginVc")
                 self.present(vc,animated: true,completion: nil);
                 }*/
                
            case .failure(let error):
                print(error)
                
                
                
            }
        }
        
    }
    
    func postUserJson1(userorderInfo:User_Order_Info){
        
    let userid=UserDefaults.standard.string(forKey: "userıd")
        let url="http://qrparam.net/User_Credentials/IDGetir/?User_ID="+userid!+"&Order_Code="+String(userorderInfo.Order_Code)
        
  
        
        let correctURL = url.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
        print(correctURL)
        Alamofire.request(correctURL!,method: .get).validate().responseJSON{
            response in
            
            switch(response.result){
                
            case .success(let value):
                let json=JSON(value)
              
               
                
            case .failure(let error):
                print(error)
                
                
                
            }
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
     if(segue.identifier == "shoppingbox"){
    
    guard let vc = segue.destination as? QrOrderViewController else{return}
    
        
        vc.Order_Code=String(userorderinfo.Order_Code)
        
        }
    }
}
