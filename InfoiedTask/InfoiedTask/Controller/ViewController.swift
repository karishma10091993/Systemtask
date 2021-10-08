//
//  ViewController.swift
//  InfoiedTask
//
//  Created by VENKSTESHKSTL on 07/10/21.
//

import UIKit

class ViewController: UIViewController {

    private var responseArray = [DataModel]()
    let refreshControl = UIRefreshControl()
    let activityIndictor = UIActivityIndicatorView()
    var page = String()
    var per_page = String()
    @IBOutlet weak var tableView:UITableView!
    var appDelegate = UIApplication.shared.delegate as! AppDelegate
    var loadingData = false
    var pageCount = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
       
        
        
        self.activityIndictor.style = .large
        self.activityIndictor.color = .red
        self.refreshControl.addTarget(self, action: #selector(refresh), for: UIControl.Event.allTouchEvents)
        self.tableView.addSubview(refreshControl)
        self.view.addSubview(activityIndictor)
    }

    override func viewWillAppear(_ animated: Bool) {
       
        self.getUsersData(pageCount:self.pageCount)
    }
    
    @objc func refresh(){
        DispatchQueue.main.async {
            self.refreshControl.endRefreshing()
            self.tableView.reloadData()
           
        }
    }
    
    
    

   

}


extension ViewController:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if responseArray.count > 0 {
            return self.responseArray.count
        }else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        if self.responseArray.count > 0 {
        
            let dict = self.responseArray[indexPath.row]
            
            cell.firstlastNameLbl.text = dict.first_name + dict.last_name
            cell.emailLbl.text = dict.email
            if let url = URL(string: dict.avatarStr){
            cell.img.loadImage(fromURL: url, placeHolderImage: "AvatarImage")
               
            }else{
                cell.img.loadImage(fromURL: URL.init(string: "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg")!, placeHolderImage: "AvatarImage")
            }
        }
            
      
        
        return cell
    }
    
    

    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        if scrollView == self.tableView{
            
            if ((scrollView.contentOffset.y + scrollView.frame.size.height) >= scrollView.contentSize.height)
            {
                self.pageCount += 1
                print("page count : \(self.pageCount)")
                self.getUsersData(pageCount: pageCount)
                self.refreshControl.endRefreshing()
                
                
            }
        }
    
    }
}


extension ViewController{
    //https://reqres.in/api/users
    
    
    
    func getUsersData(pageCount:Int){
        
        if self.appDelegate.isInternetAvailable(){
            
            self.activityIndictor.startAnimating()
            
            let query = ["page":"\(pageCount)","per_page":"\(8)"] as NSDictionary
            APIManager.sharedInstance.apiSerciceCall(url: "users", params: query, method: HttpMethod.GET) { (response, error, httpUrlResponse) in
                if (error != nil){
                    print("Error")
                }
                let statusCode = httpUrlResponse?.statusCode
                
                
                if statusCode == 200{
                    DispatchQueue.main.async {
                    self.activityIndictor.stopAnimating()
                    }
                    
                    if  let responseDa = response["data"] as? [[String:Any]]{
                        
                    if responseDa.count > 0 {
                    for i in responseDa{
                       
                        let data = DataModel.init(dict: i)
                        self.responseArray.append(data)
                    }
               
                 
                    DispatchQueue.main.async {
                        self.activityIndictor.stopAnimating()
                       
                     print("responseArray",self.responseArray)
                
                    self.tableView.reloadData()
                    }
                
                    }else{
                        DispatchQueue.main.async {
                        self.activityIndictor.stopAnimating()
                        SingleToneClass.shared.showValidationAlert(target: self, title: "", message: "No Data") {}
                        }
                    }
                        
                    }else{
                        DispatchQueue.main.async {
                        self.activityIndictor.stopAnimating()
                        SingleToneClass.shared.showValidationAlert(target: self, title: "", message: "No Data") {}
                        }
                    }
                        
                
            }else{
                
                DispatchQueue.main.async {
                    self.activityIndictor.stopAnimating()
                    SingleToneClass.shared.showValidationAlert(target: self, title: "", message: "No Response\(statusCode!))") {}
                }
                
            }
            
              
        }
            
        }else{
            
            DispatchQueue.main.async {
                self.activityIndictor.stopAnimating()
            SingleToneClass.shared.showValidationAlert(target: self, title: "", message: "Please Check your Internet Connection") {}
            }
            
            
        }
        
        
        
        
        
        
    }
    
    
    
    
}
