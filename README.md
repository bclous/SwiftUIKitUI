# SwiftUIKitUI (SUIKUI)

SwiftUIKitUI (SUIKUI) is a set of lightweight extensions that make working with AutoLayout and UIKit easy and intuitive. After 5-minutes you'll never go back.

## AutoLayout

Programmatic layout in UIKit with AutoLayout is powerful, imperative, and adapts well to the screen sizes iOS developers are expected to support. It’s also way too verbose, overly complicated, and a pain to work with. SUIKUI aims to solves these problems while staying true to the framework and avoiding new patterns or layout paradigms. Let's have a look!
<br />

Let's say you want to pin a view directly to its parent, with a padding of 20pts on each side. Your standard "container" view. You may be used to writing something like this:

```swift

parentView.addSubview(childView)
childView.translatesAutoresizingMaskIntoConstraints = false
NSLayoutConstraint.activate([
    childView.leftAnchor.constraint(equalTo: parentView.leftAnchor, constant: 20),
    childView.rightAnchor.constraint(equalTo: parentView.rightAnchor, constant: -20),
    childView.topAnchor.constraint(equalTo: parentView.topAnchor, constant: 20),
    childView.bottomAnchor.constraint(equalTo: parentView.bottomAnchor, constant: -20)
])

```

Yuck. So verbose! Five references to parentView. Six to childView! Of course, don't forget to set  translatesAutoresizingMaskIntoConstraints = false, because, reasons (but seriously, don't forget). Wrapping each constraint in an array inside a static method on NSLayoutConstraint...cool. Oh, and intimate knowledge of the unique iOS coordinate system is required to make sure you don't set the signs on the constants incorrectly. Fantastic.  

There must be a better way! With SUIKUI, there is.  

```swift

childView.attachToParent(parentView)
    .pinSides(padding: 20)
    
```
<br />

That's it! Just two methods:

* `attachToParent(_ parentView:)` - This is the same as parentView.addSubview(childView), just in reverse. Calling this from the childView allows us to chain additional layout methods after it, the most basic being...

* `pinSides(...)` - This takes care of the rest of the layout. pinSides(...) is the most basic method (we'll get to more advanced stuff in a bit) but its worth exploring the optional parameters because the patterns you see here are mostly consistent throughout SUIKUI. 

```swift

@discardableResult public func pinSides(_ sides: [Side] = [.left, .right, .top, .bottom],
                                        toView anchorView: UIView? = nil,
                                        padding: CGFloat = 0,
                                        customPadding: [Padding] = [],
                                        respectSafeAreas: Bool = false,
                                        customSafeAreas: [Side] = [],
                                        capture: ((_ constraints: SideConstraints) -> Void)? = nil) -> Self
                                        
```

You can customize which sides you pin (it defaults to all of them), and/or which anchorView you're pinning to (if nil, it defaults to the parent view). 

The padding and safe area behavior can be also be customized overall or on a per side level. 

SUIKUI often abstracts away the NSLayoutConstraints from the user, but sometimes you need to capture the constraints directly to mutate them later on. The capture block allows you to do this:


```swift
// We can capture the constraints if we need to reference and/or mutate them later
var topConstraint : NSLayoutConstraint!
var bottomConstraint : NSLayoutConstraint!
childView.attachToParent(parentView)
    .pinSides(padding: 20) { constraints in
        topConstraint = constraints.topConstraint
        bottomConstraint = constraints.bottomConstraint
    }
    
```

<br />

pinSides(…) is great, but only for container views and the most basic layouts. SUKUI provides several more granular APIs which are likely the ones you'll use most of the time:
 
#### Sides
* `pinLeft(...)`
* `pinRight(...)`
* `pinLeading(...)`
* `pinTrailing(...)`
* `pinTop(...)`
* `pinBottom(...)`
    
#### Centers
* `pinCenterX(...)`
* `pinCenterY(...)`
* `pinCenter(...)` 

#### Matching sizes
* `matchHeight(...)`
* `matchWidth(...)`
* `matchSize(...)`  

#### Constant sizes
* `makeHeight(...)`
* `makeWidth(...)`
* `makeSize(...)`
* `makeCircle(...)`

<br />

I like to think this is exactly what Apple's AutoLayout APIs would have looked like if they were written in Swift, with the power of optional parameters, instead of Objective-C. 

Let's see them in action. We can perform the equivalent to pinSides() using left, right, top and bottom:

```swift

childView.attachToParent(parentView)
    .pinLeft()
    .pinRight()
    .pinTop()
    .pinBottom()

```

You'll notice how you can chain these methods together, which is a signature feature in SUIKUI. It makes writing layout code (and other UIKit code as you'll see below) really easy and keeps things super readable. This style was inpsired by SwiftUI, but unlike SwiftUI, the order in which you chain these methods does not matter, so go nuts.

Let's explore pinLeft(...), which has the same optional parameters as all of the "Sides" methods:

```swift

@discardableResult public func pinLeft(anchor: NSLayoutXAxisAnchor? = nil, 
                                       padding: CGFloat = 0, 
                                       respectSafeAreas: Bool = false, 
                                       constraintType: ConstraintType = .equalTo, 
                                       isActive: Bool = true, 
                                       priority: UILayoutPriority = .required, 
                                       capture: ((_ constraint: NSLayoutConstraint) -> Void)? = nil) -> Self

```

Unlink pinSides(...) where we pass in an optional view to pin to, here we pass in an optional anchor. If nil, it will default to the same anchor on the parent view (i.e. pinLeft() will pin the view's left anchor to the parent's left anchor). Of course, we don't always want this, so we have the option to set it to something else.

We can also customize the padding, and/or the safe area behavior (respectSafeAreas only applies when anchor is nil, otherwise it will pin to the anchor that was explicitly set). 

The constraint type defaults to .equalTo, but it can be set to .greaterThanOrEqualTo or .lessThanOrEqualTo which are used in more advanced layouts. 

The constraint is assumed to be active, with a priority of .required, but these can also be changed. And of course, we can capture the constraint in the capture block, for use later on. 

Let's take these all for a spin: 

```swift

/*  Let's create a 60pt circle in the top left hand corner with 20pts padding */

circleView.attachToParent(parentView)
    .pinTop(padding: 20)
    .pinLeft(padding: 20)
    .makeCircle(diameter: 60)

/*  Let's lay a view out 20 pts to the right of that child view, 
    lined up vertically with the same height, and then extend it 
    to the end of the screen with 20 pts padding   */
 
 secondaryView.attachToParent(parentView)
    .pinLeft(anchor: circleView.rightAnchor, paddding: 20)
    .pinRight(padding: 20)
    .pinTop(anchor: circleView.topAnchor)
    .pinBottom(anchor: circleView.bottomAnchor)
    
/*  Alternatively, we could have accomplished the same with:  */    
    
  secondaryView.attachToParent(parentView)
    .pinLeft(anchor: circleView.rightAnchor, paddding: 20)
    .pinRight(padding: 20)
    .pinCenterY(anchor: circleView.centerYAnchor)
    .matchHeight(anchor: circleView.heightAnchor)
    
 ```

Not all layouts are this simple, especially dynamic ones that respond to user input. That's where a lot of the other optional parameters come in to play:

```swift

/*  Let's make two left constraints, both not active,
    and capture them for later use, maybe in an animation   */
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

        
/*  You can even use lessThanOrEqualTo or greaterThanOrEqualTo constraint types,
    which are necessary in some advanced layouts    */

childView.attachToParent(parentView)
    .pinLeft()
    .pinRight()
    .pinTop()
    .pinBottom(constraintType: .lessThanOrEqualTo)
```

All of this is still AutoLayout, constraints, and anchors under the hood. So don't be shy about adding SUIKUI to a project with existing layouts. Even this purposesly silly example where we mix traditional Autolayout with SUIKUI on the same view would be totally fine:

```swift
parentView.addSubview(childView)
childView.translatesAutoresizingMaskIntoConstraints = false
childView.leftAnchor.constraint(equalTo: parentView.leftAnchor, constant: 20).isActive = true
childView.rightAnchor.constraint(equalTo: parentView.rightAnchor, constant: -20).isActive = true
    
childView
    .pinTop(padding: 20, respectsSafeArea: true)
    .pinBottom(padding: 20)
```


## Beyond Layout
Making programmatic AutoLayout easy is the superpower of SUIKUI, but there's some other features sprinkled on top of UIView, UIStackView, UILabel, and UIImageView that allow you to layout and configure your views all in one chained method, keeping your code clean and readable while allowing you to build quickly. 
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
            
```

### UILabel

UILabels have some funky qualities. They are self-sizing by default, until some other more powerful constraint pushes on them. They are single line by default, and to change that, you have to set the number of lines to...zero. They are annoying to format, as you have often have to change their text value, color, font, alignment, and textSize in multiple lines of code. SUIKUI helps to make this all easier with some more intuitive APIs:

```swift
label
    .style(font: UIFont.systemFont(ofSize: 12), textColor: UIColor.darkGray, alignment: .center)
    .adjustFontSizeToFitWidth()
    .makeMultiline()
    .enforceBindingSelfSizing(direction: .vertical)
    .applyText("Hellllllllllloooo nurse")
```

Let's imagine you had to implement the layout shown below of a transaction/price cell. The label on the right should always display its full value, and then label on the left may get cut off if the title is too long, with a minimum of 10pts between them: <br />

![rows](https://user-images.githubusercontent.com/16597079/194942759-35b19bb8-b115-4be8-abab-c6eac97f6dc6.png)

SwiftUIKitUI makes this really easy and clean to layout and configure:

```swift
rightLabel.attachToParent(parentView)
    .pinRight(padding: 20)
    .pinCenterY()
    .enforceBindingSelfSizing(direction: .horizontal)
    .style(font: UIFont.systemFont(ofSize: 14, weight: .bold), textColor: UIColor.black, alignment: .right)
    .applyText(rightLabelText)

leftLabel.attachToParent(parentView)
    .pinLeft(padding: 20)
    .pinRight(anchor: rightLabel.leftAnchor, padding: 10)
    .pinCenterY()
    .style(font: UIFont.systemFont(ofSize: 14), textColor: UIColor.black, alignment: .left)
    .applyText(leftLabelText)
```

If this was a TableViewCell (which it probably would be) that you wanted to make self sizing, you could wrap this all in a container view, pinned to the cell's content view on all sides and set with an explicit height of the cell height you desire:

```swift
let containerView = parentView.createChild()
    .pinSides()
    .makeHeight(40)

rightLabel.attachToParent(containerView)
    .pinRight(padding: 20)
    .pinCenterY()
    .enforceBindingSelfSizing(direction: .horizontal)
    .style(font: UIFont.systemFont(ofSize: 14, weight: .bold), textColor: UIColor.black, alignment: .right)
    .applyText(rightLabelText)

leftLabel.attachToParent(containerView)
    .pinLeft(padding: 20)
    .pinRight(anchor: rightLabel.leftAnchor, padding: 10)
    .pinCenterY()
    .style(font: UIFont.systemFont(ofSize: 14), textColor: UIColor.black, alignment: .left)
    .applyText(leftLabelText)
 ```

### UIImageView
    
Nothing new here, just wrapping some oft used UIImageView APIs into chainable methods so they can be combined with the layout code:

```swift
imageView
    .clipsToBounds()
    .applyContentMode(.scaleAspectFill)
    .applyImageWithName("imageName")


imageView.attachToParent(parentView)
    .pinLeft(20)
    .pinTop(20)
    .makeHeight(40)
    .makeWidth(40)
    .roundCorners(radius: 5)
    .clipsToBounds()
    .applyContentMode(.scaleAspectFit)
    .applyImageWithName("profilePicture")
```
    
    
### UIStackView

Laying out views is so easy with SUIKUI that you may choose to forgo UIStackViews entirely. If not, they are now way easier to use, and almost rival the simplicity of VStack and HStack in SwiftUI. Let's layout a stack of three buttons to bottom of the parent view:

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
If you really want to be fancy, you can use the createChild<T>(ofType: T.Type) method provided by SUIKUI to create the stack view (or some other container view) directly inline, and (optionally) capture it in a variable. Combined with using pinSides(...) with non default parameters, we can accomplish this whole layout in five lines!
    
```swift
let stackView = parentView.createChild(ofType: UIStackView.self)
    .pinSides([.bottom, .left, .right], padding: 20, useSafeAreas: true)
    .makeHeight(170)
    .makeVertical(spacing: 10, distribution: .fillEqually, alignment: .fill)
    .addArrangedSubviews([button1, button2, button3])
```


