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
    
    @discardableResult public func pinLeft(anchor: NSLayoutXAxisAnchor? = nil, padding: CGFloat = 0, respectSafeAreas: Bool = false, constraintType: ConstraintType = .equalTo, isActive: Bool = true, priority: UILayoutPriority = .required, capture: ((_ constraint: NSLayoutConstraint) -> Void)? = nil) -> Self {
        return pinHorizontal(.left, anchor: anchor, padding: padding, respectSafeAreas: respectSafeAreas, constraintType: constraintType, isActive: isActive, priority: priority, capture: capture)
    }
    
    @discardableResult public func pinRight(anchor: NSLayoutXAxisAnchor? = nil, padding: CGFloat = 0, respectSafeAreas: Bool = false, constraintType: ConstraintType = .equalTo, isActive: Bool = true, priority: UILayoutPriority = .required, capture: ((_ constraint: NSLayoutConstraint) -> Void)? = nil) -> Self {
        return pinHorizontal(.right, anchor: anchor, padding: padding, respectSafeAreas: respectSafeAreas, constraintType: constraintType, isActive: isActive, priority: priority, capture: capture)
    }
    
    @discardableResult public func pinLeading(anchor: NSLayoutXAxisAnchor? = nil, padding: CGFloat = 0, respectSafeAreas: Bool = false, constraintType: ConstraintType = .equalTo, isActive: Bool = true, priority: UILayoutPriority = .required, capture: ((_ constraint: NSLayoutConstraint) -> Void)? = nil) -> Self {
        return pinHorizontal(.leading, anchor: anchor, padding: padding, respectSafeAreas: respectSafeAreas, constraintType: constraintType, isActive: isActive, priority: priority, capture: capture)
    }
    
    @discardableResult public func pinTrailing(anchor: NSLayoutXAxisAnchor? = nil, padding: CGFloat = 0, respectSafeAreas: Bool = false, constraintType: ConstraintType = .equalTo, isActive: Bool = true, priority: UILayoutPriority = .required, capture: ((_ constraint: NSLayoutConstraint) -> Void)? = nil) -> Self {
        return pinHorizontal(.trailing, anchor: anchor, padding: padding, respectSafeAreas: respectSafeAreas, constraintType: constraintType, isActive: isActive, priority: priority, capture: capture)
    }
    
    @discardableResult public func pinTop(anchor: NSLayoutYAxisAnchor? = nil, padding: CGFloat = 0, respectSafeAreas: Bool = false, constraintType: ConstraintType = .equalTo, isActive: Bool = true, priority: UILayoutPriority = .required, capture: ((_ constraint: NSLayoutConstraint) -> Void)? = nil) -> Self {
        return pinVertical(.top, anchor: anchor, padding: padding, respectSafeAreas: respectSafeAreas, constraintType: constraintType, isActive: isActive, priority: priority, capture: capture)
    }
    
    @discardableResult public func pinBottom(anchor: NSLayoutYAxisAnchor? = nil, padding: CGFloat = 0, respectSafeAreas: Bool = false, constraintType: ConstraintType = .equalTo, isActive: Bool = true, priority: UILayoutPriority = .required, capture: ((_ constraint: NSLayoutConstraint) -> Void)? = nil) -> Self {
        return pinVertical(.bottom, anchor: anchor, padding: padding, respectSafeAreas: respectSafeAreas, constraintType: constraintType, isActive: isActive, priority: priority, capture: capture)
    }
    
    @discardableResult public func pinCenterX(anchor: NSLayoutXAxisAnchor? = nil, offset: CGFloat = 0, respectSafeAreas: Bool = false, constraintType: ConstraintType = .equalTo, isActive: Bool = true, priority: UILayoutPriority = .required, capture: ((_ constraint: NSLayoutConstraint) -> Void)? = nil) -> Self {
        return pinHorizontal(.centerX, anchor: anchor, padding: offset, respectSafeAreas: respectSafeAreas, constraintType: constraintType, isActive: isActive, priority: priority, capture: capture)
    }
    
    @discardableResult public func pinCenterY(anchor: NSLayoutYAxisAnchor? = nil, offset: CGFloat = 0, respectSafeAreas: Bool = false, constraintType: ConstraintType = .equalTo, isActive: Bool = true, priority: UILayoutPriority = .required, capture: ((_ constraint: NSLayoutConstraint) -> Void)? = nil) -> Self {
        return pinVertical(.centerY, anchor: anchor, padding: offset, respectSafeAreas: respectSafeAreas, constraintType: constraintType, isActive: isActive, priority: priority, capture: capture)
    }
    
    @discardableResult public func pinCenter(toView anchorView: UIView? = nil, verticalOffset: CGFloat = 0, horizontalOffset: CGFloat = 0, capture: ((_ constraints: CenterConstraints) -> Void)? = nil) -> Self {
        
        var centerXConstraint : NSLayoutConstraint!
        var centerYConstraint : NSLayoutConstraint!
        
        pinCenterX(anchor: anchorView?.centerXAnchor, offset: horizontalOffset) { constraint in
            centerXConstraint = constraint
        }
        
        pinCenterY(anchor: anchorView?.centerYAnchor, offset: verticalOffset) { constraint in
            centerYConstraint = constraint
        }
        
        let centerConstraints = CenterConstraints(centerXConstraint: centerXConstraint, centerYConstraint: centerYConstraint)
        capture?(centerConstraints)
        return self
    }
    
    // pin center here
    
    @discardableResult public func matchHeight(anchor: NSLayoutDimension? = nil, offset: CGFloat = 0, multiplier: CGFloat = 1, constraintType: ConstraintType = .equalTo, isActive: Bool = true, priority: UILayoutPriority = .required, capture: ((_ constraint: NSLayoutConstraint) -> Void)? = nil) -> Self {
        return matchSizeType(.height, anchor: anchor, offset: offset, multiplier: multiplier, constraintType: constraintType, isActive: isActive, priority: priority, capture: capture)
    }
    
    @discardableResult public func matchWidth(anchor: NSLayoutDimension? = nil, offset: CGFloat = 0, multiplier: CGFloat = 1, constraintType: ConstraintType = .equalTo, isActive: Bool = true, priority: UILayoutPriority = .required, capture: ((_ constraint: NSLayoutConstraint) -> Void)? = nil) -> Self {
        return matchSizeType(.width, anchor: anchor, offset: offset, multiplier: multiplier, constraintType: constraintType, isActive: isActive, priority: priority, capture: capture)
    }
    
    @discardableResult public func matchSize(toView anchorView: UIView? = nil, offset: CGFloat, multiplier: CGFloat = 1, isActive: Bool = true, priority: UILayoutPriority = .required, capture: ((_ sizeConstraints: SizeConstraints) -> Void)? = nil) -> Self {
        var heightConstraint : NSLayoutConstraint!
        var widthConstraint : NSLayoutConstraint!
        
        matchHeight(anchor: anchorView?.heightAnchor, offset: offset, multiplier: multiplier, isActive: isActive, priority: priority) { constraint in
            heightConstraint = constraint
        }
        
        matchWidth(anchor: anchorView?.heightAnchor, offset: offset, multiplier: multiplier, isActive: isActive, priority: priority) { constraint in
            widthConstraint = constraint
        }
        
        capture?(SizeConstraints(heightConstraint: heightConstraint, widthConstraint: widthConstraint))
        return self
    }
    
    @discardableResult public func makeHeight(_ constant: CGFloat, constraintType: ConstraintType = .equalTo, isActive: Bool = true, priority: UILayoutPriority = .required, capture: ((_ constraint: NSLayoutConstraint) -> Void)? = nil) -> Self {
        let constraint = SizeType.height.constraintForConstant(view: self, constant: constant, constraintType: constraintType)
        return handleConstraint(constraint, isActive: isActive, priority: priority, capture: capture)
    }
    
    @discardableResult public func makeWidth(_ constant: CGFloat, constraintType: ConstraintType = .equalTo, isActive: Bool = true, priority: UILayoutPriority = .required, capture: ((_ constraint: NSLayoutConstraint) -> Void)? = nil) -> Self {
        let constraint = SizeType.width.constraintForConstant(view: self, constant: constant, constraintType: constraintType)
        return handleConstraint(constraint, isActive: isActive, priority: priority, capture: capture)
    }
    
    @discardableResult public func makeSize(_ constant: CGFloat, constraintType: ConstraintType = .equalTo, isActive: Bool = true, priority: UILayoutPriority = .required, capture: ((_ sizeConstraints: SizeConstraints) -> Void)? = nil) -> Self {
        var heightConstraint : NSLayoutConstraint!
        var widthConstraint : NSLayoutConstraint!
        
        makeHeight(constant, constraintType: constraintType, isActive: isActive, priority: priority) { constraint in
            heightConstraint = constraint
        }
        makeWidth(constant, constraintType: constraintType, isActive: isActive, priority: priority) { constraint in
            widthConstraint = widthConstraint
        }
        
        capture?(SizeConstraints(heightConstraint: heightConstraint, widthConstraint: widthConstraint))
        return self
    
    }
    
    @discardableResult public func makeCircle(diameter: CGFloat, capture: ((_ sizeConstraints: SizeConstraints) -> Void)? = nil) -> Self {
        return self.makeSize(diameter, capture: capture)
            .roundCorners(radius: diameter / 2)
    }
    
    
    @discardableResult public func pinSides(_ sides: [Side] = [.left, .right, .top, .bottom],
                                            toView anchorView: UIView? = nil,
                                            padding: CGFloat = 0,
                                            customPadding: [Padding] = [],
                                            respectSafeAreas: Bool = false,
                                            customSafeAreas: [Side] = [],
                                            capture: ((_ constraints: SideConstraints) -> Void)? = nil) -> Self {
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
        
        var useLeftSafeArea = respectSafeAreas
        var useRightSafeArea = respectSafeAreas
        var useTopSafeArea = respectSafeAreas
        var useBottomSafeArea = respectSafeAreas
        
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
        
        var leftConstraint : NSLayoutConstraint!
        var rightConstraint : NSLayoutConstraint!
        var topConstraint : NSLayoutConstraint!
        var bottomConstraint : NSLayoutConstraint!
        
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
    
    
    // Implementation only, don't really want to expose these and complicate which method should be used when
    
    @discardableResult private func pinHorizontal(_ pinType: HorizontalPinType, anchor: NSLayoutXAxisAnchor?, padding: CGFloat, respectSafeAreas: Bool, constraintType: ConstraintType, isActive: Bool, priority: UILayoutPriority, capture: ((_ constraint: NSLayoutConstraint) -> Void)?) -> Self {
        let anchorPoint = anchor ?? pinType.parentMirrorAnchor(parentView: nonOptionalSuperview, respectsSafeAreas: respectSafeAreas)
        let constraint = pinType.constraint(view: self, anchor: anchorPoint, constraintType: constraintType, padding: padding)
        return handleConstraint(constraint, isActive: isActive, priority: priority, capture: capture)
    }
    
    @discardableResult private func pinVertical(_ pinType: VerticalPinType, anchor: NSLayoutYAxisAnchor?, padding: CGFloat, respectSafeAreas: Bool, constraintType: ConstraintType, isActive: Bool, priority: UILayoutPriority, capture: ((_ constraint: NSLayoutConstraint) -> Void)?) -> Self {
        let anchorPoint = anchor ?? pinType.parentMirrorAnchor(parentView: nonOptionalSuperview, respectsSafeAreas: respectSafeAreas)
        let constraint = pinType.constraint(view: self, anchor: anchorPoint, constraintType: constraintType, padding: padding)
        return handleConstraint(constraint, isActive: isActive, priority: priority, capture: capture)
    }
    
    @discardableResult private func matchSizeType(_ sizeType: SizeType, anchor: NSLayoutDimension?, offset: CGFloat, multiplier: CGFloat, constraintType: ConstraintType, isActive: Bool, priority: UILayoutPriority, capture: ((_ constraint: NSLayoutConstraint) -> Void)?) -> Self {
        let anchorPoint = anchor ?? sizeType.anchorForView(nonOptionalSuperview)
        let constraint = sizeType.constraint(view: self, anchor: anchorPoint, constraintType: constraintType, offSet: offset, multiplier: multiplier)
        return handleConstraint(constraint, isActive: isActive, priority: priority, capture: capture)
    }
    
    @discardableResult private func handleConstraint(_ constraint: NSLayoutConstraint, isActive: Bool, priority: UILayoutPriority, capture: ((_ constraint: NSLayoutConstraint) -> Void)?) -> Self {
        self.translatesAutoresizingMaskIntoConstraints = false
        constraint.priority = priority
        constraint.isActive = isActive
        capture?(constraint)
        return self
    }
    
    fileprivate var nonOptionalSuperview : UIView {
        guard let superview = superview else {
            fatalError("Cannot layout view without a superview")
        }
        return superview
    }
}

fileprivate enum HorizontalPinType {
    case left
    case right
    case leading
    case trailing
    case centerX
    
    private func offsetFromPadding(_ padding: CGFloat) -> CGFloat {
        switch self {
        case .left:
            return padding
        case .right:
            return -padding
        case .leading:
            return UIApplication.shared.userInterfaceLayoutDirection == .rightToLeft ? -padding : padding
        case .trailing:
            return UIApplication.shared.userInterfaceLayoutDirection == .rightToLeft ? padding : -padding
        case .centerX:
            return padding
        }
    }
    
    public func parentMirrorAnchor(parentView: UIView, respectsSafeAreas: Bool) -> NSLayoutXAxisAnchor {
        switch self {
        case .left:
            return respectsSafeAreas ? parentView.safeAreaLayoutGuide.leftAnchor : parentView.leftAnchor
        case .right:
            return respectsSafeAreas ? parentView.safeAreaLayoutGuide.rightAnchor : parentView.rightAnchor
        case .leading:
            return respectsSafeAreas ? parentView.safeAreaLayoutGuide.leadingAnchor : parentView.leadingAnchor
        case .trailing:
            return respectsSafeAreas ? parentView.safeAreaLayoutGuide.trailingAnchor : parentView.trailingAnchor
        case .centerX:
            return respectsSafeAreas ? parentView.safeAreaLayoutGuide.centerXAnchor : parentView.centerXAnchor
        }
    }
    
    public func constraint(view: UIView, anchor: NSLayoutXAxisAnchor, constraintType: ConstraintType, padding: CGFloat) -> NSLayoutConstraint {
        
        let viewAnchor = viewAnchor(view)
        let constant = offsetFromPadding(padding)
        switch constraintType {
        case .equalTo:
            return viewAnchor.constraint(equalTo: anchor, constant: constant)
        case .lessThanOrEqualTo:
            return viewAnchor.constraint(lessThanOrEqualTo: anchor, constant: constant)
        case .greaterThanOrEqualTo:
            return viewAnchor.constraint(greaterThanOrEqualTo: anchor, constant: constant)
        }
    }
    
    private func viewAnchor(_ view: UIView) -> NSLayoutXAxisAnchor {
        switch self {
        case .left:
            return view.leftAnchor
        case .right:
            return view.rightAnchor
        case .leading:
            return view.leadingAnchor
        case .trailing:
            return view.trailingAnchor
        case .centerX:
            return view.centerXAnchor
        }
    }
}

fileprivate enum VerticalPinType {
    case top
    case bottom
    case centerY
    
    private func offsetFromPadding(_ padding: CGFloat) -> CGFloat {
        switch self {
        case .top:
            return padding
        case .bottom:
            return -padding
        case .centerY:
            return padding
        }
    }
    
    public func parentMirrorAnchor(parentView: UIView, respectsSafeAreas: Bool) -> NSLayoutYAxisAnchor {
        switch self {
        case .top:
            return respectsSafeAreas ? parentView.safeAreaLayoutGuide.topAnchor : parentView.topAnchor
        case .bottom:
            return respectsSafeAreas ? parentView.safeAreaLayoutGuide.bottomAnchor : parentView.bottomAnchor
        case .centerY:
            return respectsSafeAreas ? parentView.safeAreaLayoutGuide.centerYAnchor : parentView.centerYAnchor
        }
    }
    
    public func constraint(view: UIView, anchor: NSLayoutYAxisAnchor, constraintType: ConstraintType, padding: CGFloat) -> NSLayoutConstraint {
        
        let viewAnchor = viewAnchor(view)
        let constant = offsetFromPadding(padding)
        switch constraintType {
        case .equalTo:
            return viewAnchor.constraint(equalTo: anchor, constant: constant)
        case .lessThanOrEqualTo:
            return viewAnchor.constraint(lessThanOrEqualTo: anchor, constant: constant)
        case .greaterThanOrEqualTo:
            return viewAnchor.constraint(greaterThanOrEqualTo: anchor, constant: constant)
        }
    }
    
    private func viewAnchor(_ view: UIView) -> NSLayoutYAxisAnchor {
        switch self {
        case .top:
            return view.topAnchor
        case .bottom:
            return view.bottomAnchor
        case .centerY:
            return view.centerYAnchor
        }
    }
}

fileprivate enum SizeType {
    case height
    case width
    
    public func constraint(view: UIView, anchor: NSLayoutDimension, constraintType: ConstraintType, offSet: CGFloat, multiplier: CGFloat) -> NSLayoutConstraint {
        let viewAnchor = self.anchorForView(view)
        switch constraintType {
        case .equalTo:
            return viewAnchor.constraint(equalTo: anchor, multiplier: multiplier, constant: offSet)
        case .lessThanOrEqualTo:
            return viewAnchor.constraint(lessThanOrEqualTo: anchor, multiplier: multiplier, constant: offSet)
        case .greaterThanOrEqualTo:
            return viewAnchor.constraint(greaterThanOrEqualTo: anchor, multiplier: multiplier, constant: offSet)
        }
    }
    
    public func constraintForConstant(view: UIView, constant: CGFloat, constraintType: ConstraintType) -> NSLayoutConstraint {
        let viewAnchor = self.anchorForView(view)
        switch constraintType {
        case .equalTo:
            return viewAnchor.constraint(equalToConstant: constant)
        case .lessThanOrEqualTo:
            return viewAnchor.constraint(lessThanOrEqualToConstant: constant)
        case .greaterThanOrEqualTo:
            return viewAnchor.constraint(greaterThanOrEqualToConstant: constant)
        }
    }
    
    public func anchorForView(_ view: UIView) -> NSLayoutDimension {
        switch self {
        case .height:
            return view.heightAnchor
        case .width:
            return view.widthAnchor
        }
    }
    
    
    
}
