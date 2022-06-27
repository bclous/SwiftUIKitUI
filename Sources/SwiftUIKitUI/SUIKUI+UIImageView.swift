//
//  SUIKUI+ImageView.swift
//  
//
//  Created by Brian Clouser on 6/26/22.
//

import UIKit

extension UIImageView {
    
    @discardableResult public func applyImageWithName(_ name: String) -> Self {
        self.image = UIImage(named: name)
        return self
    }
    
    @discardableResult public func applyContentMode(_ mode: ContentMode) -> Self {
        self.contentMode = contentMode
        return self
    }
    
    @discardableResult public func clipsToBounds(_ clipsToBounds: Bool = true) -> Self {
        self.clipsToBounds = clipsToBounds
        return self
    }
    
}

