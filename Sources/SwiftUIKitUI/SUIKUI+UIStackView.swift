//
//  SUIKUI+UIStackView.swift
//  
//
//  Created by Brian Clouser on 6/26/22.
//

import UIKit

extension UIStackView {
    
    @discardableResult public func applySpacing(_ spacing: CGFloat) -> Self {
        self.spacing = spacing
        return self
    }
    
    @discardableResult public func applyDistribution(_ distribution: UIStackView.Distribution) -> Self {
        self.distribution = distribution
        return self
    }
    
    @discardableResult public func applyAlignment(_ alignment: UIStackView.Alignment) -> Self {
        self.alignment = alignment
        return self
    }
    
    @discardableResult public func makeVertical(spacing: CGFloat? = nil, distribution: UIStackView.Distribution? = nil, alignment: UIStackView.Alignment? = nil) -> Self {
        self.axis = .vertical
        if let spacing = spacing {
            self.spacing = spacing
        }
        if let distribution = distribution {
            self.distribution = distribution
        }
        if let alignment = alignment {
            self.alignment = alignment
        }
        return self
    }
    
    @discardableResult public func makeHorizontal(spacing: CGFloat? = nil, distribution: UIStackView.Distribution? = nil, alignment: UIStackView.Alignment? = nil) -> Self {
        self.axis = .horizontal
        if let spacing = spacing {
            self.spacing = spacing
        }
        if let distribution = distribution {
            self.distribution = distribution
        }
        if let alignment = alignment {
            self.alignment = alignment
        }
        return self
    }
    
    @discardableResult public func addArrangedSubviews(_ subviews: [UIView]) -> Self {
        for subview in subviews {
            addArrangedSubview(subview)
        }
        return self
    }

}
