//
//  LoginViewController.swift
//  FoodRun
//
//  Created by Kevin Ho on 4/2/16.
//  Copyright © 2016 KevinHo. All rights reserved.
//

import UIKit
import AFNetworking

class FoodViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var images: [NSDictionary]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        let url = NSURL(string: "https://api.instagram.com/v1/users/338693018/media/recent/?access_token=2253563781.137bf98.bd1c3693d2b84f80a7ab8d661f641437")
        
        let request = NSURLRequest(URL: url!)
        let session = NSURLSession(
            configuration: NSURLSessionConfiguration.defaultSessionConfiguration(),
            delegate: nil,
            delegateQueue: NSOperationQueue.mainQueue()
        )
        
        let task: NSURLSessionDataTask = session.dataTaskWithRequest(request,
            completionHandler: { (dataOrNil, response, error) in
                    if let data = dataOrNil {
                        if let responseDictionary = try! NSJSONSerialization.JSONObjectWithData (data, options:[]) as? NSDictionary
                        {
                            //print(responseDictionary) // Print Statement
                            self.images = responseDictionary["data"] as? [NSDictionary]
                            self.tableView.reloadData()
                        }
                }
        })
        task.resume()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        if let images = images {
            return images.count
        } else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("FoodCell", forIndexPath: indexPath) as! FoodCell
        
        let image = images![indexPath.row]
        
            let image1 = image["images"] as! [String: AnyObject]
            let image2 = image1["low_resolution"] as! [String: AnyObject]
            let image3 = image2["url"] as! String
        
        let imageUrl = NSURL(string: image3)
            cell.foodView.setImageWithURL(imageUrl!)

        return cell
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
