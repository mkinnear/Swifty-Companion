//
//  ViewController.swift
//  Swifty
//
//  Created by Keegan KINNEAR on 2018/10/28.
//  Copyright © 2018 Keegan KINNEAR. All rights reserved.
//

import UIKit
import SwiftyJSON

class ViewController: UIViewController {

    
    // Textfield Declaration..
    
    @IBOutlet weak var Search_TextField: UITextField!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let url = URL(string: "https://api.intra.42.fr/oauth/token?grant_type=client_credentials&client_id=86a52c673070f11f684330846de817e703c3c766d48616f50e4224577fa598a9&client_secret=15313b470f16560ba4c72f85c4d4a119c8c385e0466aabbf26a3bc69ec801020")
        
        var request = URLRequest(url: url!)
        
        let session  = URLSession.shared
        
        request.httpMethod = "POST"
        
        session.dataTask(with: request) { (data, response, err) in
            
            let jsonData = try? JSONSerialization.jsonObject(with: data!, options: []) as! [String: Any?]
            
            SearchModel.token = (jsonData!["access_token"] as? String)!
            
            print(jsonData ?? "No data")
            
            print(response as Any)
            
            print ("\n\nToken: "+SearchModel.token+"\n\n")
            
            }.resume()
        
    }

    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        _ = segue.destination as! SecondView
        
        if let text = self.Search_TextField.text
        {
            SearchModel.username = text
            print ("\n\n\nUsername: "+SearchModel.username)
        }
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

