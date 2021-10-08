//
//  SingletonClass.swift
//  InfoiedTask
//
//  Created by VENKSTESHKSTL on 07/10/21.
//

import Foundation
import UIKit

class SingleToneClass: NSObject {

    static let shared = SingleToneClass()
    
    override init() {
        
    }
    
    
    func showValidationAlert(target : UIViewController, title : String, message : String, OntapOkButton : @escaping (() -> Void))  {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel) { (okayAction) in
            
            OntapOkButton()
            
        }
        alert.addAction(okAction)
        DispatchQueue.main.async {
            target.present(alert, animated: true, completion: nil)
        }
        
    }
    
    
    
}
