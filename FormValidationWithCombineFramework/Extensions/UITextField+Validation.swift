//
//  UITextField+Validation.swift
//  FormValidationWithCombineFramework
//
//  Created by alican on 24.02.2022.
//


import UIKit

extension UITextField {
    
    /// Highlights a textfield in green to show that it's valid
    func valid() {
        self.layer.borderColor = UIColor.systemGreen.cgColor
    }
    
    /// Highlights a textfield in red to show that it's invalid
    func invalid() {
        self.layer.borderColor = UIColor.systemRed.cgColor
    }
}
