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
        var contentView = addContentViewToScrollViewAndBind(scrollContainer, scrollView: scrollView, direction: RSScrollingDirection.horizontal)
        
        switch (direction) {
        case .horizontal:
            scrollView.showsHorizontalScrollIndicator = true
            scrollView.showsVerticalScrollIndicator = false
            addPagesToContentViewAndBind(scrollContainer, contentView: contentView, pages: pages, direction: direction)
        case .vertical:
            scrollView.showsHorizontalScrollIndicator = false
            scrollView.showsVerticalScrollIndicator = true
            addPagesToContentViewAndBind(scrollContainer, contentView: contentView, pages: pages, direction: direction)
//            addPagesToContentViewAndBind2(scrollContainer, contentView: contentView, pages: pages, direction: direction)
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
        var contentView = addContentViewToScrollViewAndBind(scrollContainer, scrollView: scrollView, direction: RSScrollingDirection.vertical)
//        var contentView = addContentViewToScrollViewAndBind(scrollContainer, scrollView: scrollView)
        addSamplePagesToContentViewAndBind(scrollContainer, contentView: contentView)
    }
    
    func addContentViewToScrollViewAndBind(scrollContainer: UIView, scrollView: UIScrollView) -> UIView {
        
        // add a UIView named contentView as subview to scrollView
        let contentView = UIView()
        contentView.setTranslatesAutoresizingMaskIntoConstraints(false) // don't forget this!
        scrollView.addSubview(contentView)
        
        // bind all sides of contentView to scrollview, (trailing, leading, bottom, top spaces = 0)
        let horizontalContraint = NSLayoutConstraint.constraintsWithVisualFormat("V:|[contentView]|", options: NSLayoutFormatOptions.DirectionLeadingToTrailing, metrics: nil, views: ["contentView" : contentView])
        scrollView.addConstraints(horizontalContraint)
        let verticalContraint = NSLayoutConstraint.constraintsWithVisualFormat("H:|[contentView(==scrollContainer)]", options: NSLayoutFormatOptions.DirectionLeadingToTrailing, metrics: nil, views: ["contentView" : contentView, "scrollContainer" : scrollContainer])
        scrollContainer.addConstraints(verticalContraint)
        
        return contentView
    }
    
    func worksaddSamplePagesToContentViewAndBind(scrollContainer: UIView, contentView: UIView) {
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
        println("constraints: \(page3.constraintsAffectingLayoutForAxis(UILayoutConstraintAxis.Vertical))")
        println("*-***********+++++++++++++************-*")

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
        println("constraints: \(page3.constraintsAffectingLayoutForAxis(UILayoutConstraintAxis.Vertical))")
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
        
        // bind top and left to superview, width and height == scrollContainer
        let horizontalContraint = NSLayoutConstraint.constraintsWithVisualFormat("H:|[scrollView(==scrollContainer)]", options: NSLayoutFormatOptions.DirectionLeadingToTrailing, metrics: nil, views: ["scrollView" : scrollView, "scrollContainer" : scrollContainer])
        scrollContainer.addConstraints(horizontalContraint)
        let verticalContraint = NSLayoutConstraint.constraintsWithVisualFormat("V:|[scrollView(==scrollContainer)]", options: NSLayoutFormatOptions.DirectionLeadingToTrailing, metrics: nil, views: ["scrollView" : scrollView, "scrollContainer" : scrollContainer])
        scrollContainer.addConstraints(verticalContraint)
        
        return scrollView
    }
    
    func addContentViewToScrollViewAndBind(scrollContainer: UIView, scrollView: UIScrollView, direction: RSScrollingDirection) -> UIView {

        //Vertical scrolling is opposite of Horizontal
        let prefix: String
        let prefixOpposite: String
        if direction == RSScrollingDirection.horizontal {
            prefix = "H:"
            prefixOpposite = "V:"
        } else {
            prefix = "V:"
            prefixOpposite = "H:"
        }

        // add a UIView named contentView as subview to scrollView
        let contentView = UIView()
        contentView.setTranslatesAutoresizingMaskIntoConstraints(false) // don't forget this!
        scrollView.addSubview(contentView)
        
        // bind all sides of contentView to superview(scrollView), if Horizontal bind height to scrollContainer, if Vertical bind width to scrollContainer
        let horizontalContraint = NSLayoutConstraint.constraintsWithVisualFormat(prefix + "|[contentView]|", options: NSLayoutFormatOptions.DirectionLeadingToTrailing, metrics: nil, views: ["contentView" : contentView])
        scrollView.addConstraints(horizontalContraint)
        let verticalContraint = NSLayoutConstraint.constraintsWithVisualFormat(prefixOpposite + "|[contentView(==scrollContainer)]", options: NSLayoutFormatOptions.DirectionLeadingToTrailing, metrics: nil, views: ["contentView" : contentView, "scrollContainer" : scrollContainer])
        scrollContainer.addConstraints(verticalContraint)
        
        return contentView
    }
    
    
//    func addPagesToContentViewAndBind(scrollContainer: UIView, contentView: UIView, pages: [UIView], direction: RSScrollingDirection) {
//        
//
//        
//        let prefix: String
//        let prefixOpposite: String
//        if direction == RSScrollingDirection.horizontal {
//            prefix = "H:"
//            prefixOpposite = "V:"
//        } else {
//            prefix = "V:"
//            prefixOpposite = "H:"
//        }
//        
//        var views = ["scrollContainer" : scrollContainer, "contentView" : contentView]
//        var widthwiseStrings = []
//        var lengthwiseString = prefix + "|"
//
//        
//        for i in 0..<pages.count {
//            
//            // add the pages as subviews to contentview
//            let page = pages[i]
//            page.setTranslatesAutoresizingMaskIntoConstraints(false)    // don't forget this!
//            contentView.addSubview(page)
//            
//            let pageString = "page\(i)"
//            lengthwiseString += "[\(pageString)(==scrollContainer)]"
//            
//            let widthwiseString = prefix + "|[\(pageString)(==scrollContainer)]"
//            widthwiseStrings.
//            
//            
//            
//            
//            
//            // V:|[page1(==)][page2(==)][page3(==)]|
//            // H:|[view1(==)]
//            // H:|[view2(==)]
//            // H:|[view3(==)]
//            
//            
//            
//            
//            
//            
//            
//            
//            
//            
//
//
//
//            //add to scrollContainer?
//            if i == 0 {                 // first page
//                // this constrains page leading edge to its superview(contentView)
//                
//                
//                let leadingConstraint = NSLayoutConstraint.constraintsWithVisualFormat(prefix + "|[page]", options: NSLayoutFormatOptions.DirectionLeadingToTrailing, metrics: nil, views: ["page" : page])
//                contentView.addConstraints(leadingConstraint)
//            } else {                    // middle pages
//                // this constrains horizontal spacing between pages to 0
//                let previousPage = pages[i-1]
//                let spacingConstraint = NSLayoutConstraint.constraintsWithVisualFormat(prefix + "[previousPage][page]", options: NSLayoutFormatOptions.DirectionLeadingToTrailing, metrics: nil, views: ["previousPage" : previousPage, "page" : page])
//                contentView.addConstraints(spacingConstraint)
//            }
//            
//            if i == pages.count - 1 {   // last page
//                // this constrains last page's trailing edge to its superview(contentView)
//                let trailingConstraint = NSLayoutConstraint.constraintsWithVisualFormat(prefix + "[page]|", options: NSLayoutFormatOptions.DirectionLeadingToTrailing, metrics: nil, views: ["page" : page, "contentView" : contentView])
//                contentView.addConstraints(trailingConstraint)
//            }
//
//            //this constraint binds the page "equal widths" to scrollContainer
//            let equalWidthsConstraint = NSLayoutConstraint.constraintsWithVisualFormat(prefix + "[page(==scrollContainer)]", options: NSLayoutFormatOptions.DirectionLeadingToTrailing, metrics: nil, views: ["page" : page, "scrollContainer" : scrollContainer])
//            scrollContainer.addConstraints(equalWidthsConstraint)
//            
//            // this constrains pages top edge to its superview(contentView) and height to scrollContainer
//            let topBottomConstraint = NSLayoutConstraint.constraintsWithVisualFormat(prefixOpposite + "|[page(==scrollContainer)]", options: NSLayoutFormatOptions.DirectionLeadingToTrailing, metrics: nil, views: ["page" : page, "scrollContainer" : scrollContainer])
//            scrollContainer.addConstraints(topBottomConstraint)////deleted trailing |
//        }
//        
//    }
    
    
    
//    
//    
//    func addPagesToContentViewAndBind(scrollContainer: UIView, contentView: UIView, pages: [UIView], direction: RSScrollingDirection) {
//        
//        for i in 0..<pages.count {
//            
//            // add the pages as subviews to contentview
//            let page = pages[i]
//            page.setTranslatesAutoresizingMaskIntoConstraints(false)    // don't forget this!
//            contentView.addSubview(page)
//            
//            let prefix: String
//            let prefixOpposite: String
//            if direction == RSScrollingDirection.horizontal {
//                prefix = "H:"
//                prefixOpposite = "V:"
//            } else {
//                prefix = "V:"
//                prefixOpposite = "H:"
//            }
//            // V:|[page1(==)][page2(==)][page3(==)]|
//            // H:|[view1(==)]
//            // H:|[view2(==)]
//            // H:|[view3(==)]
//            
//            //add to scrollContainer?
//            if i == 0 {                 // first page
//                // this constrains page leading edge to its superview(contentView)
//                let leadingConstraint = NSLayoutConstraint.constraintsWithVisualFormat(prefix + "|[page]", options: NSLayoutFormatOptions.DirectionLeadingToTrailing, metrics: nil, views: ["page" : page])
//                contentView.addConstraints(leadingConstraint)
//            } else {                    // middle pages
//                // this constrains horizontal spacing between pages to 0
//                let previousPage = pages[i-1]
//                let spacingConstraint = NSLayoutConstraint.constraintsWithVisualFormat(prefix + "[previousPage][page]", options: NSLayoutFormatOptions.DirectionLeadingToTrailing, metrics: nil, views: ["previousPage" : previousPage, "page" : page])
//                contentView.addConstraints(spacingConstraint)
//            }
//            
//            if i == pages.count - 1 {   // last page
//                // this constrains last page's trailing edge to its superview(contentView)
//                let trailingConstraint = NSLayoutConstraint.constraintsWithVisualFormat(prefix + "[page]|", options: NSLayoutFormatOptions.DirectionLeadingToTrailing, metrics: nil, views: ["page" : page, "contentView" : contentView])
//                contentView.addConstraints(trailingConstraint)
//            }
//            
//            //this constraint binds the page "equal widths" to scrollContainer
//            let equalWidthsConstraint = NSLayoutConstraint.constraintsWithVisualFormat(prefix + "[page(==scrollContainer)]", options: NSLayoutFormatOptions.DirectionLeadingToTrailing, metrics: nil, views: ["page" : page, "scrollContainer" : scrollContainer])
//            scrollContainer.addConstraints(equalWidthsConstraint)
//            
//            // this constrains pages top edge to its superview(contentView) and height to scrollContainer
//            let topBottomConstraint = NSLayoutConstraint.constraintsWithVisualFormat(prefixOpposite + "|[page(==scrollContainer)]", options: NSLayoutFormatOptions.DirectionLeadingToTrailing, metrics: nil, views: ["page" : page, "scrollContainer" : scrollContainer])
//            scrollContainer.addConstraints(topBottomConstraint)
//        }
//        
//        if scrollContainer.hasAmbiguousLayout() {
//            println("*************************")
//            println("view frame \(NSStringFromCGRect(scrollContainer.frame))")
//            println("\(scrollContainer.description)")
//            scrollContainer.constraintsAffectingLayoutForAxis(UILayoutConstraintAxis.Horizontal)
//            println("\(scrollContainer.constraintsAffectingLayoutForAxis(UILayoutConstraintAxis.Horizontal))")
//            println("\(scrollContainer.constraintsAffectingLayoutForAxis(UILayoutConstraintAxis.Vertical))")
//            println("*-***********************-*")
//            
//        }
//
//        
//
////        for view: UIView in scrollContainer.subviews as! [UIView] {
////            if view.hasAmbiguousLayout() {
////                println("*************************")
////                println("view frame \(NSStringFromCGRect(view.frame))")
////                println("\(view.description)")
////                view.constraintsAffectingLayoutForAxis(UILayoutConstraintAxis.Horizontal)
////                println("\(view.constraintsAffectingLayoutForAxis(UILayoutConstraintAxis.Horizontal))")
////                println("\(view.constraintsAffectingLayoutForAxis(UILayoutConstraintAxis.Vertical))")
////                println("*-***********************-*")
////
////            }
////        }
//    }
    
    
    
    func workingaddPagesToContentViewAndBind(scrollContainer: UIView, contentView: UIView, pages: [UIView], direction: RSScrollingDirection) {
        
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
            // V:|[page1(==)][page2(==)][page3(==)]|
            // H:|[view1(==)]
            // H:|[view2(==)]
            // H:|[view3(==)]
            
            //add to scrollContainer?
            if i == 0 {                 // first page
                // this constrains page leading edge to its superview(contentView)
                let leadingConstraint = NSLayoutConstraint.constraintsWithVisualFormat(prefix + "|[page(==scrollContainer)]", options: NSLayoutFormatOptions.DirectionLeadingToTrailing, metrics: nil, views: ["page" : page, "scrollContainer" : scrollContainer])
                scrollContainer.addConstraints(leadingConstraint)/////////previousPage if 1 or 2 pgs?
            } else if i == pages.count - 1 {   // last page
                // this constrains last page's trailing edge to its superview(contentView)
                let previousPage = pages[i-1]
                let trailingConstraint = NSLayoutConstraint.constraintsWithVisualFormat(prefix + "[previousPage][page(==scrollContainer)]|", options: NSLayoutFormatOptions.DirectionLeadingToTrailing, metrics: nil, views: ["previousPage" : previousPage, "page" : page, "scrollContainer" : scrollContainer])
                scrollContainer.addConstraints(trailingConstraint)
            } else {                    // middle pages
                // this constrains horizontal spacing between pages to 0
                let previousPage = pages[i-1]
                let spacingConstraint = NSLayoutConstraint.constraintsWithVisualFormat(prefix + "[previousPage][page(==scrollContainer)]", options: NSLayoutFormatOptions.DirectionLeadingToTrailing, metrics: nil, views: ["previousPage" : previousPage, "page" : page, "scrollContainer" : scrollContainer])
                scrollContainer.addConstraints(spacingConstraint)
            }
            
            
            // this constrains pages top edge to its superview(contentView) and height to scrollContainer
            let topBottomConstraint = NSLayoutConstraint.constraintsWithVisualFormat(prefixOpposite + "|[page(==scrollContainer)]", options: NSLayoutFormatOptions.DirectionLeadingToTrailing, metrics: nil, views: ["page" : page, "scrollContainer" : scrollContainer])
            scrollContainer.addConstraints(topBottomConstraint)
            
            if direction == RSScrollingDirection.vertical && i == 2 {
                println("*************************")
                println("constraints: \(page.constraintsAffectingLayoutForAxis(UILayoutConstraintAxis.Vertical))")
                println("*-***********************-*")
            }
        }
    }
    
    
    
    
    
    func addPagesToContentViewAndBind(scrollContainer: UIView, contentView: UIView, pages: [UIView], direction: RSScrollingDirection) {
        
        let scrollView = contentView.superview as! UIScrollView
        
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
            // V:|[page1(==)][page2(==)][page3(==)]|
            // H:|[view1(==)]
            // H:|[view2(==)]
            // H:|[view3(==)]
            
            //add to scrollContainer?
            if i == 0 {                 // first page
                // this constrains page leading edge to its superview(contentView)
                let leadingConstraint = NSLayoutConstraint.constraintsWithVisualFormat(prefix + "|[page(==scrollView)]", options: NSLayoutFormatOptions.DirectionLeadingToTrailing, metrics: nil, views: ["page" : page, "scrollView" : scrollView])
                scrollView.addConstraints(leadingConstraint)/////////previousPage if 1 or 2 pgs?
            } else if i == pages.count - 1 {   // last page
                // this constrains last page's trailing edge to its superview(contentView)
                let previousPage = pages[i-1]
                let trailingConstraint = NSLayoutConstraint.constraintsWithVisualFormat(prefix + "[previousPage][page(==scrollView)]|", options: NSLayoutFormatOptions.DirectionLeadingToTrailing, metrics: nil, views: ["previousPage" : previousPage, "page" : page, "scrollView" : scrollView])
                scrollView.addConstraints(trailingConstraint)
            } else {                    // middle pages
                // this constrains horizontal spacing between pages to 0
                let previousPage = pages[i-1]
                let spacingConstraint = NSLayoutConstraint.constraintsWithVisualFormat(prefix + "[previousPage][page(==scrollView)]", options: NSLayoutFormatOptions.DirectionLeadingToTrailing, metrics: nil, views: ["previousPage" : previousPage, "page" : page, "scrollView" : scrollView])
                scrollView.addConstraints(spacingConstraint)
            }
            
            
            // this constrains pages top edge to its superview(contentView) and height to scrollContainer
            let topBottomConstraint = NSLayoutConstraint.constraintsWithVisualFormat(prefixOpposite + "|[page(==scrollView)]", options: NSLayoutFormatOptions.DirectionLeadingToTrailing, metrics: nil, views: ["page" : page, "scrollView" : scrollView])
            scrollView.addConstraints(topBottomConstraint)
            
            if direction == RSScrollingDirection.vertical && i == 2 {
                println("*************************")
                println("constraints: \(page.constraintsAffectingLayoutForAxis(UILayoutConstraintAxis.Vertical))")
                println("*-***********************-*")
            }
        }
    }
}

