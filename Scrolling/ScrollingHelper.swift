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


// MARK: Enumerations

enum RSScrollingDirection {
    case horizontal,vertical, any
}


// MARK: Class ResizableScrolling

class ScrollingHelper {
    
}

// MARK: Public Methods

extension ScrollingHelper {
    
    func setupScrollingForView(scrollContainer: UIView, view: UIView) -> UIScrollView{
        
        // add a scrollView and bind all sides
        let scrollView = addScrollViewToContainerAndBind(scrollContainer)
        
        // add an imageView and bind all sides
        addContentViewToScrollViewAndBind(scrollView, contentView: view)
        
        return scrollView
    }
    
    func setupScrollingForImage(scrollContainer: UIView, imageName: String) -> (scrollView: UIScrollView, imageView: UIImageView) {
        
        // create the imageView, setup through setupScrollingForView()
        let imageView = UIImageView(image: UIImage(named: imageName))
        let scrollView = setupScrollingForView(scrollContainer, view: imageView)
        
        return (scrollView, imageView)
    }
    
    func setupScrollingForPages(scrollContainer: UIView, pages: [UIView], direction: RSScrollingDirection, pagingEnabled: Bool) -> (scrollView: UIScrollView, contentView: UIView, pages: [UIView]){
        let retValues = setupScrollingForViews(scrollContainer, views: pages, direction: direction, pagingEnabled: pagingEnabled, oneViewPerPage: true)
        return (retValues.0, retValues.1, retValues.2)
    }
    
    func setupScrollingForViews(scrollContainer: UIView, views: [UIView], direction: RSScrollingDirection, pagingEnabled: Bool, oneViewPerPage: Bool) -> (scrollView: UIScrollView, contentView: UIView, views: [UIView]){
        
        // add a scrollView and bind all sides
        let scrollView = addScrollViewToContainerAndBind(scrollContainer)
        scrollView.pagingEnabled = pagingEnabled
        
        // add a contentView and Bind all sides
        let contentView = addContentViewToScrollViewAndBind(scrollView)
        
        // add pages to the content view and bind them one after another
        addPagesToContentViewAndBind(views, contentView: contentView, scrollView: scrollView, scrollContainer: scrollContainer, direction: direction, onePerPage: oneViewPerPage)
        
        // set the scroll indicators
        switch (direction) {
        case .horizontal:
            scrollView.showsHorizontalScrollIndicator = true
            scrollView.showsVerticalScrollIndicator = false

        case .vertical:
            scrollView.showsHorizontalScrollIndicator = false
            scrollView.showsVerticalScrollIndicator = true
        default:
            scrollView.showsHorizontalScrollIndicator = true
            scrollView.showsVerticalScrollIndicator = true
        }
        return (scrollView, contentView, views)
    }
}


// MARK: Meat of the class

extension ScrollingHelper {
    private func addViewToContainerAndBindAllSides(view: UIView = UIView(), container: UIView) {
        container.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false  // don't forget this!   
        NSLayoutConstraint.activateConstraints(NSLayoutConstraint.constraintsToBindTopBottomLeftRight(view))
        // prior to ios8, use container.addConstraints() instead of NSLayoutConstraint.activateConstraints()
    }
    
    private func addScrollViewToContainerAndBind(scrollContainer: UIView) ->  UIScrollView {
        let scrollView = UIScrollView()
        addViewToContainerAndBindAllSides(scrollView, container: scrollContainer)
        return scrollView
    }
    
    private func addContentViewToScrollViewAndBind(scrollView: UIScrollView, contentView: UIView = UIView()) -> UIView {
        addViewToContainerAndBindAllSides(contentView, container: scrollView)
        return contentView
    }
    
    private func addPagesToContentViewAndBind(pages: [UIView], contentView: UIView, scrollView: UIScrollView, scrollContainer: UIView, direction: RSScrollingDirection, onePerPage: Bool) {
        // if !onePerPage stacked views of undetermined length are used instead of pages
        
        if contentView.subviews.count > 1 {
            contentView.removeFromSuperview()
            addContentViewToScrollViewAndBind(scrollView, contentView: contentView)
        }

        for i in 0..<pages.count {
            
            // add the pages as subviews to contentview
            let page = pages[i]
            contentView.addSubview(page)
            page.translatesAutoresizingMaskIntoConstraints = false    // don't forget this!
            
            if onePerPage {
                NSLayoutConstraint.activateConstraints([NSLayoutConstraint.constraintToKeepEqualWidth(page, view2: scrollContainer)])
                NSLayoutConstraint.activateConstraints([NSLayoutConstraint.constraintToKeepEqualHeight(page, view2: scrollContainer)])
            } else if direction == RSScrollingDirection.vertical {
                NSLayoutConstraint.activateConstraints([NSLayoutConstraint.constraintToKeepEqualWidth(page, view2: scrollContainer)])
            } else {
                NSLayoutConstraint.activateConstraints([NSLayoutConstraint.constraintToKeepEqualHeight(page, view2: scrollContainer)])
            }
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
        // prior to ios8, use container.addConstraints() instead of NSLayoutConstraint.activateConstraints()
    }
}

// MARK: Handle Rotation

extension ScrollingHelper {
    func animationForContentOffsetOnRotation(scrollViews: [UIScrollView]) -> (){
        
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

(if stacking pages on one another with varying height(ex. for vertical scrolling), make sure to set the height or auto height and omit (==scrollContainer) from V:)

resources:
http://stackoverflow.com/questions/13499467/uiscrollview-doesnt-use-autolayout-constraints
http://www.apeth.com/iOSBook/ch20.html
https://developer.apple.com/library/ios/releasenotes/General/RN-iOSSDK-6_0/index.html
*/
