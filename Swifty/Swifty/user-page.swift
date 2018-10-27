//
//  user-page.swift
//  Swifty
//
//  Created by Keegan KINNEAR on 2018/10/27.
//  Copyright © 2018 Keegan KINNEAR. All rights reserved.
//

import UIKit

class user_page: UIViewController {

    //token asignment variables
    var myToken:String = String()
    @IBOutlet weak var tokenView: UILabel!
    
    //username assignment variables
    var myUsername:String = String()
    @IBOutlet weak var UsernameView: UILabel!
    
    var myLevel : Int = Int()
    @IBOutlet weak var LevelView: UILabel!
    
    
    @IBOutlet weak var UserImage: UIImageView!
    var myImage: Any?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //setting the labels to the correct data
        
        myToken = Globals.token!;
        myUsername = "Username: " + Globals.username!;
        
        tokenView.text = myToken
//        UsernameView.text = myUsername
        
        // Do any additional setup after loading the view.
    }

    
    
    //setting up all the data before displaying the view
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    //assigning all the data from the json so it can be displayed
    override func viewWillAppear(_ animated: Bool) {
        
        //takes the username from textfield saved in the Global struct
        let url = URL(string: "https://api.intra.42.fr/v2/users/\(Globals.username!)")
        
        var request = URLRequest(url: url!)
        
        let session  = URLSession.shared
        
        request.setValue("Bearer \(Globals.token!)", forHTTPHeaderField: "Authorization")
        
        request.httpMethod = "GET"
        
        session.dataTask(with: request) { (data, response, err) in
            
            let jsonData = try? JSONSerialization.jsonObject(with: data!, options: []) as! [String: Any?]
            
            print(jsonData ?? "No data")
            print(response as Any)
            self.myUsername = "Username: " + (jsonData!["login"] as? String)!
            var url_string: String = "https://cdn.intra.42.fr/users/\(Globals.username!).jpg"
                if var url = URL(string: url_string)
                {
                    do {
                        let data = try Data(contentsOf: url)
                        self.UserImage.image = UIImage(data: data)
                    } catch let err {
                        print (" Error: \(err.localizedDescription)")
                    }
                }
            
            
            }.resume()
        eventInfo()
        UsernameView.text = self.myUsername
    }

    func eventInfo()
    {
        let url = URL(string: "https://api.intra.42.fr/v2/users/\(Globals.username!)//graph(/on/:field(/by/:interval))")
        
        var request = URLRequest(url: url!)
        
        let session  = URLSession.shared
        
        request.setValue("Bearer \(Globals.token!)", forHTTPHeaderField: "Authorization")
        
        request.httpMethod = "GET"
        
        session.dataTask(with: request) { (data, response, err) in
            
            let jsonData = try? JSONSerialization.jsonObject(with: data!, options: []) as! [String: Any?]
            print("\n\n\n\n\\n\n\n\n")
            print(jsonData ?? "No data")
            print(response as Any)
            
        }.resume()
//        Globals.image = self.myImage
        print ("\n\n\n\(String(describing: Globals.image))\n\n\n")
    }
    
}

