//
//  SummaryViewController.swift
//  FoodRun
//
//  Created by Kevin Ho on 4/19/16.
//  Copyright © 2016 KevinHo. All rights reserved.
//

import UIKit

var totalAmount: Double = 0.0
var totalTime: Int = 0

class SummaryViewController: UIViewController {

    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var tax: UILabel!
    @IBOutlet weak var totalPrice: UILabel!
    @IBOutlet weak var totalWait: UILabel!

    let nycTax: Double = 0.08875
    
    override func viewDidLoad() {
        super.viewDidLoad()

        price.text = "$" + String(format: "%.02f", totalAmount)
        tax.text = "$" + String(format: "%.02f", (totalAmount * nycTax))
        totalPrice.text = "$" + String(format: "%.02f", (totalAmount * (1 + nycTax)))
        totalWait.text = String (totalTime) + " Minutes"
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onResetTap(sender: AnyObject) {
        totalAmount = 0.0
        totalTime = 0
        
        price.text = "$" + String(format: "%.02f", totalAmount)
        tax.text = "$" + String(format: "%.02f", (totalAmount * nycTax))
        totalPrice.text = "$" + String(format: "%.02f", (totalAmount * (1 + nycTax)))
        totalWait.text = String (totalTime) + " Minutes"
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
