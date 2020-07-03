//
//  courseCell.swift
//  TestCollectionView
//
//  Created by Yaoqi Shou on 6/18/20.
//  Copyright © 2020 Yaoqi Shou. All rights reserved.
//

import UIKit

class courseCell: UITableViewCell {
    var motherDelegate: courseMain!
    @IBOutlet weak var courseName: UILabel!
    @IBOutlet weak var courseInstructor: UILabel!
    @IBOutlet weak var status: UILabel!

    @IBOutlet weak var commentButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    
    @IBOutlet weak var backgroundImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
                backgroundImage.layer.cornerRadius = 5
                backgroundImage.layer.borderWidth = 0
                backgroundImage.layer.borderColor = UIColor.clear.cgColor
                backgroundImage.layer.masksToBounds = true
                backgroundImage.layer.shadowColor = UIColor.gray.cgColor
                backgroundImage.layer.shadowOffset = CGSize(width: 0, height: 2.0)
                backgroundImage.layer.shadowRadius = 6.0
                backgroundImage.layer.shadowOpacity = 0.6
                backgroundImage.layer.masksToBounds = false
                backgroundImage.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.contentView.layer.cornerRadius).cgPath

}
    
    @IBAction func favoriteTapped(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        let heartFill = UIImage(systemName: "heart.fill")
        let heartEmpty = UIImage(systemName: "heart")
        sender.setImage(heartFill, for: .selected)
        sender.setImage(heartEmpty, for: .normal)
   
        if sender.isSelected{
        motherDelegate.favoriteACell(favoriteCell: self)
        }else{
            motherDelegate.unfavoriteACell(unfavoriteCell: self)
            
        }
    }
    
    @IBAction func commentTapped(_ sender: UIButton) {
        motherDelegate.comment(commentTapped: self)
        
    }
    
    
    
    
    
    
}
