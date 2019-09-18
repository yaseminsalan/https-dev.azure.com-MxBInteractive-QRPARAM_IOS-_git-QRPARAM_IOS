//
//  OdemelerTableViewController.swift
//  FirebaseSmsOnay
//
//  Created by imac2 on 9/5/19.
//  Copyright © 2019 imac2. All rights reserved.
//

import UIKit

class OdemelerTableViewController: UITableViewController {
    
    
    
    @IBOutlet weak var back: UIButton!
    

    @IBAction func back(_ sender: Any) {
        
        let storyboard :UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "HomePage") as! HomeViewController
        self.present(vc, animated: true, completion: nil)
        
    }
    
    @IBAction func btnelektirik(_ sender: Any) {
        
        
        let storyboard :UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "odemelerqr") as! OdemeqrViewController
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func btnsu(_ sender: Any) {
        let storyboard :UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "odemelerqr") as! OdemeqrViewController
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func btndogalgaz(_ sender: Any) {
        let storyboard :UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "odemelerqr") as! OdemeqrViewController
        self.present(vc, animated: true, completion: nil)
    }
    @IBAction func btnsgk(_ sender: Any) {
        let storyboard :UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "odemelerqr") as! OdemeqrViewController
        self.present(vc, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }



}
