//
//  SecondView.swift
//  Swifty
//
//  Created by Keegan KINNEAR on 2018/10/28.
//  Copyright © 2018 Keegan KINNEAR. All rights reserved.
//

import UIKit
import SwiftyJSON

class SecondView: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // tableview Declarations...

    @IBOutlet weak var Skills_View: UITableView!
    
    
    @IBOutlet weak var Projects_View: UITableView!
    
    @IBOutlet weak var Personal_View: UITableView!
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        if tableView == Skills_View
        {
            return (SkillsModel.skills_name.count)
        }
        else if Projects_View == tableView
        {
            return (ProjectModel.projects_name.count)
        }
        else
        {
            print("\n\n\nPersonals count\(PersonalModel.personals.count)\n\n\n")
            return (PersonalModel.personals.count)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if tableView == Skills_View
        {
            let Skills = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "skills")
            Skills.textLabel!.text = "\(SkillsModel.skills_name[indexPath.row]): \(String(describing:SkillsModel.skills_level[indexPath.row]))%"
            return (Skills)
        }
        else if tableView == Projects_View
        {
            let Projects = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "projects")
            Projects.textLabel!.text = "\(ProjectModel.projects_name[indexPath.row])"
            return (Projects)
        }
        else
        {
            let Personals = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "personals")
            print ("\n\n\nPersonals print\(PersonalModel.personals[indexPath.row])\n\n\n")
            Personals.textLabel!.text = "\(PersonalModel.personals[indexPath.row])"
            return (Personals)
        }
        
    }
    
    func CallDelegate()
    {
        Personal_View.delegate = self
        Personal_View.dataSource = self
        Skills_View.delegate = self
        Skills_View.dataSource = self
        Projects_View.delegate = self
        Projects_View.dataSource = self
    }
    
    

    //SecondView Variable Declarations
    
    @IBOutlet weak var UserImage: UIImageView!
    
   

    @IBOutlet weak var User_Level: UILabel!
    


    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        _ = SearchModel.username
//        CallDelegate()
        
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
        
        if SearchModel.username != ""
        {
            session.dataTask(with: request) { (data, response, err) in
                
            let jsonData = try? JSONSerialization.jsonObject(with: data!, options: []) as! [String: Any?]
                
                
            let count = Int((jsonData!.count))
            if  count != 0
            {
                
                print ("\n\n\nJsonData\n\n\(jsonData! as NSDictionary)\n\n\n")
                    //image
                ProjectModel.image = String((jsonData!["image_url"] as? String)!)
              
                    
                
                
                PersonalModel.personals[0] = "Username: " + (jsonData!["login"] as? String)!
                PersonalModel.personals.append("Name: " + (jsonData!["displayname"] as? String)!)
                PersonalModel.personals.append("Email: " + String((jsonData!["email"] as? String)!))
                
                    //Correction Points
                PersonalModel.correctionPoints = (jsonData!["correction_point"]) as! Int
                PersonalModel.personals.append("Correction: " + String(PersonalModel.correctionPoints))
                
                
                /*
                ** Now we will use the JSON data and create a dictionary of
                ** the cursus_users array from the JSON object in order to access
                ** the elements that we want
                */
                
                
                let curses_users = jsonData?["cursus_users"] as? [NSDictionary]
                
                // Here we will assign the user cursus Level
                ProjectModel.userLevel = curses_users?[0]["level"] as! Double
               
                
                print ("\n\n\nuser_curses: \(String(describing: ProjectModel.userLevel))\n\n\n")
                var i = 0;
                print(SkillsModel.skills_name.count)
                print(SkillsModel.skills_level.count)
                
                // Here we will iterate through the array of skills to find
                // the skills name and the skills level
                for elem in curses_users?[0]["skills"] as! [NSDictionary]
                {
                    print("\n\n\nElem: \(String(describing: elem["name"]!))")
                    if i == 0
                    {
                        SkillsModel.skills_name[0] = elem["name"]! as! String
                        SkillsModel.skills_level[0] = elem["level"]! as! Double
                        print ("at 0: \(SkillsModel.skills_name)")
                        print ("at 0: \(SkillsModel.skills_level)")
                    }
                    else
                    {
                        SkillsModel.skills_name.append(elem["name"]! as! String)
                        SkillsModel.skills_level.append(elem["level"]! as! Double)
                        print ("appended: \(SkillsModel.skills_name)")
                        print ("appended: \(SkillsModel.skills_level)")
                    }
                    print(SkillsModel.skills_name.count)
                    print(SkillsModel.skills_level.count)
                    print("Elem: \(String(describing: elem["level"]))\n\n")
                    i += 1
                }
                i = 0
                
                /*
                ** Here we will create a Dictionary of the projects_users
                ** in the JSON data in order for us to access the elements
                ** in the array in order to find the project level
                */
                
                let projects = jsonData?["projects_users"] as? [NSDictionary]
                
                // Assigning project LEVEL
//                print (DisplayModel.projects_level.count)
                
                for elem in (projects)!
                {
                    
//                    if i < 115
//                    {
                        if i == 0
                        {
                            let new = elem["project"] as! NSDictionary
                            print ("the new: \(new)")
                            let me = new.value(forKeyPath: "name")
                            ProjectModel.projects_name = [me! as! String]
                            print (ProjectModel.projects_name)
                        }
                        else
                        {
                            let new = elem["project"] as! NSDictionary
                            print ("the new: \(new)")
                            let me = new.value(forKeyPath: "name")
                            ProjectModel.projects_name.append(me! as! String)
                            print (ProjectModel.projects_name)
                        }
//
//
//
//                        DisplayModel.projects_level[i] = elem["final_mark"]! as? Double
//                        print (DisplayModel.projects_level)
//                        print ("at 0: \(DisplayModel.projects_level.count)")
//                    }
//
//                    print("\n\n\nElem: \(String(describing: elem["final_mark"]))")
                    i += 1
                }
               
                    self.updateInformation()
                }
                else
                {
                    self.createAlert(title: "UNKNOWN", Message: "You Entered an incorrext Username\nplease eneter a different Username")
                }
            
                }.resume()
            
            
        }
        else {
                     self.createAlert(title: "USERNAME", Message: "Text Field is Empty\nplease eneter a Username")
                }
    }
    
    
    func updateInformation()
    {
//        self.DisplayName.text! = DisplayModel.displayname
//
//        self.MyUsername.text! = DisplayModel.myUsername
//
//        self.UserCorrectPoints.text! = "Correction Points: \(DisplayModel.correctionPoints)"
//
////        self.UserLevel.text! = DisplayModel.phone
//        self.UserEmail.text! = DisplayModel.email
        
        if let url = URL(string: ProjectModel.image)
        {
            PersonalModel.personals.append("Level: " + String(describing: ProjectModel.userLevel) + "%")
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
    

}
