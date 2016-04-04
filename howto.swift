//
//  howto.swift
//  Heads_up
//
//  Created by inada on 2016/01/18.
//  Copyright © 2016年 inada. All rights reserved.
//

import Foundation
import UIKit

class howto:UIViewController{
    
    
    @IBAction func button(sender: AnyObject) {
        let nextVC = self.storyboard?.instantiateViewControllerWithIdentifier("howto2")
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

