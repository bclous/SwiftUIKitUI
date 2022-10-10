# SwiftUIKitUI

SwiftUIKitUI is a set of lightweight extensions that make working with AutoLayout and UIKit easy, intuitive, and delightful.

## Layout

Programmatic layout in UIKit with AutoLayout is powerful, declarative, and adapts well to all the different screen sizes iOS developers are expected to support. It’s also way too verbose, overly complicated, and a pain to work with. SwiftUIKitUI aims to solves these problems while staying true to the framework and avoiding new patterns or layout paradigms. Let's have a look!
<br />

If you want to pin a view entirely to its parent, all you have to do is attach it, and pin its sides. 

```swift
childView.attachToParent(parentView)
    .pinSides()
```

There are several optional arguments you can add to pinSides(...) more for customization depending on your needs:

```swift
    // let's use some padding, and respect the safe areas
    childView.attachToParent(parentView)
        .pinSides(padding: 20, useSafeAreas: true)

    // let's use custom padding on just the left and right
    childView.attachToParent(parentView)
        .pinSides(customPadding: [.left(20), .right(20)])

    // let's pin it to another child view, instead of to the parent.
    // Be careful here, just like with autolayout, they must share an anscestor (parent view)
    childView.attachToParent(parentView)
        .pinSides(toView: otherChildView, padding: 10)
```

pinSides(…) is great, but only for container views and the most basic layouts. Most layouts require more granular control. Let's see how that works:


```swift
/*
    Views are pinned to the same anchor on their parent view, unless we tell them otherwise.
    i.e. pinLeft() will pin the child's left view to its parent's left view.
 */

childView.attachToParent(parentView)
    .pinLeft(padding: 20)
    .pinRight(padding: 20)
    .pinTop(padding: 20)
    .pinBottom(padding: 20)
    
// (This is the equivalent of pinSides(padding: 20))
        
    
/*
    Instead of pinning a side, we can use makeWidth(..) and makeHeight(...)
    to set an explicit height or width, in points. Let's pin a 40x40 square
    in the upper left corner, with a padding of 20 on each side.
*/

childView.attachToParent(parentView)
    .pinTop(padding: 20)
    .pinLeft(padding: 20)
    .makeWidth(40)
    .makeHeight(40)
    
    
/*
    Of course, we don't always want to pin a child view to its parent.
    Let's layout another view to the right of the one above, and extend
    it to the right edge, maintaining the same padding and 40pt height. 
    We do this by making use of the optional anchor parameter.
*/

otherChildView.attachToParent(parentView)
    .pinLeft(anchor: childView.rightAnchor, padding: 20)
    .pinRight(padding: 20)
    .pinTop(anchor: childView.topAnchor)
    .pinBottom(anchor: childView.bottomAnchor)
    
    
/*  Alternatively, we could have used pinCenterY(...) and matchHeight(...)
    to achieve the same layout.
 */

otherChildView.attachToParent(parentView)
    .pinLeft(anchor: childView.rightAnchor, padding: 20)
    .pinRight(padding: 20)
    .pinCenterY(anchor: childView.centerYAnchor)
    .matchHeight(anchor: childView.heightAnchor)
 ```
 <br />
Hopefully you're starting to see how easy this makes simple layouts. All of the verbosity of autolayout is abstracted away (you will never write..or forget to write, translatesAutoresizingMaskIntoConstraints again), and you can chain methods together to write code quickly and cleanly. 
<br />
<br />
Not all layouts are this simple, however, and that's where a lot of the other optional parameters come in to play:
<br />

```swift
// Constraints are set to active by default, but don't need to be
childView.attachToParent(parentView)
    .pinLeft(isActive: false)

// Constraints are also required by default, but don't need to be
childView.attachToParent(parentView)
    .pinLeft(priority: .defaultLow)

// Constraints can be "captured" for use later on
var leftConstraint : NSLayoutConstraint?
childView.attachToParent(parentView)
    .pinLeft() { constraint in
        leftConstraint = constraint
    }


/* Let's make two left constraints, both not active,
    and capture them for later use, maybe in an animation.
 */
var leftConstraint1 : NSLayoutConstraint?
var leftConstraint2: NSLayoutConstraint?

childView.attachToParent(parentView)
    .pinLeft(anchor: parentView.leftAnchor, isActive: false) { constraint in
        leftConstraint1 = constraint
    }
    .pinLeft(anchor: otherChildView.leftAnchor, isActive: false) { constraint in
        leftConstraint2 = constraint
    }

// (the parent.leftAnchor parameter is unnecessary as it is the default, but is included for clarity)

        
/*  SwiftUIKitUI doesn't yet support lessThanOrEqualTo or greaterThanOrEqualTo constraints.
    If you require them, just use the framework for as much as you can, and write those
    constraints the old fashioned way. It's all constraints under the hood!
 */

childView.attachToParent(parentView)
    .pinTop()
    .pinLeft()
    .pinRight()
childView.bottomAnchor.constraint(lessThanOrEqualTo: parentView.bottomAnchor).isActive = true
```

<br />

## Beyond Layout
Making programmatic AutoLayout easy is the superpower of SwiftUIKitUI, but there's some other features sprinkled on top of UIView, UIStackView, UILabel, and UIImageView that allow you to layout and configure your views all in one chained method, keeping your code clean and readable while allowing you to build quickly. 
<br />

### UIView

Layers and CGColors should be abstracted away from developers while building simple UI. Now you can round corners, add customizable borders, and change the background color of a view all in chainable methods:

```swift

iconView
    .roundCorners(radius: 5)
    .addBorder(width: 2, color: UIColor.black)
    .applyBackgroundColor(UIColor.blue)
```

We can combine this with the layout methods to layout and style our view all together. Let's lay out a typical "icon view" in the upper left corner of its parent:
<br />

```swift
iconView.attachToParent(parentView)
    .pinTop(padding: 20)
    .pinLeft(padding: 20)
    .makeWidth(40)
    .makeHeight(40)
    .roundCorners(radius: 5)
    .addBorder(width: 2, color: UIColor.black)
    .applyBackgroundColor(UIColor.blue)
    
/*  We could even make it a circle in one line. Under the hood, this
    combines makeWidth(...), makeHeight(...), and roundCorners(...)
 */
        
iconView.attachToParent(parentView)
    .pinTop(padding: 20)
    .pinLeft(padding: 20)
    .makeCircle(radius: 40)
    .addBorder(width: 2, color: UIColor.black)
    .applyBackgroundColor(UIColor.blue)
        
```
           
## UIStackView
<br />
Laying out views is so easy with SwiftUIKitUI that you may choose to forgo UIStackViews entirely. If not, they are now way easier to use, and almost rival the simplicity of VStack and HStack in SwiftUI. Let's layout a stack of three buttons to bottom of the parent view:

```swift
buttonStackView.attachToParent(parentView)
    .pinBottom(padding: 20)
    .pinLeft(padding: 20)
    .pinRight(padding: 20)
    .makeHeight(170)
    .makeVertical(spacing: 10, distribution: .fillEqually, alignment: .fill)
    .addArrangedSubviews([button1, button2, button3])
```
<br />
If you really want to be fancy, you can use the createChild<T>(ofType: T.Type) method provided by SwiftUIKitUI to create the stack view (or some other container view) directly in line, and (optionally) capture it in a variable. Combined with using pinSides with non default parameters, we can accomplish this whole layout in five lines!
    
```swift
let stackView = parentView.createChild(ofType: UIStackView.self)
    .pinSides([.bottom, .left, .right], padding: 20, useSafeAreas: true)
    .makeHeight(170)
    .makeVertical(spacing: 10, distribution: .fillEqually, alignment: .fill)
    .addArrangedSubviews([button1, button2, button3])
```
    

<br />
<br />
UILabels are also easier to work with and more intuitive. 
