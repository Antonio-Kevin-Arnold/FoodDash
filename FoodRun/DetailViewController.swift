//
//  DetailViewController.swift
//  FoodRun
//
//  Created by Kevin Ho on 4/14/16.
//  Copyright © 2016 KevinHo. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var image: NSDictionary!
    
    @IBOutlet weak var foodImage: UIImageView!
    @IBOutlet weak var foodLocation: UILabel!
    @IBOutlet weak var foodItem: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let image1 = image["images"] as! [String: AnyObject]
        let image2 = image1["standard_resolution"] as! [String: AnyObject]
        let image3 = image2["url"] as! String
        let imageUrl = NSURL(string: image3)
        foodImage.setImageWithURL(imageUrl!)
        
        let nameInLocation = image["location"]
        if (nameInLocation!["name"] != nil)
        {
            let location1 = image["location"] as! [String: AnyObject]
            let location2 = location1["name"] as! String
            foodLocation.text = location2
        }
        
        let textInCaption = image["caption"]
        if (textInCaption!["text"] != nil)
        {
            let item1 = image["caption"] as! [String: AnyObject]
            let item2 = item1["text"] as! String
            foodItem.text = item2
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