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
    @IBOutlet weak var foodPrice: UILabel!
    @IBOutlet weak var foodWait: UILabel!
    @IBOutlet weak var addFood: UIButton!
    
    var fPrice: Double = 0.0
    var fWait: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        foodPrice.text = "$" + String(format: "%.02f", fPrice)
        foodWait.text = String (fWait) + " Minutes"
        
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

    @IBAction func addFoodTap(sender: AnyObject) {
        addFood.hidden = true
        
        let alertController = UIAlertController(title: "Yum!", message:
            "Your food was added!", preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "Awesome!", style: UIAlertActionStyle.Default,handler: nil))
        self.presentViewController(alertController, animated: true, completion: nil)
        
        totalAmount += fPrice
        totalTime += fWait
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

        let mapViewController = segue.destinationViewController as! MapViewController
        mapViewController.location = image
        
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }

}
