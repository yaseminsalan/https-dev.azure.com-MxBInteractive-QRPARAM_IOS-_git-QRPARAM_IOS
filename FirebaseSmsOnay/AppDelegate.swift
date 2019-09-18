//
//  AppDelegate.swift
//  FirebaseSmsOnay
//
//  Created by imac2 on 12/21/18.
//  Copyright © 2018 imac2. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {                 

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions:
        
        [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
       FirebaseApp.configure()
        if checkSMS(){
            print("Auth")
            if(checkSignUp()){
                    let vc  = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "LoginVc")
                    
                    let navVC = UINavigationController(rootViewController: vc)
                    let share = UIApplication.shared.delegate as? AppDelegate
                    share?.window?.rootViewController = navVC
                    share?.window?.makeKeyAndVisible()
                
            }
            else if(savelogin()){
                let vc  = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "LoginVc")
                
                let navVC = UINavigationController(rootViewController: vc)
                let share = UIApplication.shared.delegate as? AppDelegate
                share?.window?.rootViewController = navVC
                share?.window?.makeKeyAndVisible()
            }
            else{
                let vc  = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SignUp")
                
                let navVC = UINavigationController(rootViewController: vc)
                let share = UIApplication.shared.delegate as? AppDelegate
                share?.window?.rootViewController = navVC
                share?.window?.makeKeyAndVisible()
            }
        }
        else{
            print("Any Auth")
            let vc  = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ViewVc")
            
            let navVC = UINavigationController(rootViewController: vc)
            let share = UIApplication.shared.delegate as? AppDelegate
            share?.window?.rootViewController = navVC
            share?.window?.makeKeyAndVisible()
        }
        if #available(iOS 10, *){
            UNUserNotificationCenter.current().requestAuthorization(options: [.badge, .sound, .alert], completionHandler: { (granted, error) in  })
            application.registerForRemoteNotifications()
        }else{
            let notificationSettings = UIUserNotificationSettings(types: [.badge, .alert, .sound], categories: nil)
            UIApplication.shared.registerUserNotificationSettings(notificationSettings)
            UIApplication.shared.registerForRemoteNotifications()
        }
        return true
    }
    
    func checkSMS() -> Bool{
        if UserDefaults.standard.bool(forKey: "islogged") == true{
            return true
        }
        else{
        return false
        }
    }
    
    func checkSignUp()->Bool{
        if UserDefaults.standard.bool(forKey: "isSignUp") == true {
            return true
        }
        else {
            return false
        }
    }
    func savelogin() -> Bool{
        if UserDefaults.standard.bool(forKey: "kayıtlıhesap") == true{
            return true
        }
        else{
            return false
        }
    }
    func checkLogin()->Bool{
        
        if UserDefaults.standard.value(forKey: "isLogin") != nil{
            return true
        }
        else {
            print("deneme")
            return false
        }
    }
    
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        
        
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

