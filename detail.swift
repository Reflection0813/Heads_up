//
//  detail.swift
//  Heads_up
//
//  Created by inada on 2016/01/21.
//  Copyright © 2016年 inada. All rights reserved.
//

import Foundation
import UIKit

class detail: UIViewController{
    
    var appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as!AppDelegate
    var i = 0   //カウンター
    
    @IBOutlet weak var detail: UILabel!
    
    @IBAction func back(sender: AnyObject) {
        
        let nextVC = self.storyboard?.instantiateViewControllerWithIdentifier("result")
        nextVC?.modalTransitionStyle = .CrossDissolve
        presentViewController(nextVC!, animated:true, completion:nil)
        
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var i = 0
        
        for elem in appDelegate.result{
            detail.text = detail.text! + elem + appDelegate.detail[i] + "\n"
            i++
            if i == appDelegate.detail.count{
                break
            }
            
        }
        
    }
}
    