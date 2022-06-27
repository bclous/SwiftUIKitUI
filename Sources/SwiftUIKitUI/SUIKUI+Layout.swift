//
//  SUIKUI+Layout.swift
//  
//
//  Created by Brian Clouser on 6/26/22.
//

import UIKit

extension UIView {
    
    @discardableResult public func createChild() -> UIView {
        let newChild = UIView()
        addSubview(newChild)
        return newChild
    }
    
    @discardableResult public func createChild<T>(ofType type: T.Type) -> T where T: UIView {
        let newChild = T.init()
        addSubview(newChild)
        return newChild
    }
    
    @discardableResult public func attachToParent(_ parent: UIView) -> Self {
        parent.addSubview(self)
        return self
    }
    
    @discardableResult public func pinLeft(anchor: NSLayoutXAxisAnchor? = nil, padding: CGFloat = 0, isActive: Bool = true, priority: UILayoutPriority = .required, capture: ((_ constraint: NSLayoutConstraint) -> Void)? = nil) -> Self {

        self.translatesAutoresizingMaskIntoConstraints = false
        let anchorPoint = anchor ?? nonOptionalSuperview.leftAnchor
        let constraint = leftAnchor.constraint(equalTo: anchorPoint, constant: padding)
        constraint.priority = priority
        constraint.isActive = isActive
        capture?(constraint)
        return self
    }
    
    @discardableResult public func pinRight(anchor: NSLayoutXAxisAnchor? = nil, padding: CGFloat = 0, isActive: Bool = true, priority: UILayoutPriority = .required, capture: ((_ constraint: NSLayoutConstraint) -> Void)? = nil) -> Self {
        self.translatesAutoresizingMaskIntoConstraints = false
        let anchorPoint = anchor ?? nonOptionalSuperview.rightAnchor
        let constraint = rightAnchor.constraint(equalTo: anchorPoint, constant: -padding)
        constraint.priority = priority
        constraint.isActive = isActive
        capture?(constraint)
        return self
    }
    
    @discardableResult public func pinTop(anchor: NSLayoutYAxisAnchor? = nil, padding: CGFloat = 0, isActive: Bool = true, priority: UILayoutPriority = .required, capture: ((_ constraint: NSLayoutConstraint) -> Void)? = nil) -> Self {
        self.translatesAutoresizingMaskIntoConstraints = false
        let anchorPoint = anchor ?? nonOptionalSuperview.topAnchor
        let constraint = topAnchor.constraint(equalTo: anchorPoint, constant: padding)
        constraint.isActive = isActive
        constraint.priority = priority
        capture?(constraint)
        return self
    }
    
    @discardableResult public func pinBottom(anchor: NSLayoutYAxisAnchor? = nil, padding: CGFloat = 0, isActive: Bool = true, priority: UILayoutPriority = .required, capture: ((_ constraint: NSLayoutConstraint) -> Void)? = nil) -> Self {
        self.translatesAutoresizingMaskIntoConstraints = false
        let anchorPoint = anchor ?? nonOptionalSuperview.bottomAnchor
        let constraint = bottomAnchor.constraint(equalTo: anchorPoint, constant: -padding)
        constraint.priority = priority
        constraint.isActive = isActive
        capture?(constraint)
        return self
    }
    
    @discardableResult public func pinCenterX(anchor: NSLayoutXAxisAnchor? = nil, offset: CGFloat = 0, isActive: Bool = true, priority: UILayoutPriority = .required, capture: ((_ constraint: NSLayoutConstraint) -> Void)? = nil) -> Self {
        self.translatesAutoresizingMaskIntoConstraints = false
        let anchorPoint = anchor ?? nonOptionalSuperview.centerXAnchor
        let constraint = centerXAnchor.constraint(equalTo: anchorPoint, constant: offset)
        constraint.isActive = isActive
        constraint.priority = priority
        capture?(constraint)
        return self
    }
    
    @discardableResult public func pinCenterY(anchor: NSLayoutYAxisAnchor? = nil, offset: CGFloat = 0, isActive: Bool = true, priority: UILayoutPriority = .required, capture: ((_ constraint: NSLayoutConstraint) -> Void)? = nil) -> Self {
        self.translatesAutoresizingMaskIntoConstraints = false
        let anchorPoint = anchor ?? nonOptionalSuperview.centerYAnchor
        let constraint = centerYAnchor.constraint(equalTo: anchorPoint, constant: offset)
        constraint.priority = priority
        constraint.isActive = isActive
        capture?(constraint)
        return self
    }
    
    @discardableResult public func pinSides(_ sides: [Side] = [.left, .right, .top, .bottom], toView anchorView: UIView? = nil, padding: CGFloat = 0, customPadding: [Padding] = [], useSafeAreas: Bool = false, customSafeAreas: [Side] = [], capture: ((_ constraints: SideConstraints) -> Void)? = nil) -> Self {
        let viewToPinTo = anchorView ?? nonOptionalSuperview
        self.translatesAutoresizingMaskIntoConstraints = false
        
        var leftPadding = padding
        var rightPadding = padding
        var topPadding = padding
        var bottomPadding = padding
        
        for padding in customPadding {
            switch padding {
            case .left(let value):
                leftPadding = value
            case .right(let value):
                rightPadding = value
            case .top(let value):
                topPadding = value
            case .bottom(let value):
                bottomPadding = value
            }
        }
        
        var useLeftSafeArea = useSafeAreas
        var useRightSafeArea = useSafeAreas
        var useTopSafeArea = useSafeAreas
        var useBottomSafeArea = useSafeAreas
        
        for safeArea in customSafeAreas {
            switch safeArea {
            case .left:
                useLeftSafeArea = true
            case .right:
                useRightSafeArea = true
            case .top:
                useTopSafeArea = true
            case .bottom:
                useBottomSafeArea = true
            }
        }
        
        var leftConstraint : NSLayoutConstraint?
        var rightConstraint : NSLayoutConstraint?
        var topConstraint : NSLayoutConstraint?
        var bottomConstraint : NSLayoutConstraint?
        
        let leftAnchorTarget = useLeftSafeArea ? viewToPinTo.safeAreaLayoutGuide.leftAnchor : viewToPinTo.leftAnchor
        let rightAnchorTarget = useRightSafeArea ? viewToPinTo.safeAreaLayoutGuide.rightAnchor : viewToPinTo.rightAnchor
        let topAnchorTarget = useTopSafeArea ? viewToPinTo.safeAreaLayoutGuide.topAnchor : viewToPinTo.topAnchor
        let bottomAnchorTarget = useBottomSafeArea ? viewToPinTo.safeAreaLayoutGuide.bottomAnchor : viewToPinTo.bottomAnchor
        
        for side in sides {
            switch side {
            case .left:
                leftConstraint = leftAnchor.constraint(equalTo: leftAnchorTarget, constant: leftPadding)
            case .right:
                rightConstraint = rightAnchor.constraint(equalTo: rightAnchorTarget, constant: -rightPadding)
            case .top:
                topConstraint = topAnchor.constraint(equalTo: topAnchorTarget, constant: topPadding)
            case .bottom:
                bottomConstraint = bottomAnchor.constraint(equalTo: bottomAnchorTarget, constant: -bottomPadding)
            }
        }
        
        leftConstraint?.isActive = true
        rightConstraint?.isActive = true
        topConstraint?.isActive = true
        bottomConstraint?.isActive = true
        
        let viewConstraints = SideConstraints(leftConstraint: leftConstraint, rightConstraint: rightConstraint, topConstraint: topConstraint, bottomConstraint: bottomConstraint)
        capture?(viewConstraints)
        
        return self
    }
    
    @discardableResult public func pinCenter(toView anchorView: UIView? = nil, verticleOffset: CGFloat = 0, horizontalOffset: CGFloat = 0, capture: ((_ constraints: CenterConstraints) -> Void)? = nil) -> Self {
        
        var centerXConstraint : NSLayoutConstraint?
        var centerYConstraint : NSLayoutConstraint?
        
        pinCenterX(anchor: anchorView?.centerXAnchor, offset: horizontalOffset) { constraint in
            centerXConstraint = constraint
        }
        
        pinCenterY(anchor: anchorView?.centerYAnchor, offset: verticleOffset) { constraint in
            centerYConstraint = constraint
        }
        
        let centerConstraints = CenterConstraints(centerXConstraint: centerXConstraint, centerYConstraint: centerYConstraint)
        capture?(centerConstraints)
        return self
    }
    
    @discardableResult public func matchHeight(anchor: NSLayoutDimension? = nil, offset: CGFloat = 0, multiplier: CGFloat = 1, isActive: Bool = true, priority: UILayoutPriority = .required, capture: ((_ constraint: NSLayoutConstraint) -> Void)? = nil) -> Self {
        self.translatesAutoresizingMaskIntoConstraints = false
        let anchor = anchor ?? nonOptionalSuperview.heightAnchor
        let constraint = heightAnchor.constraint(equalTo: anchor, multiplier: multiplier, constant: offset)
        constraint.isActive = isActive
        constraint.priority = priority
        capture?(constraint)
        return self
    }
    
    @discardableResult public func matchWidth(anchor: NSLayoutDimension? = nil, offset: CGFloat = 0, multiplier: CGFloat = 1, isActive: Bool = true, priority: UILayoutPriority = .required, capture: ((_ constraint: NSLayoutConstraint) -> Void)? = nil) -> Self {
        self.translatesAutoresizingMaskIntoConstraints = false
        let anchor = anchor ?? nonOptionalSuperview.widthAnchor
        let constraint = widthAnchor.constraint(equalTo: anchor, multiplier: multiplier, constant: offset)
        constraint.priority = priority
        constraint.isActive = isActive
        capture?(constraint)
        return self
    }
    
    @discardableResult public func makeHeight(_ constant: CGFloat, isActive: Bool = true, priority: UILayoutPriority = .required, capture: ((_ constraint: NSLayoutConstraint) -> Void)? = nil) -> Self {
        self.translatesAutoresizingMaskIntoConstraints = false
        let constraint = heightAnchor.constraint(equalToConstant: constant)
        constraint.isActive = isActive
        constraint.priority = priority
        capture?(constraint)
        return self
    }
    
    @discardableResult public func makeWidth(_ constant: CGFloat, isActive: Bool = true, priority: UILayoutPriority = .required, capture: ((_ constraint: NSLayoutConstraint) -> Void)? = nil) -> Self {
        self.translatesAutoresizingMaskIntoConstraints = false
        let constraint = widthAnchor.constraint(equalToConstant: constant)
        constraint.isActive = isActive
        constraint.priority = priority
        capture?(constraint)
        return self
    }
    
    @discardableResult public func makeCircle(radius: CGFloat) -> Self {
        return self.makeWidth(radius)
            .makeHeight(radius)
            .roundCorners(radius: radius / 2)
    }
    
    fileprivate var nonOptionalSuperview : UIView {
        guard let superview = superview else {
            fatalError("Cannot layout view without a superview")
        }
        return superview
    }
    
}

public struct SideConstraints {
    let leftConstraint : NSLayoutConstraint?
    let rightConstraint : NSLayoutConstraint?
    let topConstraint : NSLayoutConstraint?
    let bottomConstraint : NSLayoutConstraint?
}

public struct CenterConstraints {
    let centerXConstraint : NSLayoutConstraint?
    let centerYConstraint : NSLayoutConstraint?
}

public enum Padding {
    case left(_ value: CGFloat)
    case right(_ value: CGFloat)
    case top(_ value: CGFloat)
    case bottom(_ value: CGFloat)
}

public enum Side {
    case left
    case right
    case top
    case bottom
}
