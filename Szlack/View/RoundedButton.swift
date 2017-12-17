//
//  RoundedButton.swift
//  Szlack
//
//  Created by Khaled Rahman Ayon on 13/12/2017.
//  Copyright © 2017 Khaled Rahman Ayon. All rights reserved.
//

import UIKit

@IBDesignable
class RoundedButton: UIButton {
    
    @IBInspectable var cornerRadius: CGFloat = 3.0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    override func awakeFromNib() {
        self.setUpView()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        self.layer.cornerRadius = cornerRadius
    }
    
    func setUpView() {
        self.layer.cornerRadius = cornerRadius
    }
}
