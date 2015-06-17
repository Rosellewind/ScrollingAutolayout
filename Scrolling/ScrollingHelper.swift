//
//  DynamicScrolling.swift
//  Scrolling
//
//  Created by Roselle Milvich on 5/14/15.
//  Copyright (c) 2015 Roselle Tanner. All rights reserved.
//

// ************* if changes are made, update Scrolling project *************


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
            var textView = UITextView()
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
            thisFont = UIFont(name: "arial", size: 100)
        }
        for string in strings {
            var label = UILabel()
            label.text = string
            label.textAlignment = NSTextAlignment.Center
            label.adjustsFontSizeToFitWidth = true
            label.font = thisFont
            label.minimumScaleFactor = 10/label.font.pointSize
            label.baselineAdjustment = UIBaselineAdjustment.AlignCenters
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
            var colorView = UIView()
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
        var contentView = addContentViewToScrollViewAndBind(scrollView, contentView: view)
        
        return scrollView
    }
    
    func setupScrollingForImage(scrollContainer: UIView, imageName: String) -> (scrollView: UIScrollView, imageView: UIImageView) {
        
        let imageView = UIImageView(image: UIImage(named: imageName))
        let scrollView = setupScrollingForView(scrollContainer, view: imageView)
        return (scrollView, imageView)
    }
    
    func setupScrollingForPages(scrollContainer: UIView, pages: [UIView], direction: RSScrollingDirection, pagingEnabled: Bool) -> (scrollView: UIScrollView, contentView: UIView, pages: [UIView]){
        var scrollView = addScrollViewToContainerAndBind(scrollContainer, pagingEnabled: pagingEnabled)
        var contentView = addContentViewToScrollViewAndBind(scrollView, contentView: nil)
        
        switch (direction) {
        case .horizontal:
            scrollView.showsHorizontalScrollIndicator = true
            scrollView.showsVerticalScrollIndicator = false
            addPagesToContentViewAndBind(scrollContainer, scrollView: scrollView, contentView: contentView, pages: pages, direction: direction)
        case .vertical:
            scrollView.showsHorizontalScrollIndicator = false
            scrollView.showsVerticalScrollIndicator = true
            addPagesToContentViewAndBind(scrollContainer, scrollView: scrollView, contentView: contentView, pages: pages, direction: direction)
        default:
            scrollView.showsHorizontalScrollIndicator = true
            scrollView.showsVerticalScrollIndicator = true
            addPagesToContentViewAndBind(scrollContainer, scrollView: scrollView, contentView: contentView, pages: pages, direction: direction)
        }
        return (scrollView, contentView, pages)
    }
}


// MARK: Meat of the class

extension ScrollingHelper {
    func addScrollViewToContainerAndBind(scrollContainer: UIView, pagingEnabled: Bool) ->  UIScrollView {
        
        // add a scrollView as subview to scrollContainer
        let scrollView = RotatingScrollView()
        scrollContainer.addSubview(scrollView)
        scrollView.setTranslatesAutoresizingMaskIntoConstraints(false)  // don't forget this!
        scrollView.pagingEnabled = pagingEnabled
        
        
        // bind all sides of scrollView to its superview (scrollContainer)
        let viewsDictionary = ["scrollView" : scrollView]
        scrollContainer.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[scrollView]|", options: NSLayoutFormatOptions.DirectionLeadingToTrailing, metrics: nil, views: viewsDictionary))
        scrollContainer.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[scrollView]|", options: NSLayoutFormatOptions.DirectionLeadingToTrailing, metrics: nil, views: viewsDictionary))
        
        return scrollView
    }
    
    func addContentViewToScrollViewAndBind(scrollView: UIScrollView, contentView: UIView!) -> UIView {
        
        // add an empty contentView if not provided
        var thisContentView = contentView
        if thisContentView == nil {
            thisContentView = UIView()
        }
        
        // add contentView as subview to scrollView
        thisContentView.setTranslatesAutoresizingMaskIntoConstraints(false) // don't forget this!
        scrollView.addSubview(thisContentView)
        
        // bind all sides of contentView to its superview (scrollView)
        let viewsDictionary = ["contentView" : thisContentView]
        scrollView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[contentView]|", options: NSLayoutFormatOptions.DirectionLeadingToTrailing, metrics: nil, views: viewsDictionary))
        scrollView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[contentView]|", options: NSLayoutFormatOptions.DirectionLeadingToTrailing, metrics: nil, views: viewsDictionary))
        
        return thisContentView
    }
    
    func addPagesToContentViewAndBind(scrollContainer: UIView, scrollView: UIScrollView, contentView: UIView, pages: [UIView], direction: RSScrollingDirection) {
        
        if contentView.subviews.count > 1 {
            contentView.removeFromSuperview()
            addContentViewToScrollViewAndBind(scrollView, contentView: contentView)
        }
        
        for i in 0..<pages.count {
            
            // add the pages as subviews to contentview
            let page = pages[i]
            contentView.addSubview(page)
            page.setTranslatesAutoresizingMaskIntoConstraints(false)    // don't forget this!
            
            var prefix = "V:"
            var prefixOpposite = "H:"
            if direction == RSScrollingDirection.horizontal {
                prefix = "H:"
                prefixOpposite = "V:"
            }
            
            // example of vertical scrolling visual format
            // V:|[page1(==scrollContainer)][page2(==scrollContainer)][page3(==scrollContainer)]|
            // H:|[view1(==scrollContainer)]|
            // H:|[view2(==scrollContainer)]|
            // H:|[view3(==scrollContainer)]|
            
            var viewsDictionary = ["scrollContainer" : scrollContainer, "contentView" : contentView, "page" : page]
            
            if i == 0 {                 // first page
                // this constrains page leading edge to its superview(contentView), equal widths with scrollContainer
                scrollContainer.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(prefix + "|[page(==scrollContainer)]", options: NSLayoutFormatOptions.DirectionLeadingToTrailing, metrics: nil, views: viewsDictionary))
            } else {                    // middle pages
                // this constrains horizontal spacing between pages to 0, equal widths with scrollContainer
                let previousPage = pages[i-1]
                viewsDictionary["previousPage"] = previousPage
                scrollContainer.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(prefix + "[previousPage][page(==scrollContainer)]", options: NSLayoutFormatOptions.DirectionLeadingToTrailing, metrics: nil, views: viewsDictionary))
                
            }
            
            if i == pages.count - 1 {   // last page
                // this constrains last page's trailing edge to its superview(contentView)
                contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(prefix + "[page]|", options: NSLayoutFormatOptions.DirectionLeadingToTrailing, metrics: nil, views: viewsDictionary))
            }
            
            // this constrains pages top edge to its superview(contentView) and height to scrollContainer
            scrollContainer.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat(prefixOpposite + "|[page(==scrollContainer)]|", options: NSLayoutFormatOptions.DirectionLeadingToTrailing, metrics: nil, views: viewsDictionary))
        }
    }
}

class RotatingScrollView: UIScrollView {
    
    override func layoutSubviews() {
        
        //before laying out subviews, content size is the only thing different
        let contentSize = self.contentSize
        
        //layout subviews, may have rotated
        super.layoutSubviews()
        
        //after laying out subviews
        let newContentSize = self.contentSize
        
        
        //if the contentSize has changed, update the contentOffset proportionally
        var x: CGFloat = 0
        var y: CGFloat = 0
        let offset = self.contentOffset

        let scrollingHorizontally = offset.x != 0
        let scrollingVertically = offset.y != 0
        if scrollingHorizontally{
            let widthChanged = contentSize.width > 0 && (contentSize.width != newContentSize.width)
            if widthChanged {
                x = floor(offset.x * newContentSize.width)/contentSize.width
                self.setContentOffset(CGPoint(x: x, y: 0.0), animated: false)
            }
        } else if scrollingVertically {
            let heightChanged = contentSize.height > 0 && contentSize.height != newContentSize.height
            if heightChanged {
                y = floor(offset.x * newContentSize.height)/contentSize.height
                self.setContentOffset(CGPoint(x: x, y: 0.0), animated: false)
            }
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
V:|scrollView|
H:|scrollView|

V:|contentView|
H:|contentView|

V:|[page1(==scrollContainer)][page2(==scrollContainer)][page3(==scrollContainer)]|
H:|[page1(==scrollContainer)]|
H:|[page2(==scrollContainer)]|
H:|[page3(==scrollContainer)]|

resources:
http://stackoverflow.com/questions/13499467/uiscrollview-doesnt-use-autolayout-constraints
http://www.apeth.com/iOSBook/ch20.html
https://developer.apple.com/library/ios/releasenotes/General/RN-iOSSDK-6_0/index.html
*/
