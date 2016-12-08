//
//  TagCollectionViewCell.swift
//  StackOverflow
//
//  Created by Madhu on 07/12/16.
//  Copyright © 2016 com.task. All rights reserved.
//

import UIKit

class TagCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var viewTagcontainer: UIView!
    @IBOutlet weak var lblTag: UILabel!
    
    override func awakeFromNib() {
        self.contentView.setNeedsLayout()
        self.viewTagcontainer.layer.cornerRadius = 14
        self.viewTagcontainer.layer.borderColor = UIColor.lightGray.cgColor
        self.viewTagcontainer.layer.borderWidth = 1.0
        
    }
    
    
}
