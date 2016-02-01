//
//  Swift Extensions.swift
//  Scrolling
//
//  Created by Roselle Milvich on 1/27/16.
//  Copyright © 2016 Roselle Tanner. All rights reserved.
//

import UIKit

extension UIView {
    func scrollViews() -> [UIScrollView]{
        var scrollViews = [UIScrollView]()
        if self.isKindOfClass(UIScrollView) {
            scrollViews.append(self as! UIScrollView)
        }
        self.subviews.forEach { (subview: UIView) -> () in
            scrollViews += subview.scrollViews()
        }
        return scrollViews
    }
}

extension NSLayoutConstraint {
    class func constraintToCenterHorizontally(view: UIView) -> NSLayoutConstraint {
        return NSLayoutConstraint(item: view, attribute: .CenterX, relatedBy: .Equal, toItem: view.superview, attribute: .CenterX, multiplier: 1, constant: 0)
    }
    
    class func constraintToCenterVertically(view: UIView) -> NSLayoutConstraint {
        return NSLayoutConstraint(item: view, attribute: .CenterY, relatedBy: .Equal, toItem: view.superview, attribute: .CenterY, multiplier: 1, constant: 0)
    }
    
    class func constraintsToBindLeftRight(view: UIView) -> [NSLayoutConstraint] {
        return NSLayoutConstraint.constraintsWithVisualFormat("H:|[view]|", options: .DirectionLeadingToTrailing, metrics: nil, views: ["view" :view])
    }
    
    class func constraintsToBindTopBottom(view: UIView) -> [NSLayoutConstraint] {
        return NSLayoutConstraint.constraintsWithVisualFormat("V:|[view]|", options: .DirectionLeadingToTrailing, metrics: nil, views: ["view" :view])
    }
    
    class func constraintsToBindTopBottomLeftRight(view: UIView) -> [NSLayoutConstraint] {
        return constraintsToBindTopBottom(view) + constraintsToBindLeftRight(view)
    }
    
    class func constraintToKeepRatio(view: UIView) -> NSLayoutConstraint {
        return NSLayoutConstraint(item: view, attribute: .Width, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: .Height, multiplier: 1, constant: 0)
    }
    
    class func constraintToKeepEqualWidth(view1: UIView, view2: UIView) -> NSLayoutConstraint {
        return NSLayoutConstraint(item: view1, attribute: .Width, relatedBy: .Equal, toItem: view2, attribute: .Width, multiplier: 1, constant: 0)
    }
    
    class func constraintToKeepEqualHeight(view1: UIView, view2: UIView) -> NSLayoutConstraint {
        return NSLayoutConstraint(item: view1, attribute: .Height, relatedBy: .Equal, toItem: view2, attribute: .Height, multiplier: 1, constant: 0)
    }
    
    class func constraintsToBindViewsOneAfterAnother(views: [UIView], horizontalNotVertical: Bool) -> [NSLayoutConstraint] {
        // example of visual format: "H:|[view1][view2][view3]|"

        // set the format string and the views dictionary
        var viewsArray = [String: AnyObject]()
        var format = horizontalNotVertical ? "H:|" : "V:|"
        for (index, element) in views.enumerate() {
            viewsArray["view\(index)"] = element
            format += "[view\(index)]"
        }
        format += "|"
        
        //return the constraints
        return NSLayoutConstraint.constraintsWithVisualFormat(format, options: NSLayoutFormatOptions.DirectionLeadingToTrailing, metrics: nil, views: viewsArray)
    }
}
