# SwiftUIKitUI

SwiftUIKitUI is a set of lightweight extensions that make working with AutoLayout and UIKit easy and intuitive. After 5-minutes you'll never go back.

## AutoLayout

Programmatic layout in UIKit with AutoLayout is powerful, imperative, and adapts well to all the different screen sizes iOS developers are expected to support. It’s also way too verbose, overly complicated, and a pain to work with. SwiftUIKitUI aims to solves these problems while staying true to the framework and avoiding new patterns or layout paradigms. Let's have a look!
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

Yuck. So verbose! Five references to parentView. Six to childView! Of course, don't forget to set  translatesAutoresizingMaskIntoConstraints = false, because, reasons (but seriously, don't forget). Wrapping each constraint in an array inside a static method on NSLayoutConstraint? Cool. Oh, and intimate knowledge of the unique iOS coordinate system is required to make sure you don't set the signs on the constants incorrectly. Fantastic.  

There must be a better way! With SUIKUI, there is.  

```swift

childView.attachToParent(parentView)
    .pinSides(padding: 20)
    
```
<br />

That's it! pinSides(...) is the most basic method (we'll get to more advanced stuff in a bit) but its worth exploring some of the optional parameters because the patterns you see here are mostly consistent throughout SUIKUI. 

```swift

// We don't always want to pin a view to its parent. Lets pin to another child view instead
// Be careful here, just like with autolayout, they must share an ancestor
childView.attachToParent(parentView)
    .pinSides(toView: otherChildView, padding: 20)

// Want to customize the padding? No problem
childView.attachToParent(parentView)
    .pinSides(padding: 20, customPadding: [.left(40), .right(40)])

// Safe areas are not respected by default, but we can change that
childView.attachToParent(parentView)
    .pinSides(respectSafeAreas: true)

// We can even capture the constraints if we need to reference and/or mutate them later
var topConstraint : NSLayoutConstraint!
var bottomConstraint : NSLayoutConstraint!
childView.attachToParent(parentView)
    .pinSides(toView: otherChildView, padding: 20) { constraints in
        topConstraint = constraints.topConstraint
        bottomConstraint = constraints.bottomConstraint
    }
    
```

#### On to the real stuff...

pinSides(…) is great, but only for container views and the most basic layouts. Let's pin a view to it's parent, but this time with the more granular APIs SUIKUI provides. 

```swift

/*  Views are pinned to the same anchor on their parent view, unless we tell them otherwise.
    i.e. pinLeft() will pin the child's left view to its parent's left view.    */

childView.attachToParent(parentView)
    .pinLeft()
    .pinRight()
    .pinTop()
    .pinBottom()
    
// this is the equivalent to pinSides()

```

You'll notice how you can chain these methods together, which is a signature feature in SUIKUI. It makes writing layout code (and other UIKit code as you'll see below) really quick and easy. This style was inpsired by SwiftUI, but unlike SwiftUI, the order in which you chain these methods does not matter, so go nuts.

Let's keep going: 

```swift 

/*  Of course, we don't always want to pin a child anchor to its parent's
    corresponding anchor. We can use the optional anchor parameter to set a 
    different one whereever we want, and optionally add padding.    */
 
 childView.attachToParent(parentView)
    .pinLeft(padding: 20)
    .pinRight(anchor: otherChildView.leftAnchor, padding: 20)
    .pinTop(padding: 20)
    .pinBottom(anchor: otherChildView.topAnchor)
    
/*  Instead of pinning sides, we can use makeWidth(..) and makeHeight(...)
    to set an explicit height or width, in points. Let's pin a 40x40 square
    in the upper left corner, with a padding of 20 on each side.    */

childView.attachToParent(parentView)
    .pinTop(padding: 20)
    .pinLeft(padding: 20)
    .makeWidth(40)
    .makeHeight(40)
    
/*   Let's layout another view to the right of the one above, and extend
     it to the right edge, maintaining the same padding and 40pt height.    */

otherChildView.attachToParent(parentView)
    .pinLeft(anchor: childView.rightAnchor, padding: 20)
    .pinRight(padding: 20)
    .pinTop(anchor: childView.topAnchor)
    .pinBottom(anchor: childView.bottomAnchor)
    
    
/*  Alternatively, we could have used pinCenterY(...) and matchHeight(...)
    to achieve the same layout.     */

otherChildView.attachToParent(parentView)
    .pinLeft(anchor: childView.rightAnchor, padding: 20)
    .pinRight(padding: 20)
    .pinCenterY(anchor: childView.centerYAnchor)
    .matchHeight(anchor: childView.heightAnchor)
    
 ```
 
Not all layouts are this simple, especially dynamic ones that respond to user input. That's where a lot of the other optional parameters come in to play:

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
    .pinLeft(constraintType: .lessThanOrEqualTo)
```

Once you get used to chaining everything, you'll want to do it everywhere. So there's even createChild() and createChild<T>(ofType: T.Type) methods which allow you to create views (and optionally capture them) directly inline. This is great for creating container views that don't need to be accessed through global variables
    
```swift
let containerView = parentView.createChild()
    .pinSides()

let stackView = parentView.createChild(ofType: UIStackView.self)
    .pinSides(padding: 20)

let imageView = parentView.createChild(ofType: UIImageView.self)
    .pinTop(padding: 20)
    .pinLeft(padding: 20)
    .makeCircle(radius: 40)
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

### UILabel

UILabels have some funky qualities. They are self-sizing by default, until some other constraint pushes on them. They are single line by default, and to change that, you have to set the number of lines to...zero. They are annoying to format, as you have often have to change their text value, color, font, alignment, and textSize in multiple lines of code. SwiftUIKitUI helps to make this all easier with some more intuitive APIs:

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
If you really want to be fancy, you can use the createChild<T>(ofType: T.Type) method provided by SwiftUIKitUI to create the stack view (or some other container view) directly inline, and (optionally) capture it in a variable. Combined with using pinSides(...) with non default parameters, we can accomplish this whole layout in five lines!
    
```swift
let stackView = parentView.createChild(ofType: UIStackView.self)
    .pinSides([.bottom, .left, .right], padding: 20, useSafeAreas: true)
    .makeHeight(170)
    .makeVertical(spacing: 10, distribution: .fillEqually, alignment: .fill)
    .addArrangedSubviews([button1, button2, button3])
```
    
### UITableView

After implementing hundreds (or thousands?) of tableViews, I got really sick of the whole dance of assigning the delegate and datasource (almost always to the same ViewController implementing them), registering all the cell types, and then dequeing cells. Registering cells was not only annoying, but forgetting to do so would result in a runtime crash (assuming you hard unwrap in dequeue, which you probably do).

SwiftUIKitUI has a few convenience APIs to make this a little cleaner and easier. Wherever you configure the tableView, you can use implementLocally() to assign the datasource and delegate to the viewController you're using:
    
```swift
tableView.attachToParent(parentView)
    .pinSides(useSafeAreas: true)
    .implementLocally()
    .hideScrollIndicator()
```
    
Then, in cellForRow, instead of using dequeueReusableCell(...), use createCustomCellOfType<T>(type: T.Type). Under the hood, this will automatically register the cell by its class name, and then create it by using dequeueReusableCell. No more registering cells (or forgetting to)!
    
```swift
let cell = createCustomCellOfType(CustomCell.self)
cell.configureCell(viewModel: customCellViewModel)
return cell
```

It's possible this has scroll performance implications. I couldn't find the "cost" of registering a cell anywhere. If anyone has any insight, I'd love to hear it!

