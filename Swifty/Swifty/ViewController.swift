//
//  ViewController.swift
//  Swifty
//
//  Created by Keegan KINNEAR on 2018/10/22.
//  Copyright © 2018 Keegan KINNEAR. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var token:String?
    var json:String?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        
        /* we are about to start requesting a token
        ** This token will be retreived via request
        ** to the 42 API
        */
        
        let url = URL(string: "https://api.intra.42.fr/oauth/token?grant_type=client_credentials&client_id=86a52c673070f11f684330846de817e703c3c766d48616f50e4224577fa598a9&client_secret=15313b470f16560ba4c72f85c4d4a119c8c385e0466aabbf26a3bc69ec801020")
        
        var request = URLRequest(url: url!)
        
        let session  = URLSession.shared
        
        request.httpMethod = "POST"
        
//        request.setValue("Bearer " + self.token!, forHTTPHeaderField: "Authentication")
        
        
        session.dataTask(with: request) { (data, response, err) in
            
            let jsonData = try? JSONSerialization.jsonObject(with: data!, options: []) as! [String: Any?]
            
            self.token = jsonData!["access_token"] as? String
            
            Globals.token = jsonData!["access_token"] as? String
            
            print(jsonData ?? "No data")
            print(response as Any)
            
            print (self.token!)
        }.resume()

    }
    
    
    
    //we prepare for segue, so when we skip to second view
    //the data gets updated first
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
//    {
//        let SecondViewController = segue.destination as! user_page
//
//        SecondViewController.myToken = self.token!
//        SecondViewController.myUsername = self.json!
//    }
    
    @IBOutlet weak var TextField: UITextField!
    
    
    
    
    @IBAction func fetchData(_ sender: Any) {
        Globals.username =  TextField.text!
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

