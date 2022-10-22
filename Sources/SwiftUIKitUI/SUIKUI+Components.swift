//
//  File.swift
//  
//
//  Created by Brian Clouser on 10/22/22.
//

import UIKit

// A structure capturing all four possible constraints used as the parameter
// in the pinSides(...) capture block
public struct SideConstraints {
    public let leftConstraint : NSLayoutConstraint?
    public let rightConstraint : NSLayoutConstraint?
    public let topConstraint : NSLayoutConstraint?
    public let bottomConstraint : NSLayoutConstraint?
}

// A structure capturing both (non optional) constraints used as the parameter
// in the pinCenter(...) capture block
public struct CenterConstraints {
    public let centerXConstraint : NSLayoutConstraint
    public let centerYConstraint : NSLayoutConstraint
}

// A structure capturing both (non optional) constraints used as the parameter
// in the matchSize(...) and makeCircle(...) capture block
public struct SizeConstraints {
    public let heightConstraint : NSLayoutConstraint
    public let widthConstraint : NSLayoutConstraint
}

// Used to specifiy which constraint type to use.
public enum ConstraintType {
    case equalTo
    case lessThanOrEqualTo
    case greaterThanOrEqualTo
}

// Used to specify custom padding in pinSides(...)
public enum Padding {
    case left(_ value: CGFloat)
    case right(_ value: CGFloat)
    case top(_ value: CGFloat)
    case bottom(_ value: CGFloat)
}

// Used to specify which sides to pin, and which safe areas to respect
// in pinSides(...)
public enum Side {
    case left
    case right
    case top
    case bottom
}
