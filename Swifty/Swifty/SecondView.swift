//
//  SecondView.swift
//  Swifty
//
//  Created by Keegan KINNEAR on 2018/10/28.
//  Copyright © 2018 Keegan KINNEAR. All rights reserved.
//

import UIKit
import SwiftyJSON

class SecondView: UIViewController{
    
    
    

    //SecondView Variable Declarations
    
    @IBOutlet weak var UserImage: UIImageView!
    
   
    @IBOutlet weak var DisplayName: UILabel!
    
    
    @IBOutlet weak var MyUsername: UILabel!
    
    
    @IBOutlet weak var UserEmail: UILabel!
    
    
    @IBOutlet weak var UserCorrectPoints: UILabel!
    


    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        _ = SearchModel.username
        
    }

    
    
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        let url = URL(string: "https://api.intra.42.fr/v2/users/\(SearchModel.username)")
        
        var request = URLRequest(url: url!)
        
        let session  = URLSession.shared
        
        request.setValue("Bearer \(SearchModel.token)", forHTTPHeaderField: "Authorization")
        
        request.httpMethod = "GET"
        
        session.dataTask(with: request) { (data, response, err) in
            
            if let jsonData = try? JSONSerialization.jsonObject(with: data!, options: []) as! [String: Any?]
            {
            
            
    //            print(jsonData ?? "No data")
    //            print(response as Any)
                
                //image
                DisplayModel.image = String((jsonData["image_url"] as? String)!)
                
                //full name
                DisplayModel.displayname = "Name: " + (jsonData["displayname"] as? String)!
                
                //username
                DisplayModel.myUsername = "Username: " + (jsonData["login"] as? String)!
                
                //email
                DisplayModel.email = "Email: " + String((jsonData["email"] as? String)!)
                
                //Correction Points
                DisplayModel.correctionPoints = (jsonData["correction_point"]) as! Int
                
                //phone number
    //            DisplayModel.phone = String((jsonData!["cursus_users"]![0]["level"] as? String)!)

            
            
            
                self.updateInformation()
                }
                else{
                     self.createAlert(title: "UNKNOWN", Message: "You Entered an incorrext Username, please eneter a different Username")
                }
            
            }.resume()
        
//        print ("\n\n\n"+DisplayModel.myUsername+"\n\n\n")
    }
    
    
    func updateInformation()
    {
        self.DisplayName.text! = DisplayModel.displayname
        
        self.MyUsername.text! = DisplayModel.myUsername
        
        self.UserCorrectPoints.text! = "Correction Points: \(DisplayModel.correctionPoints)"
        
//        self.UserLevel.text! = DisplayModel.phone
        self.UserEmail.text! = DisplayModel.email
        
        if let url = URL(string: DisplayModel.image)
        {
            do {
                let data = try Data(contentsOf: url)
                self.UserImage.image = UIImage(data: data)
            } catch let err {
                print (" Error: \(err.localizedDescription)")
            }
        }
    }
    
    
    
    func createAlert (title:String, Message:String)
    {
        let alert = UIAlertController(title: title, message: Message, preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
        }))
        
        
        self.present(alert, animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
