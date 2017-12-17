//
//  AvatarCell.swift
//  Szlack
//
//  Created by Khaled Rahman Ayon on 14/12/2017.
//  Copyright © 2017 Khaled Rahman Ayon. All rights reserved.
//

import UIKit

enum AvatarType {
    case dark
    case light
}

class AvatarCell: UICollectionViewCell {
    
    @IBOutlet weak var avatarImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpView()
    }
    
    func configureCell(index: Int, type: AvatarType) {
        if type == .dark {
            avatarImg.image = UIImage(named: "dark\(index)")
            self.layer.backgroundColor = UIColor.lightGray.cgColor
        } else {
            avatarImg.image = UIImage(named: "light\(index)")
            self.layer.backgroundColor = UIColor.darkGray.cgColor
        }
    }
    
    func setUpView() {
        self.layer.backgroundColor = UIColor.darkGray.cgColor
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
    }
}
