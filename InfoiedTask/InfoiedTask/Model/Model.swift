//
//  Model.swift
//  InfoiedTask
//
//  Created by VENKSTESHKSTL on 07/10/21.
//

import Foundation

class DataModel{
    
    var first_name = String()
    var last_name = String()
    var email = String()
   
    var avatarStr = String()
    
    init(dict:[String:Any]) {
        self.first_name = dict["first_name"] as? String ?? ""
        self.last_name =  dict["last_name"] as? String ?? ""
        self.email =  dict["email"] as? String ?? ""
        
        
        self.avatarStr =  dict["avatar"] as? String ?? "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg"
        
        
        
    }
    
    
}
