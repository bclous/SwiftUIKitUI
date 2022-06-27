//
//  SUIKUI+UILabel.swift
//  
//
//  Created by Brian Clouser on 6/26/22.
//

import UIKit


extension UILabel {
    
    @discardableResult public func style(font: UIFont? = nil, textColor: UIColor? = nil, alignment: NSTextAlignment? = nil) -> Self {
        if let font = font {
            self.font = font
        }
        
        if let textColor = textColor {
            self.textColor = textColor
        }
        
        if let alignment = alignment {
            self.textAlignment = alignment
        }
        
        return self
    }
    
    @discardableResult public func applyText(_ text: String?) -> Self {
        self.text = text
        return self
    }
    
    @discardableResult public func adjustFontSizeToFitWidth(_ adjust: Bool = true) -> Self {
        self.adjustsFontSizeToFitWidth = adjust
        return self
    }
    
    @discardableResult public func enforceBindingSelfSizing(direction: NSLayoutConstraint.Axis) -> Self {
        self.setContentHuggingPriority(.required, for: direction)
        self.setContentCompressionResistancePriority(.required, for: direction)
        return self
    }
    
    @discardableResult public func makeMultiline() -> Self {
        self.numberOfLines = 0
        return self
    }
    
}
