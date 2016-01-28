//
//  DynamicScrolling.swift
//  Scrolling
//
//  Created by Roselle Milvich on 5/14/15.
//  Copyright (c) 2015 Roselle Tanner. All rights reserved.
//

// ************* if changes are made, update Scrolling project *************
// update addConstraint
                //autorotation, where it left off


import Foundation
import UIKit


// MARK: ----------Enumerations----------

enum RSScrollingDirection {
    case horizontal,vertical, any
}


// MARK: ----------Class ResizableScrolling----------

class ScrollingHelper {
    
}


// MARK: Convenience functions to convert data to pages

extension ScrollingHelper {
    
    // makes textViews out of an array of strings
    func arrayOfTextViewsForStrings(strings: [String]) -> [UIView] {
        var textViewArray: [UITextView] = []
        for string in strings {
            let textView = UITextView()
            textView.text = string
            textView.textAlignment = NSTextAlignment.Center
            textViewArray.append(textView)
        }
        return textViewArray
    }
    
    // makes labels out of an array of strings
    func arrayOfLabelsForStrings(strings: [String], font: UIFont!) -> [UIView] {
        var labelArray: [UILabel] = []
        var thisFont = font
        if thisFont == nil {
            thisFont = UIFont(name: "arial", size: 8)
        }
        for string in strings {
            let label = UILabel()
            label.text = string
            label.textAlignment = NSTextAlignment.Center
            label.adjustsFontSizeToFitWidth = true
            label.font = thisFont
            label.minimumScaleFactor = 10/label.font.pointSize
            label.baselineAdjustment = UIBaselineAdjustment.AlignCenters
            label.numberOfLines = 0
            label.lineBreakMode = NSLineBreakMode.ByWordWrapping
            
            labelArray.append(label)
        }
        return labelArray
    }
}


// MARK: Sample Data

extension ScrollingHelper {
    func sampleColorPages() -> [UIView] {
        
        // sample content of views with background colors
        let colors = [UIColor.greenColor(), UIColor.redColor(), UIColor.purpleColor()]
        var colorViews: [UIView] = []
        
        for i in 0..<colors.count {
            let color = colors[i]
            let colorView = UIView()
            colorView.backgroundColor = color
            colorViews.append(colorView)
        }
        return colorViews
    }
}


// MARK: Public Methods

extension ScrollingHelper {
    
    func setupScrollingForView(scrollContainer: UIView, view: UIView) -> UIScrollView{
        
        // add a scrollView and bind all sides
        let scrollView = addScrollViewToContainerAndBind(scrollContainer, pagingEnabled: false)
        
        // add an imageView and bind all sides
        addContentViewToScrollViewAndBind(scrollView, contentView: view)
        
        return scrollView
    }
    
    func setupScrollingForImage(scrollContainer: UIView, imageName: String) -> (scrollView: UIScrollView, imageView: UIImageView) {
        
        let imageView = UIImageView(image: UIImage(named: imageName))
        let scrollView = setupScrollingForView(scrollContainer, view: imageView)
        return (scrollView, imageView)
    }
    
    func setupScrollingForViews(scrollContainer: UIView, views: [UIView], direction: RSScrollingDirection, pagingEnabled: Bool, oneViewPerPage: Bool) -> (scrollView: UIScrollView, contentView: UIView, views: [UIView]){
        //much of this is duplicated code from setupScrollingForPages, just added onePerPage as this class was originally intended to use pages and the documentation is clearer to leave it be.
        
        let scrollView = addScrollViewToContainerAndBind(scrollContainer, pagingEnabled: pagingEnabled)
        let contentView = addContentViewToScrollViewAndBind(scrollView, contentView: nil)
        
        switch (direction) {
        case .horizontal:
            scrollView.showsHorizontalScrollIndicator = true
            scrollView.showsVerticalScrollIndicator = false
            addPagesToContentViewAndBind(scrollContainer, scrollView: scrollView, contentView: contentView, pages: views, direction: direction, onePerPage: oneViewPerPage)
        case .vertical:
            scrollView.showsHorizontalScrollIndicator = false
            scrollView.showsVerticalScrollIndicator = true
            addPagesToContentViewAndBind(scrollContainer, scrollView: scrollView, contentView: contentView, pages: views, direction: direction, onePerPage: oneViewPerPage)
        default:
            scrollView.showsHorizontalScrollIndicator = true
            scrollView.showsVerticalScrollIndicator = true
            addPagesToContentViewAndBind(scrollContainer, scrollView: scrollView, contentView: contentView, pages: views, direction: direction, onePerPage: oneViewPerPage)
        }
        return (scrollView, contentView, views)
    }
    
    func setupScrollingForPages(scrollContainer: UIView, pages: [UIView], direction: RSScrollingDirection, pagingEnabled: Bool) -> (scrollView: UIScrollView, contentView: UIView, pages: [UIView]){
        
        let scrollView = addScrollViewToContainerAndBind(scrollContainer, pagingEnabled: pagingEnabled)
        let contentView = addContentViewToScrollViewAndBind(scrollView, contentView: nil)
        
        switch (direction) {
        case .horizontal:
            scrollView.showsHorizontalScrollIndicator = true
            scrollView.showsVerticalScrollIndicator = false
            addPagesToContentViewAndBind(scrollContainer, scrollView: scrollView, contentView: contentView, pages: pages, direction: direction, onePerPage: true)
        case .vertical:
            scrollView.showsHorizontalScrollIndicator = false
            scrollView.showsVerticalScrollIndicator = true
            addPagesToContentViewAndBind(scrollContainer, scrollView: scrollView, contentView: contentView, pages: pages, direction: direction, onePerPage: true)
        default:
            scrollView.showsHorizontalScrollIndicator = true
            scrollView.showsVerticalScrollIndicator = true
            addPagesToContentViewAndBind(scrollContainer, scrollView: scrollView, contentView: contentView, pages: pages, direction: direction, onePerPage: true)
        }
        return (scrollView, contentView, pages)
    }
}


// MARK: Meat of the class

extension ScrollingHelper {    
    func addScrollViewToContainerAndBind(scrollContainer: UIView, pagingEnabled: Bool) ->  UIScrollView {
        
        // add a scrollView as subview to scrollContainer
        let scrollView = UIScrollView()
        scrollContainer.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false  // don't forget this!v        scrollView.pagingEnabled = pagingEnabled
        
        // bind all sides of scrollView to its superview (scrollContainer)
        NSLayoutConstraint.activateConstraints(NSLayoutConstraint.constraintsToBindTopBottomLeftRight(scrollView))

        
        return scrollView
    }
    
    func addContentViewToScrollViewAndBind(scrollView: UIScrollView, contentView: UIView!) -> UIView {
        
        // add an empty contentView if not provided
        var thisContentView = contentView
        if thisContentView == nil {
            thisContentView = UIView()
        }
        
        // add contentView as subview to scrollView
        thisContentView.translatesAutoresizingMaskIntoConstraints = false // don't forget this!
        scrollView.addSubview(thisContentView)
        
        // bind all sides of contentView to its superview (scrollView)
        NSLayoutConstraint.activateConstraints(NSLayoutConstraint.constraintsToBindTopBottomLeftRight(thisContentView))
        
        return thisContentView
    }
    
    func addPagesToContentViewAndBind(scrollContainer: UIView, scrollView: UIScrollView, contentView: UIView, pages: [UIView], direction: RSScrollingDirection, onePerPage: Bool) {
        // onePerPage was added later, if !onePerPage stacked views of undetermined length are used instead of pages
        
        if contentView.subviews.count > 1 {
            contentView.removeFromSuperview()
            addContentViewToScrollViewAndBind(scrollView, contentView: contentView)
        }
        
        
        for i in 0..<pages.count {
            
            // add the pages as subviews to contentview
            let page = pages[i]
            contentView.addSubview(page)
            page.translatesAutoresizingMaskIntoConstraints = false    // don't forget this!
            
            // tring this out
            NSLayoutConstraint.activateConstraints([NSLayoutConstraint.constraintToKeepEqualWidth(page, view2: scrollContainer)])
            NSLayoutConstraint.activateConstraints([NSLayoutConstraint.constraintToKeepEqualHeight(page, view2: scrollContainer)])
            if direction == RSScrollingDirection.horizontal {
                NSLayoutConstraint.activateConstraints(NSLayoutConstraint.constraintsToBindTopBottom(page))
            } else {
                NSLayoutConstraint.activateConstraints(NSLayoutConstraint.constraintsToBindLeftRight(page))
            }
        }
        if direction == RSScrollingDirection.horizontal {
            NSLayoutConstraint.activateConstraints(NSLayoutConstraint.constraintsToBindViewsOneAfterAnother(pages, horizontalNotVertical: true))
        } else {
            NSLayoutConstraint.activateConstraints(NSLayoutConstraint.constraintsToBindViewsOneAfterAnother(pages, horizontalNotVertical: false))
            
        }
    }
}



// MARK: Instructions how to code dynamic layout scrolling
/*

1. add UIView named scrollContainer
a. bind all 4 sides appropriately where you want them

2. add UIScrollView named scrollView as subview to scrollContainer
a. bind all sides of scrollView to scrollContainer, (trailing, leading, bottom, top spaces = 0)

3. add UIView named contentView as subview to scrollView
a. bind all sides of contentView to scrollview, (trailing, leading, bottom, top spaces = 0)

4. if desired, add subviews to contentView (your content) (see below for programmatically added)
a. bind subviews how you want them in the 4 directions
b. set width and height for each
i. if scrolling all directions:
can have space in-between subviews or a freeform layout
ii. if scrolling vertically or horizontally
line them up one after another appropriately with H: or V:


visual format for vertically scrolling (swap V and H for horizontally scrolling:
V:|[scrollView]|
H:|[scrollView]|

V:|[contentView]|
H:|[contentView]|

V:|[page1(==scrollContainer)][page2(==scrollContainer)][page3(==scrollContainer)]|
H:|[page1(==scrollContainer)]|
H:|[page2(==scrollContainer)]|
H:|[page3(==scrollContainer)]|

resources:
http://stackoverflow.com/questions/13499467/uiscrollview-doesnt-use-autolayout-constraints
http://www.apeth.com/iOSBook/ch20.html
https://developer.apple.com/library/ios/releasenotes/General/RN-iOSSDK-6_0/index.html
*/
