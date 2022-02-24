//
//  UITableViewCell+ReuseCleanUp.swift
//  FormValidationWithCombineFramework
//
//  Created by alican on 24.02.2022.
//

import UIKit

extension UICollectionViewCell {
    
    /// Removes all content within a cell to help with cleanup
    func removeViews() {
        contentView.subviews.forEach { $0.removeFromSuperview() }
    }
}
