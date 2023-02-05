//
//  UIView+Ext.swift
//  GitHubFollower_Programmatic
//
//  Created by YILDIRIM on 4.02.2023.
//

import UIKit

extension UIView {
        
    func addSubviews(_ views: UIView...) {
        for view in views {
            addSubview(view)
        }
    }
}
