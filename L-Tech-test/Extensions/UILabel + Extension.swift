//
//  UILabel + Extension.swift
//  L-Tech-test
//
//  Created by Рамил Гаджиев on 18.10.2021.
//

import UIKit

extension UILabel {
    
    convenience init (text: String, size: CGFloat = 16) {
        self.init()
        self.text = text
        self.font = UIFont(name: "KohinoorBangla-Regular", size: size)
        self.textColor = .black
        numberOfLines = 0
    }
}
