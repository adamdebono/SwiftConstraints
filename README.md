# SwiftConstraints
Swifty mappings for NSLayoutConstraint.

## Installation

### Cocoapods
```ruby
pod 'SwiftConstraints', '~> 1.0.1'
```

## Usage

### Add a constraint between a view's subview
```swift
// align the subview 10 points from the left of the superview
superview.addConstraint(toItem: subview, attribute: .leading, constant: 10)

// align the subview 20 points or less from the vertical center of the superview
superview.addConstraint(toItem: subview, attribute: .centerY, relatedBy: .lessThanOrEqual, constant: 20)
```

### Add constraints to fill a view
```swift
// subview completely fill the superview
superview.addConstraints(fillView: subview)

// subview fill the superview with 20 points of padding
superview.addConstraints(fillView: subview, constant: 20)
```

### Add constraints to two of the view's subviews
```swift
// align the left sides of two view by 10 points
superview.addConstraint(withItems: viewOne, andItem: viewTwo, attribute: .left, constant: 10)

// align the first baseline of two labels
superview.addConstraint(withItems: labelOne, andItem: labelTwo, attribute: .firstBaseline)
```

### Add constraints between two of the view's subviews
```swift
// sit two views next to each other horizontally
superview.addConstraint(betweenItems: viewOne, toItem: viewTwo, axis: .horizontal)

// put the second view underneath the first view by 15 points
superview.addConstraint(betweenItems: viewOne, toItem: viewTwo, axis: .vertical, constant: 15)
```

### Add a constraint to the view itself
```swift
// set the view width to 120 points
superview.addConstraint(toSelf: .width, constant: 120)

// set the aspect ratio of the view to 16:9 or greater
superview.addConstraint(toSelf: .width, toAttribute: .height, multiplier: 16/9.0, constant: 0)
```

### Add constraints to give equal dimensions to subviews
```swift
// Set views to the same height
superview.addConstraints(equalDimensions: [viewOne, viewTwo, viewThreee, viewFour], axis: .vertical)
```

### Add constraints to align subviews
```swift
// Align views to the horizontal center of the view
superview.addConstraints(alignItems: [viewOne, viewTwo, viewThreee, viewFour], attribute: .centerX)
```

### Add constraints to space subviews
```swift
// evenly space views horizontally with 20 points of padding in a superview
superview.addConstraints(equallySpaced: [viewOne, viewTwo, viewThreee, viewFour], axis: .horizontal, constant: 20)
```
