//
//  UIAlert + Extension.swift
//  L-Tech-test
//
//  Created by Рамил Гаджиев on 26.10.2021.
//

import UIKit


extension UIAlertController {
    
    static func showAlert (title: String, message: String) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        return alert
    }
}

