//
//  Comment.swift
//  TestCollectionView
//
//  Created by Yaoqi Shou on 6/28/20.
//  Copyright © 2020 Yaoqi Shou. All rights reserved.
//

import UIKit

class Comment: UITableViewCell {
    @IBOutlet weak var score: UILabel!
    
    @IBOutlet weak var commentDate: UILabel!
    @IBOutlet weak var commentBackground: UIImageView!
    @IBOutlet weak var commentTextLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
                    commentBackground.layer.cornerRadius = 5
                    commentBackground.layer.borderWidth = 0
                    commentBackground.layer.borderColor = UIColor.clear.cgColor
                    commentBackground.layer.masksToBounds = true
        
                    commentBackground.layer.shadowColor = UIColor.gray.cgColor
                    commentBackground.layer.shadowOffset = CGSize(width: 0, height: 2.0)
                    commentBackground.layer.shadowRadius = 6.0
                    commentBackground.layer.shadowOpacity = 0.6
                    commentBackground.layer.masksToBounds = false
                    commentBackground.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.contentView.layer.cornerRadius).cgPath

        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}
