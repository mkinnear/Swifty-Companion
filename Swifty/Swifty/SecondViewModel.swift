//
//  SecondViewModel.swift
//  Swifty
//
//  Created by Keegan KINNEAR on 2018/10/28.
//  Copyright © 2018 Keegan KINNEAR. All rights reserved.
//

import Foundation

struct  ProjectModel
{
    static var image: String = String()
    static var userLevel: Double = Double()
    // User Information
//    static var myUsername: String = String()
//    static var image: String = String()
//    static var displayname : String = String()
//    static var email : String = String()
//    static var correctionPoints : Int = Int()
//    // User Level
//    static var Userlevel : Double = Double()
//    // Skills
//    static var skills_name:[String] = [String()]
//    static var skills_level:[Double] = [Double()]
    // Projects
    static var projects_name:[String] = [String()]
//    static var projects_level = [Double?](repeating: nil, count: 115)
}

struct SkillsModel
{
    static var skills_name:[String] = [String()]
    static var skills_level:[Double] = [Double()]
    static var new_level: [String] = [String(describing: skills_level)]
}

struct PersonalModel
{
    static var myUsername: String = String()
    
    static var displayname : String = String()
    static var email : String = String()
    static var correctionPoints : Int = Int()
    
    static var personals = [myUsername, displayname, email, "\(correctionPoints)"]
//    static var Userlevel : Double = Double()

}
