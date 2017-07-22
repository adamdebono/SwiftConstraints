
import UIKit

public extension UIView {
    
    /// Adds a constraint to a subview.
    ///
    /// This will order the views in the constraint so that a positive constant
    /// will move towards the centre of the superview.
    ///
    /// - parameter item:       The other item participating in the constraint
    /// - parameter attribute:  The attribute of both views participating in the
    ///                         constraint
    /// - parameter relatedBy:  The relation between the two attributes
    /// - parameter multiplier: The multiplier applied to the constant
    /// - parameter constant:   The offset of item from the parent view
    ///
    /// - returns: The added layout constraint
    @discardableResult
    func addConstraint(toItem item: UIView, attribute: NSLayoutAttribute, relatedBy: NSLayoutRelation = .equal, multiplier: CGFloat = 1, constant: CGFloat = 0, priority: UILayoutPriority = .required) -> NSLayoutConstraint {
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
        constraint.priority = priority
        self.addConstraint(constraint)
        return constraint
    }
    
    /// Adds constraints to make a subview fill the superview.
    ///
    /// This adds leading, trailing, top and bottom constraints. The constant
    /// specifies a padding on all sides, with positive values going inwards.
    ///
    /// - parameter item:     The other item participating in the constraint
    /// - parameter constant: The amount of padding from the parent view
    ///
    /// - returns: The added layout constraints
    @discardableResult
    func addConstraints(fillView item: UIView, constant: CGFloat = 0, priority: UILayoutPriority = .required) -> [NSLayoutConstraint] {
        var constraints: [NSLayoutConstraint] = []
        
        constraints.append(self.addConstraint(toItem: item, attribute: .leading, constant: constant, priority: priority))
        constraints.append(self.addConstraint(toItem: item, attribute: .trailing, constant: constant, priority: priority))
        constraints.append(self.addConstraint(toItem: item, attribute: .top, constant: constant, priority: priority))
        constraints.append(self.addConstraint(toItem: item, attribute: .bottom, constant: constant, priority: priority))
        
        return constraints
    }
    
    /// Adds a constraint to two subviews.
    ///
    /// This will order the views in the constraint so that a positive constant
    /// will move the second subview in an inwards direction relative to the
    /// first.
    ///
    /// - parameter firstItem:  The first item participating in the constraint
    /// - parameter secondItem: the second item participating in the constraint
    /// - parameter attribute:  The attribute of both views participating in the
    ///                         constraint
    /// - parameter relatedBy:  The relation between the two attributes
    /// - parameter multiplier: The multiplier applied to the constant
    /// - parameter constant:   The offset of both participating view from each
    ///                         other's attribute
    ///
    /// - returns: The added layout constraint
    @discardableResult
    func addConstraint(withItems firstItem: UIView, andItem secondItem: UIView, attribute: NSLayoutAttribute, relatedBy: NSLayoutRelation = .equal, multiplier: CGFloat = 1, constant: CGFloat = 0, priority: UILayoutPriority = .required) -> NSLayoutConstraint {
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
        constraint.priority = priority
        self.addConstraint(constraint)
        return constraint
    }
    
    /// Adds a constraint between two subviews.
    ///
    /// This will order the views in the constraint so that a positive constant
    /// will move both subviews apart.
    ///
    /// - parameter item:       The first item participating in the constraint
    /// - parameter toItem:     The second item participating in the constraint
    /// - parameter axis:       The axis which the items are aligned by
    /// - parameter relatedBy:  The relation between the attributes
    /// - parameter multipler:  The multiplier applied to the constant
    /// - parameter constant:   The space between the views
    ///
    /// - returns: The added layout constraint
    @discardableResult
    func addConstraint(betweenItems item: UIView, toItem: UIView, axis: UILayoutConstraintAxis, relatedBy: NSLayoutRelation = .equal, multiplier: CGFloat = 1, constant: CGFloat = 0, priority: UILayoutPriority = .required) -> NSLayoutConstraint {
        
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
        constraint.priority = priority
        self.addConstraint(constraint)
        return constraint
    }
    
    /// Add a constraint related to the view itself.
    ///
    /// By default, this will use .notAnAttribute for the second item, which
    /// behaves as setting the first attribute to the constant.
    ///
    /// - parameter attribute:    The attribute of the object to apply
    /// - parameter toAttribute:  The second attribute of the object to apply
    /// - parameter relatedBy:    The relation between the attributes
    /// - parameter multiplier:   The multipler applied to the constant
    /// - parameter constant:     The constant applied to the constraint
    ///
    /// - returns: The added layout constraint
    @discardableResult
    func addConstraint(toSelf attribute: NSLayoutAttribute, toAttribute: NSLayoutAttribute = .notAnAttribute, relatedBy: NSLayoutRelation = .equal, multiplier: CGFloat = 1, constant: CGFloat = 0, priority: UILayoutPriority = .required) -> NSLayoutConstraint {
        let toItem: UIView? = toAttribute == .notAnAttribute ? nil : self
        let constraint = NSLayoutConstraint(item: self, attribute: attribute, relatedBy: relatedBy, toItem: toItem, attribute: toAttribute, multiplier: multiplier, constant: constant)
        constraint.priority = priority
        self.addConstraint(constraint)
        return constraint
    }
    
    /// Add constraints where all the items have the same dimension across an
    /// axis.
    ///
    /// - parameter items:  The items to match dimensions on
    /// - parameter axis:   The axis to match dimensions on
    ///
    /// - returns: The added layout constraints
    @discardableResult
    func addConstraints(equalDimensions items: [UIView], axis: UILayoutConstraintAxis, priority: UILayoutPriority = .required) -> [NSLayoutConstraint] {
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
                constraints.append(self.addConstraint(withItems: firstView, andItem: item, attribute: attribute, relatedBy: .equal, multiplier: 1, constant: 0, priority: priority))
            }
        }
        
        return constraints
    }
    
    /// Add constraints where all the items are aligned to an attribute.
    ///
    /// - parameter items:      The items to align
    /// - parameter attribute:  The attribute to align the items to
    ///
    /// - returns: The added layout constraints
    @discardableResult
    func addConstraints(alignItems items: [UIView], attribute: NSLayoutAttribute, priority: UILayoutPriority = .required) -> [NSLayoutConstraint] {
        guard let firstView = items.first else {
            return []
        }
        
        var constraints: [NSLayoutConstraint] = []
        
        for item in items {
            if item != firstView {
                constraints.append(self.addConstraint(withItems: firstView, andItem: item, attribute: attribute, relatedBy: .equal, multiplier: 1, constant: 0, priority: priority))
            }
        }
        
        return constraints
    }
    
    /// Add constraints to equally space subviews in a superview.
    ///
    /// The constant will determine the spacing between each item. The leftView
    /// and rightView, if given, will be used to align the left-most and right-
    /// most items to.
    ///
    /// - parameter items:      The items to add space between
    /// - parameter axis:       The axis to align items on
    /// - parameter leftView:   The left view (or nil) to align the left-most
    ///                         item to
    /// - parameter rightView:  The right view (or nil) to align the right-most
    ///                         item to
    /// - parameter constant:   The amount of space between the views
    ///
    /// - returns: The added layout constraints
    @discardableResult
    func addConstraints(equallySpaced items: [UIView], axis: UILayoutConstraintAxis, leftView: UIView? = nil, rightView: UIView? = nil, constant: CGFloat = 0, priority: UILayoutPriority = .required) -> [NSLayoutConstraint] {
        
        guard let firstView = items.first, let lastView = items.last else {
            return []
        }
        
        var constraints: [NSLayoutConstraint] = []
        
        if let leftView = leftView {
            constraints.append(self.addConstraint(betweenItems: leftView, toItem: firstView, axis: axis, relatedBy: .equal, multiplier: 1, constant: constant, priority: priority))
        } else {
            let attribute: NSLayoutAttribute
            switch axis {
            case .horizontal:
                attribute = .leading
            case .vertical:
                attribute = .top
            }
            constraints.append(self.addConstraint(toItem: firstView, attribute: attribute, relatedBy: .equal, multiplier: 1, constant: constant, priority: priority))
        }
        if let rightView = rightView {
            constraints.append(self.addConstraint(betweenItems: lastView, toItem: rightView, axis: axis, relatedBy: .equal, multiplier: 1, constant: constant, priority: priority))
        } else {
            let attribute: NSLayoutAttribute
            switch axis {
            case .horizontal:
                attribute = .trailing
            case .vertical:
                attribute = .bottom
            }
            constraints.append(self.addConstraint(toItem: lastView, attribute: attribute, relatedBy: .equal, multiplier: 1, constant: constant, priority: priority))
        }
        
        var previousView: UIView? = nil
        
        for item in items {
            if let previousView = previousView {
                constraints.append(self.addConstraint(betweenItems: previousView, toItem: item, axis: axis, relatedBy: .equal, multiplier: 1, constant: constant, priority: priority))
            }
            
            previousView = item
        }
        
        return constraints
    }
}
