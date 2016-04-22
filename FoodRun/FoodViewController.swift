//
//  LoginViewController.swift
//  FoodRun
//
//  Created by Kevin Ho on 4/2/16.
//  Copyright © 2016 KevinHo. All rights reserved.
//

import UIKit
import AFNetworking
import MBProgressHUD

class FoodViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var images: [NSDictionary]?
    
    var price: Double = 5.00
    var wait: Int = 30
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(FoodViewController.refreshControlAction(_:)), forControlEvents: UIControlEvents.ValueChanged)
        tableView.insertSubview(refreshControl, atIndex: 0)
        
        tableView.backgroundView = nil;
        
        tableView.dataSource = self
        tableView.delegate = self
        
        let url = NSURL(string: "https://api.instagram.com/v1/users/338693018/media/recent/?access_token=2253563781.137bf98.bd1c3693d2b84f80a7ab8d661f641437&count=33")
        
        let request = NSURLRequest(URL: url!)
        let session = NSURLSession(
            configuration: NSURLSessionConfiguration.defaultSessionConfiguration(),
            delegate: nil,
            delegateQueue: NSOperationQueue.mainQueue()
        )
        
        MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        
        let task: NSURLSessionDataTask = session.dataTaskWithRequest(request,
            completionHandler: { (dataOrNil, response, error) in
                    if let data = dataOrNil {
                        if let responseDictionary = try! NSJSONSerialization.JSONObjectWithData (data, options:[]) as? NSDictionary {
                
                            self.images = responseDictionary["data"] as? [NSDictionary]
                            MBProgressHUD.hideHUDForView(self.view, animated: true)
                            
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
        
        if (cell.highlighted == true)
            {
                print("hi")
            }
        
        let image = images![indexPath.row]
        
            let image1 = image["images"] as! [String: AnyObject]
            let image2 = image1["standard_resolution"] as! [String: AnyObject]
            let image3 = image2["url"] as! String
        
        let imageUrl = NSURL(string: image3)
            cell.foodView.setImageWithURL(imageUrl!)

        return cell
    }
    
    func refreshControlAction(refreshControl: UIRefreshControl) {
        tableView.dataSource = self
        tableView.delegate = self
        self.tableView.reloadData()
        refreshControl.endRefreshing()
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

        let whoIsSender = (sender is UITableViewCell ? true : false)
        
        if whoIsSender {
            let cell = sender as! UITableViewCell
            let indexPath = tableView.indexPathForCell(cell)
            let image = images! [indexPath!.row]
            
            let detailViewController = segue.destinationViewController as! DetailViewController
            detailViewController.image = image
            
            detailViewController.fPrice = price
            detailViewController.fWait = wait
            
        }
    }
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
}
