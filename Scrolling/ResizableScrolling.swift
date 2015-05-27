//
//  DynamicScrolling.swift
//  Scrolling
//
//  Created by Roselle Milvich on 5/14/15.
//  Copyright (c) 2015 Roselle Tanner. All rights reserved.
//

import Foundation
import UIKit

// MARK: ----------Enumerations----------

enum RSScrollingDirection {
    case horizontal,vertical, any
}


// MARK: ----------Class ResizableScrolling----------

class ResizableScrolling {
    
}


// MARK: Convenience functions to convert data to pages

extension ResizableScrolling {
    
    // makes textViews out of an array of strings
    func arrayOfTextViewsForStrings(strings: [String]) -> [UIView] {
        var textViewArray: [UITextView] = []
        for string in strings {
            var textView = UITextView()
            textView.text = string
            textViewArray.append(textView)
        }
        return textViewArray
    }
}


// MARK: Sample Data

extension ResizableScrolling {
    func sampleColorPages() -> [UIView] {
        
        // sample content
        let colors = [UIColor.greenColor(), UIColor.redColor(), UIColor.purpleColor()]
        var colorViews: [UIView] = []
        
        for i in 0..<colors.count {
            
            // make and add a subview
            let color = colors[i]
            var colorView = UIView()
            colorView.backgroundColor = color
//            colorView.setTranslatesAutoresizingMaskIntoConstraints(false)   //don't forget this!
            colorViews.append(colorView)
        }
        return colorViews
    }
}


// MARK: Public Methods

extension ResizableScrolling {
    func addPagesToScrollContainer(scrollContainer: UIView, pages: [UIView], direction: RSScrollingDirection, pagingEnabled: Bool) -> (scrollView: UIScrollView, contentView: UIView){
        var scrollView = addScrollViewToContainerAndBind(scrollContainer, pagingEnabled: pagingEnabled)
        var contentView = addContentViewToScrollViewAndBind( scrollView, direction: RSScrollingDirection.horizontal)
        
        switch (direction) {
        case .horizontal:
            scrollView.showsHorizontalScrollIndicator = true
            scrollView.showsVerticalScrollIndicator = false
            addPagesToContentViewAndBind(scrollContainer, contentView: contentView, pages: pages, direction: direction)
        case .vertical:
            scrollView.showsHorizontalScrollIndicator = false
            scrollView.showsVerticalScrollIndicator = true
            addPagesToContentViewAndBind(scrollContainer, contentView: contentView, pages: pages, direction: direction)
        default:
            scrollView.showsHorizontalScrollIndicator = true
            scrollView.showsVerticalScrollIndicator = true
            addPagesToContentViewAndBind(scrollContainer, contentView: contentView, pages: pages, direction: direction)
        }
        return (scrollView, contentView)
    }
}

// MARK: sample

extension ResizableScrolling {
    func verticalScrollingWithContainerView(scrollContainer: UIView) {
        var scrollView = addScrollViewToContainerAndBind(scrollContainer, pagingEnabled: false)
        var contentView = addContentViewToScrollViewAndBind(scrollView, direction: RSScrollingDirection.vertical)
        addSamplePagesToContentViewAndBind(scrollContainer, contentView: contentView)
    }
    
    func addSamplePagesToContentViewAndBind(scrollContainer: UIView, contentView: UIView) {
        var page1 = UIView()//////let?
        page1.backgroundColor = UIColor.greenColor()
        page1.setTranslatesAutoresizingMaskIntoConstraints(false)
        contentView.addSubview(page1)
        
        var page2 = UIView()
        page2.backgroundColor = UIColor.redColor()
        page2.setTranslatesAutoresizingMaskIntoConstraints(false)
        contentView.addSubview(page2)
        
        var page3 = UIView()
        page3.backgroundColor = UIColor.purpleColor()
        page3.setTranslatesAutoresizingMaskIntoConstraints(false)
        contentView.addSubview(page3)
        
        let v = NSLayoutConstraint.constraintsWithVisualFormat("V:|[page1(==scrollContainer)][page2(==scrollContainer)][page3(==scrollContainer)]|", options: NSLayoutFormatOptions.DirectionLeadingToTrailing, metrics: nil, views: ["page1" : page1, "page2" : page2, "page3" : page3, "scrollContainer" : scrollContainer])
        scrollContainer.addConstraints(v)
        
        let h1 = NSLayoutConstraint.constraintsWithVisualFormat("H:|[page1(==scrollContainer)]", options: NSLayoutFormatOptions.DirectionLeadingToTrailing, metrics: nil, views: ["page1" : page1, "scrollContainer" : scrollContainer])
        scrollContainer.addConstraints(h1)

        
        let h2 = NSLayoutConstraint.constraintsWithVisualFormat("H:|[page2(==scrollContainer)]", options: NSLayoutFormatOptions.DirectionLeadingToTrailing, metrics: nil, views: ["page2" : page2, "scrollContainer" : scrollContainer])
        scrollContainer.addConstraints(h2)
        
        let h3 = NSLayoutConstraint.constraintsWithVisualFormat("H:|[page3(==scrollContainer)]", options: NSLayoutFormatOptions.DirectionLeadingToTrailing, metrics: nil, views: ["page3" : page3, "scrollContainer" : scrollContainer])
        scrollContainer.addConstraints(h3)
        
        
        println("************+++++++++++*************")
        println("constraints: \(page1.constraintsAffectingLayoutForAxis(UILayoutConstraintAxis.Vertical))")
        println("*-***********+++++++++++++************-*")

    }
}



// MARK: Meat of the class

extension ResizableScrolling {
    func addScrollViewToContainerAndBind(scrollContainer: UIView, pagingEnabled: Bool) ->  UIScrollView {
        
        // add a UIScrollView named scrollView as subview to scrollContainer
        let scrollView = UIScrollView()
        scrollView.scrollEnabled = true
        scrollView.pagingEnabled = pagingEnabled
        scrollView.setTranslatesAutoresizingMaskIntoConstraints(false)  // don't forget this!
        scrollContainer.addSubview(scrollView)
        
        // bind all sides of scrollView to its superview (scrollContainer)
        let views = ["scrollView" : scrollView]
        let horizontalContraint = NSLayoutConstraint.constraintsWithVisualFormat("H:|[scrollView]|", options: NSLayoutFormatOptions.DirectionLeadingToTrailing, metrics: nil, views: views)
        scrollContainer.addConstraints(horizontalContraint)
        let verticalContraint = NSLayoutConstraint.constraintsWithVisualFormat("V:|[scrollView]|", options: NSLayoutFormatOptions.DirectionLeadingToTrailing, metrics: nil, views: views)
        scrollContainer.addConstraints(verticalContraint)
        
        return scrollView
    }
    
    func addContentViewToScrollViewAndBind(scrollView: UIScrollView, direction: RSScrollingDirection) -> UIView {

        // add a UIView named contentView as subview to scrollView
        let contentView = UIView()
        contentView.setTranslatesAutoresizingMaskIntoConstraints(false) // don't forget this!
        scrollView.addSubview(contentView)
        
        // bind all sides of contentView to its superview (scrollContainer)
        let views = ["contentView" : contentView]
        let horizontalContraint = NSLayoutConstraint.constraintsWithVisualFormat("H:|[contentView]|", options: NSLayoutFormatOptions.DirectionLeadingToTrailing, metrics: nil, views:views)
        scrollView.addConstraints(horizontalContraint)
        let verticalContraint = NSLayoutConstraint.constraintsWithVisualFormat("V:|[contentView]|", options: NSLayoutFormatOptions.DirectionLeadingToTrailing, metrics: nil, views: views)
        scrollView.addConstraints(verticalContraint)

        return contentView
    }
 
    func addPagesToContentViewAndBind(scrollContainer: UIView, contentView: UIView, pages: [UIView], direction: RSScrollingDirection) {
        
        for i in 0..<pages.count {
            
            // add the pages as subviews to contentview
            let page = pages[i]
            page.setTranslatesAutoresizingMaskIntoConstraints(false)    // don't forget this!
            contentView.addSubview(page)
            
            let prefix: String
            let prefixOpposite: String
            if direction == RSScrollingDirection.horizontal {
                prefix = "H:"
                prefixOpposite = "V:"
            } else {
                prefix = "V:"
                prefixOpposite = "H:"
            }
            
            // example of vertical scrolling visual format
            // V:|[page1(==)][page2(==)][page3(==)]|
            // H:|[view1(==)]
            // H:|[view2(==)]
            // H:|[view3(==)]
            
            //add to scrollContainer?
            if i == 0 {                 // first page
                // this constrains page leading edge to its superview(contentView), equal widths with scrollContainer
                let leadingConstraint = NSLayoutConstraint.constraintsWithVisualFormat(prefix + "|[page(==scrollContainer)]", options: NSLayoutFormatOptions.DirectionLeadingToTrailing, metrics: nil, views: ["page" : page, "scrollContainer" : scrollContainer])
                scrollContainer.addConstraints(leadingConstraint)
            } else {                    // middle pages
                // this constrains horizontal spacing between pages to 0, equal widths with scrollContainer
                let previousPage = pages[i-1]
                let spacingConstraint = NSLayoutConstraint.constraintsWithVisualFormat(prefix + "[previousPage][page(==scrollContainer)]", options: NSLayoutFormatOptions.DirectionLeadingToTrailing, metrics: nil, views: ["previousPage" : previousPage, "page" : page, "scrollContainer" : scrollContainer])
                scrollContainer.addConstraints(spacingConstraint)
            }
            
            if i == pages.count - 1 {   // last page
                // this constrains last page's trailing edge to its superview(contentView)
                let trailingConstraint = NSLayoutConstraint.constraintsWithVisualFormat(prefix + "[page]|", options: NSLayoutFormatOptions.DirectionLeadingToTrailing, metrics: nil, views: ["page" : page, "contentView" : contentView])
                contentView.addConstraints(trailingConstraint)//////////scrollContainer? simplicity
            }
            
            
            // this constrains pages top edge to its superview(contentView) and height to scrollContainer
            let topBottomConstraint = NSLayoutConstraint.constraintsWithVisualFormat(prefixOpposite + "|[page(==scrollContainer)]|", options: NSLayoutFormatOptions.DirectionLeadingToTrailing, metrics: nil, views: ["page" : page, "scrollContainer" : scrollContainer])
            scrollContainer.addConstraints(topBottomConstraint)
        }
        
////        if scrollContainer.hasAmbiguousLayout() {
//            println("*************************")
//            println("\(scrollContainer.constraintsAffectingLayoutForAxis(UILayoutConstraintAxis.Horizontal))")
//            println("\(scrollContainer.constraintsAffectingLayoutForAxis(UILayoutConstraintAxis.Vertical))")
//            println("*-***********************-*")
//            
////        }
    }
    
    func scrollingForImage(scrollContainer: UIView, imageName: String) {
        let scrollView = UIScrollView()
        let imageView = UIImageView()
        imageView.image = UIImage(named: imageName)
        scrollContainer.addSubview(imageView)
        scrollView.setTranslatesAutoresizingMaskIntoConstraints(false)
        imageView.setTranslatesAutoresizingMaskIntoConstraints(false)

        var viewsDictionary = ["scrollView" : scrollView, "imageView" : imageView]
        scrollContainer.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[scrollView]|", options: NSLayoutFormatOptions.DirectionLeadingToTrailing, metrics: nil, views: viewsDictionary))
        scrollContainer.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[scrollView]|", options: NSLayoutFormatOptions.DirectionLeadingToTrailing, metrics: nil, views: viewsDictionary))
        scrollView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[imageView]|", options: NSLayoutFormatOptions.DirectionLeadingToTrailing, metrics: nil, views: viewsDictionary))
        scrollView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[imageView]|", options: NSLayoutFormatOptions.DirectionLeadingToTrailing, metrics: nil, views: viewsDictionary))
    }
    

}

