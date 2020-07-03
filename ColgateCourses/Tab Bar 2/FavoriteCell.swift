//
//  FavoriteCell.swift
//  TestCollectionView
//
//  Created by Yaoqi Shou on 6/26/20.
//  Copyright © 2020 Yaoqi Shou. All rights reserved.
//

import UIKit

class FavoriteCell: UITableViewCell {
    var fatherDelegate:Favorite!
    @IBOutlet weak var favoriteButtonn: UIButton!
    @IBOutlet weak var instructorName: UILabel!
    @IBOutlet weak var courseTitle: UILabel!
    @IBOutlet weak var status: UILabel!
    
    @IBOutlet weak var commentButton: UIButton!
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

        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func commentButtonTapped(_ sender: UIButton) {
        fatherDelegate.comment(commentTapped: self)
    }
    @IBAction func unfavoriteButtonTapped(_ sender: UIButton) {
        fatherDelegate.unFavoriteCell(unfavoritecell: self)
    }
    
}
