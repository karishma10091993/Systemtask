//
//  HttpClient.swift
//  InfoiedTask
//
//  Created by VENKSTESHKSTL on 07/10/21.
//

import Foundation


enum HttpMethod : String{
    
    case POST
    case GET
    
}


class HttpClient{
    
    var request : URLRequest?
    var session : URLSession?
    
    static func instance() ->  HttpClient{
        
        return HttpClient()
    }
    
   
    
    
    func makeAPICallAuthorization(url: String,params: NSDictionary?, method: HttpMethod, success:@escaping ( Data? ,HTTPURLResponse?  , NSError? ) -> Void, failure: @escaping ( Data? ,HTTPURLResponse?  , NSError? )-> Void) {
        request = URLRequest(url: URL(string: url)!)
        
        print("======URL REQUEST======== ",url)
        if let params = params {
            
            let  jsonData = try? JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
         
            request?.setValue("application/json", forHTTPHeaderField: "Content-Type")
            if method == HttpMethod.GET{
            }else{
                request?.httpBody = jsonData
            }
        }
        request?.httpMethod = method.rawValue
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 30
        configuration.timeoutIntervalForResource = 30
        session = URLSession(configuration: configuration)
        
        session?.dataTask(with: request! as URLRequest) { (data, response, error) -> Void in
            if let data = data {
                if let response = response as? HTTPURLResponse, 100...500 ~= response.statusCode{
                    print("Status Code : \(response.statusCode)")
                }
                if let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode {
                    success(data , response , error as NSError?)
                } else {
                    failure(data , response as? HTTPURLResponse, error as NSError?)
                }
            }else{
                failure(data , response as? HTTPURLResponse, error as NSError?)
            }
            }.resume()
        
    }
    
    
    
    
    
    
    
    
}
