//
//  AngleListTableViewController.swift
//  Hackathon
//
//  Created by Kan Chen on 4/14/15.
//  Copyright (c) 2015 NYU-poly. All rights reserved.
//

import UIKit

class AngleListTableViewController: UITableViewController {
    
    struct CellData {
        var jobTitle:String
        var company: String
        var logoURL: String
    }
    
    var myData: [CellData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        for i in 1...1{
            var requestItem = request(.GET, "https://api.angel.co/1/jobs?access_token=ea35df8ec5d8542d06b196d4a50bba2ac34616d448bfd3c0&page=\(i)")
            
            requestItem.responseJSON{
                (request,response,data,error) in
                var json = JSON(data!)
//                println(self.json)
                
                for (key: String, subJson: JSON) in json["jobs"] {
                    var newData: CellData?
                    
                    //Job info
                    let jobTitle = subJson["title"].string ?? ""
                    let jobDesc = subJson["description"].string ?? ""
                    var tags = [String]()
                    for (keyTag: String, tag: JSON) in subJson["tags"]{
                        tags.append(tag["display_name"].string ?? "")
                    }
                    let createAt = subJson["created_at"].string ?? ""
                    let jobType = subJson["job_type"].string ?? ""
                    //                println("tag:\(tags)")
//                    newData.jobTitle = jobTitle
                    //company info
                    if subJson["startup"] != nil{
                        let companyName = subJson["startup"]["name"].string ?? ""
                        let img = subJson["startup"]["logo_url"].string ?? "no image"
                        let smallImg = subJson["startup"]["thumb_url"].string ?? ""
                        let companyShortDesc = subJson["startup"]["high_concept"].string ?? ""
                        
                        let companyURL = subJson["startup"]["company_url"].string ?? ""
                        let companyFullDesc = subJson["startup"]["product_desc"].string ?? ""
                        // println("Description:\(jobDesc)")
                        //println("url_logo:\(img)")
                        //println("company_short_concept:\(companyShortDesc)")
                        newData = CellData(jobTitle: jobTitle, company: companyName, logoURL: img)
//                        newData.company = companyName
//                        newData.logoURL = img
                    }
                    if newData != nil {
                        self.myData.append(newData!)
                    }
                }
                
                self.tableView.reloadData()
            }//end closure
        }
        

    }

    

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return self.myData.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("protojob", forIndexPath: indexPath) as! UITableViewCell

        // Configure the cell...
        cell.textLabel?.text = myData[indexPath.row].jobTitle
        return cell
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
