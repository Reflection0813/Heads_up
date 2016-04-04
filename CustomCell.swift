//
//  CustomCell.swift
//  Heads_up
//
//  Created by inada on 2016/02/02.
//  Copyright © 2016年 inada. All rights reserved.
//


import UIKit

class CustomCell: UICollectionViewCell {
    @IBOutlet var imgSample:UIImageView!
    
    
    override init(frame: CGRect){
        super.init(frame: frame)
    }
    required init(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)!
        
    }
}