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

pinSides(…) is great, but only for the most basic layouts. Most layouts require the next set of APIs:

* pinLeft(…), 
* pinRight(…)
* pinTop(…)
* pinBottom(…)
* pinCenterX(…)
* pinCenterY(…)

* makeHeight(…)
* makeWidth(…)

* matchHeight(…)
* matchWidth(…)

* makeCircle(…)
