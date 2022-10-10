# SwiftUIKitUI

SwiftUIKitUI is a set of lightweight extensions that make working with AutoLayout and UIKit easy, intuitive, and delightful. 

Programmatic layout in UIKit with AutoLayout is powerful, declarative, and adapts well to all the different screen sizes iOS developers are expected to support. It’s also way too verbose, overly complicated, and a pain to work with. SwiftUIKitUI aims to solves these problems while staying true to the framework and avoiding new patterns or layout paradigms. 

Let’s have a look!

If we want to pin a view entirely to its parent, all we have to do is attach it, and pin its sides. 

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
    This is the equivalent of pinSides(padding: 20)
 */

childView.attachToParent(parentView)
    .pinLeft(padding: 20)
    .pinRight(padding: 20)
    .pinTop(padding: 20)
    .pinBottom(padding: 20)
        
    
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
    it to the right edge, maintaining the same padding and 40pt height
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
