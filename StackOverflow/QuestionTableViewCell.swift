//
//  QuestionTableViewCell.swift
//  StackOverflow
//
//  Created by Madhu on 06/12/16.
//  Copyright © 2016 com.task. All rights reserved.
//

import UIKit

class QuestionTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var lblUpvote: UILabel!
    
    @IBOutlet weak var lblUpvoteCount: UILabel!
    
    @IBOutlet weak var lblQuestionDesc: UILabel!
    
    @IBOutlet weak var lblUserAndTime: UILabel!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var constraintCollectionViewHeight: NSLayoutConstraint!

    override func awakeFromNib() {
        super.awakeFromNib()
       
        self.lblUpvote.text = "\u{f0d8}"
        self.contentView.layoutIfNeeded()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
//    override func systemLayoutSizeFitting(_ targetSize: CGSize, withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority, verticalFittingPriority: UILayoutPriority) -> CGSize {
//        self.collectionView.frame = CGRect(x: 0, y: 0, width: targetSize.width, height: CGFloat(MAXFLOAT))
//        self.collectionView.layoutIfNeeded()
//        print(self.collectionView.collectionViewLayout.collectionViewContentSize)
//        return  self.collectionView.collectionViewLayout.collectionViewContentSize
//
//    }
    
}
