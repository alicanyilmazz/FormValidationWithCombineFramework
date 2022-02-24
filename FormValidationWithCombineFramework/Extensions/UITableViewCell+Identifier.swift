//
//  UITableViewCell+Identifier.swift
//  FormValidationWithCombineFramework
//
//  Created by alican on 24.02.2022.
//

import UIKit

extension UICollectionViewCell {
    
    static var cellId: String {
        String(describing: self)
    }
}

