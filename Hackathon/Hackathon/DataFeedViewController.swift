//
//  DataFeedViewController.swift
//  Hackathon
//
//  Created by xi su on 4/14/15.
//  Copyright (c) 2015 NYU-poly. All rights reserved.
//

import UIKit
import UIKit
//import Alamofire
class DataFeedViewController: UIViewController {
    
    var json:[JSON] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        for i in 0...9{
            var requestItem = request(.GET, "https://api.angel.co/1/jobs?access_token=ea35df8ec5d8542d06b196d4a50bba2ac34616d448bfd3c0&page=\(i)")
            
            requestItem.responseJSON{
                (request,response,data,error) in
                self.json[i] = JSON(data!)
                println(self.json)
                
                for (key: String, subJson: JSON) in self.json[i]["jobs"] {
                    
                    //Job info
                    let jobTitle = subJson["title"].string ?? ""
                    let jobDesc = subJson["description"].string ?? ""
                    var tags = [String]()
                    for (keyTag: String, tag: JSON) in subJson["tags"]{
                        tags.append(tag["display_name"].string ?? "")
                    }
                    let createAt = subJson["created_at"].string ?? ""
                    let jobType = subJson["job_type"].string ?? ""
                                    println("tag:\(tags)")
                    
                    //company info
                    if subJson["startup"] != nil{
                        let companyName = subJson["startup"]["name"].string ?? ""
                        let img = subJson["startup"]["logo_url"].string ?? "no image"
                        let smallImg = subJson["startup"]["thumb_url"].string ?? ""
                        let companyShortDesc = subJson["startup"]["high_concept"].string ?? ""
                        
                        let companyURL = subJson["startup"]["company_url"].string ?? ""
                        let companyFullDesc = subJson["startup"]["product_desc"].string ?? ""
                         println("Description:\(jobDesc)")
                        println("url_logo:\(img)")
                        println("company_short_concept:\(companyShortDesc)")
                    }
                    
                    
                }
                
                
            }
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
