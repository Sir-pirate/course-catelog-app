//
//  CollectionViewCell.swift
//  TestCollectionView
//
//  Created by Yaoqi Shou on 6/18/20.
//  Copyright © 2020 Yaoqi Shou. All rights reserved.
//

import UIKit

class subjectCell: UICollectionViewCell {

    @IBOutlet weak var xxxx: UILabel!
    override func layoutSubviews() {
//        // cell rounded section
        self.layer.cornerRadius = 5
        self.layer.borderWidth = 0
        self.layer.borderColor = UIColor.clear.cgColor
        self.layer.masksToBounds = true
//
//        // cell shadow section
        self.contentView.layer.cornerRadius = 5.0
        self.contentView.layer.borderWidth = 5.0
        self.contentView.layer.borderColor = UIColor.clear.cgColor
        self.contentView.layer.masksToBounds = true
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        self.layer.shadowRadius = 6.0
        self.layer.shadowOpacity = 0.6
        self.layer.masksToBounds = false
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.contentView.layer.cornerRadius).cgPath
    }
    
}
