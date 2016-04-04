//
//  howto2.swift
//  Heads_up
//
//  Created by inada on 2016/01/21.
//  Copyright © 2016年 inada. All rights reserved.
//

import Foundation
import UIKit

class howto2:UIViewController{
    
    
    @IBAction func btn1(sender: AnyObject) {
        let nextVC = self.storyboard?.instantiateViewControllerWithIdentifier("howto3")
        nextVC?.modalTransitionStyle = .CrossDissolve
        presentViewController(nextVC!, animated:true, completion:nil)
        
    }
    
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

class howto3:UIViewController{
    
    @IBAction func btn2(sender: AnyObject) {
        let nextVC = self.storyboard?.instantiateViewControllerWithIdentifier("howto4")
        nextVC?.modalTransitionStyle = .CrossDissolve
        presentViewController(nextVC!, animated:true, completion:nil)
        
        }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}

class howto4:UIViewController{
    
    @IBAction func btn3(sender: AnyObject) {
        let nextVC = self.storyboard?.instantiateViewControllerWithIdentifier("menu")
        nextVC?.modalTransitionStyle = .CrossDissolve
        presentViewController(nextVC!, animated:true, completion:nil)
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}

