//
//  APIManager.swift
//  InfoiedTask
//
//  Created by VENKSTESHKSTL on 07/10/21.
//

import Foundation



typealias AnyObjectany = (_ response : AnyObject, _ error : Error?, _ statusCode: HTTPURLResponse?) -> Void




class APIManager: NSObject {

    static let sharedInstance = APIManager()


    var baseUrl = "https://reqres.in/api/"



    func apiSerciceCall(url : String, params : NSDictionary, method: HttpMethod, handler : @escaping AnyObjectany) {
        let url2 =  baseUrl + url
        print("url : \(url)")
        print("params : \(params)")
        HttpClient.instance().makeAPICallAuthorization(url: url2, params: params, method: method, success: { (data, response, error) in
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as AnyObject
            
                handler(json,error,(response))
            } catch let error as NSError {
                print(error.localizedDescription)
                handler(AnyObject.self as AnyObject,error,(response))
            }
        }, failure: { (data, response, error) in
            handler(AnyObject.self as AnyObject,error,(response))
        })
    }
    
    
    
    
    

}
