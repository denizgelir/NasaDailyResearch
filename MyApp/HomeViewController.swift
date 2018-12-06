//
//  HomeViewController.swift
//  MyApp
//
//  Created by Deniz Gelir on 12/4/18.
//  Copyright © 2018 Deniz Gelir. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire
import SVProgressHUD

class HomeViewController: UIViewController {

    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var textView: UITextView!
    @IBOutlet var nasaImage: UIImageView!
    
    let NASA_URL = "https://api.nasa.gov/planetary/apod?api_key=PJB1INkWd2sINxeVvlhWF5CbxPyO0AM2D64LsCWq"
    let APP_ID = "PJB1INkWd2sINxeVvlhWF5CbxPyO0AM2D64LsCWq"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getData(url: NASA_URL)
        textView.isEditable = false
        titleLabel.text = ""
        textView.text = ""
        dateLabel.text = ""
       
        
    }
    
           //NETWORKING
    func getData (url : String){
        SVProgressHUD.show()
        Alamofire.request(url,method: .get).responseJSON{
            response in
            if response.result.isSuccess{
                SVProgressHUD.dismiss()
                print("Success! Got the data")
                let nasaJSON :JSON = JSON(response.result.value!)
                self.updateData (json : nasaJSON)
                self.getImage()
            }
            else{
                print("Error : \(String(describing: response.result.error))")
                
            }
            
        }
    }
    
        //JSON Parsing
    func updateData (json : JSON) {
            titleLabel.text = json["title"].stringValue
            textView.text = json["explanation"].stringValue
            dateLabel.text = json["date"].stringValue
    }
    
       //GETTING IMAGE FROM API
    func getImage () {
        let imageURL = NSURL(string: "https://api.nasa.gov/planetary/apod?api_key=PJB1INkWd2sINxeVvlhWF5CbxPyO0AM2D64LsCWq")
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let task = session.dataTask(with: NSURLRequest(url: imageURL! as URL) as URLRequest)
        {
            (data,response,error) -> Void  in
            
            if error == nil {
                let myJSON = try! JSON(data: data!)
                let theImageArray = myJSON["url"].string!
                let theImageUrl = NSURL(string : theImageArray)
                if let ImageData = NSData (contentsOf: theImageUrl! as URL) {
                    self.nasaImage.image = UIImage(data: ImageData as Data)
                }
            }
        }
        task.resume()
        
    }
    
    
    
    
}
