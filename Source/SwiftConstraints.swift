
import UIKit

public extension UIView {
    
    /**
        Adds a constraint to a subview.
     
        This will order the views in the constraint so that a positive constant
        will move towards the centre of the superview.
    */
    @discardableResult
    func addConstraint(toItem item: UIView, attribute: NSLayoutAttribute, relatedBy: NSLayoutRelation = .equal, multiplier: CGFloat = 1, constant: CGFloat = 0) -> NSLayoutConstraint {
        var firstView, secondView: UIView
        switch attribute {
        case .top, .leading, .centerX, .centerY:
            firstView = item
            secondView = self
        default:
            firstView = self
            secondView = item
        }
        
        let constraint = NSLayoutConstraint(item: firstView, attribute: attribute, relatedBy: relatedBy, toItem: secondView, attribute: attribute, multiplier: multiplier, constant: constant)
        self.addConstraint(constraint)
        return constraint
    }
    
    /**
        Adds constraints to make a subview fill the superview.
     
        This adds leading, trailing, top and bottom constraints. The constant
        specifies a padding on all sides, with positive values going inwards.
    */
    @discardableResult
    func addConstraints(fillView item: UIView, constant: CGFloat = 0) -> [NSLayoutConstraint] {
        var constraints: [NSLayoutConstraint] = []
        
        constraints.append(self.addConstraint(toItem: item, attribute: .leading, constant: constant))
        constraints.append(self.addConstraint(toItem: item, attribute: .trailing, constant: constant))
        constraints.append(self.addConstraint(toItem: item, attribute: .top, constant: constant))
        constraints.append(self.addConstraint(toItem: item, attribute: .bottom, constant: constant))
        
        return constraints
    }
    
    /**
        Adds a constraint to two subviews.
        
        This will order the views in the constraint so that a positive constant
        will move the second subview in an inwards direction relative to the
        first.
    */
    @discardableResult
    func addConstraint(withItems firstItem: UIView, andItem secondItem: UIView, attribute: NSLayoutAttribute, relatedBy: NSLayoutRelation = .equal, multiplier: CGFloat = 1, constant: CGFloat = 0) -> NSLayoutConstraint {
        var firstView, secondView: UIView
        switch attribute {
        case .top, .left:
            firstView = secondItem
            secondView = firstItem
        default:
            firstView = firstItem
            secondView = secondItem
        }
        
        let constraint = NSLayoutConstraint(item: firstView, attribute: attribute, relatedBy: relatedBy, toItem: secondView, attribute: attribute, multiplier: multiplier, constant: constant)
        self.addConstraint(constraint)
        return constraint
    }
    
    /**
        Adds a constraint between two subviews.
        
        This will order the views in the constraint so that a positive constant
        will move both subviews apart.
    */
    @discardableResult
    func addConstraint(betweenItems item: UIView, toItem: UIView, axis: UILayoutConstraintAxis, relatedBy: NSLayoutRelation = .equal, multiplier: CGFloat = 1, constant: CGFloat = 0) -> NSLayoutConstraint {
        
        var firstAttribute, secondAttribute: NSLayoutAttribute
        switch axis {
        case .horizontal:
            firstAttribute = .left
            secondAttribute = .right
        case .vertical:
            firstAttribute = .top
            secondAttribute = .bottom
        }
        
        let constraint = NSLayoutConstraint(item: toItem, attribute: firstAttribute, relatedBy: relatedBy, toItem: item, attribute: secondAttribute, multiplier: multiplier, constant: constant)
        self.addConstraint(constraint)
        return constraint
    }
    
    /**
        Add a constraint related to the view itself. By default, this will use
        .notAnAttribute for the second item, which behaves as setting the first
        attribute to the constant.
    */
    @discardableResult
    func addConstraint(toSelf attribute: NSLayoutAttribute, toAttribute: NSLayoutAttribute = .notAnAttribute, relatedBy: NSLayoutRelation = .equal, multiplier: CGFloat = 1, constant: CGFloat = 0) -> NSLayoutConstraint {
        let toItem: UIView? = toAttribute == .notAnAttribute ? nil : self
        let constraint = NSLayoutConstraint(item: self, attribute: attribute, relatedBy: relatedBy, toItem: toItem, attribute: toAttribute, multiplier: multiplier, constant: constant)
        self.addConstraint(constraint)
        return constraint
    }
    
    /**
        Add constraints where all the subviews are the same dimension.
    */
    @discardableResult
    func addConstraints(equalDimensions items: [UIView], axis: UILayoutConstraintAxis) -> [NSLayoutConstraint] {
        guard let firstView = items.first else {
            return []
        }
        
        let attribute: NSLayoutAttribute
        switch axis {
        case .horizontal:
            attribute = .width
        case .vertical:
            attribute = .height
        }
        
        var constraints: [NSLayoutConstraint] = []
        
        for item in items {
            if item != firstView {
                constraints.append(self.addConstraint(withItems: firstView, andItem: item, attribute: attribute, relatedBy: .equal, multiplier: 1, constant: 0))
            }
        }
        
        return constraints
    }
    
    @discardableResult
    func addConstraints(alignItems items: [UIView], attribute: NSLayoutAttribute) -> [NSLayoutConstraint] {
        guard let firstView = items.first else {
            return []
        }
        
        var constraints: [NSLayoutConstraint] = []
        
        for item in items {
            if item != firstView {
                constraints.append(self.addConstraint(withItems: firstView, andItem: item, attribute: attribute, relatedBy: .equal, multiplier: 1, constant: 0))
            }
        }
        
        return constraints
    }
    
    /**
        Add constraints to equally space subviews in a superview.
        
        The constant will determine the spacing between each item. The leftView
        and rightView, if given, will be used to align the left-most and right-
        most items to.
    */
    @discardableResult
    func addConstraints(equallySpaced items: [UIView], axis: UILayoutConstraintAxis, leftView: UIView? = nil, rightView: UIView? = nil, multiplier: CGFloat = 1, constant: CGFloat = 0) -> [NSLayoutConstraint] {
        
        guard let firstView = items.first, let lastView = items.last else {
            return []
        }
        
        var constraints: [NSLayoutConstraint] = []
        
        if let leftView = leftView {
            constraints.append(self.addConstraint(betweenItems: leftView, toItem: firstView, axis: axis, relatedBy: .equal, multiplier: 1, constant: constant))
        } else {
            let attribute: NSLayoutAttribute
            switch axis {
            case .horizontal:
                attribute = .leading
            case .vertical:
                attribute = .top
            }
            constraints.append(self.addConstraint(toItem: firstView, attribute: attribute, relatedBy: .equal, multiplier: 1, constant: constant))
        }
        if let rightView = rightView {
            constraints.append(self.addConstraint(betweenItems: lastView, toItem: rightView, axis: axis, relatedBy: .equal, multiplier: 1, constant: constant))
        } else {
            let attribute: NSLayoutAttribute
            switch axis {
            case .horizontal:
                attribute = .trailing
            case .vertical:
                attribute = .bottom
            }
            constraints.append(self.addConstraint(toItem: lastView, attribute: attribute, relatedBy: .equal, multiplier: 1, constant: constant))
        }
        
        var previousView: UIView? = nil
        
        for item in items {
            if let previousView = previousView {
                constraints.append(self.addConstraint(betweenItems: previousView, toItem: item, axis: axis, relatedBy: .equal, multiplier: multiplier, constant: constant))
            }
            
            previousView = item
        }
        
        return constraints
    }
}
