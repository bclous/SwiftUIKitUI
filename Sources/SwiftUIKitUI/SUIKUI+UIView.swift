//
// SUIKUI+UIView.swift
//  
//
//  Created by Brian Clouser on 6/26/22.
//

import UIKit

extension UIView {
    
    @discardableResult public func addBorder(width: CGFloat = 1, color: UIColor = UIColor.black) -> Self {
        layer.borderWidth = width
        layer.borderColor = color.cgColor
        return self
    }
    
    @discardableResult public func roundCorners(radius: CGFloat) -> Self {
        layer.cornerRadius = radius
        return self
    }
    
    @discardableResult public func applyBackgroundColor(_ color: UIColor) -> Self {
        self.backgroundColor = color
        return self
    }
    
    @discardableResult public func hide() -> Self {
        self.alpha = 0
        return self
    }
    
    @discardableResult public func show(alpha: CGFloat = 1) -> Self {
        self.alpha = alpha
        return self
    }
    
    @discardableResult public func clipsToBounds(_ clipsToBounds: Bool = true) -> Self {
        self.clipsToBounds = clipsToBounds
        return self
    }

}
