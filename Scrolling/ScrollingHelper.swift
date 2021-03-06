//
//  DynamicScrolling.swift
//  Scrolling
//
//  Created by Roselle Milvich on 5/14/15.
//  Copyright (c) 2015 Roselle Tanner. All rights reserved.
//


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
    
    func prepareScrollViewsForTransitionToSize(scrollViews: [UIScrollView], coordinator: UIViewControllerTransitionCoordinator) {
        // for all subviews that are UIScrollView, adjust offset
        // interestingly, the scrollView.contentSize has the new value in the animateAlongsideTransition
        for scrollView in scrollViews {
            if scrollView.contentSize.width > 0 && scrollView.contentSize.height > 0 {
                
                let xRatio = scrollView.contentOffset.x / scrollView.contentSize.width
                let yRatio = scrollView.contentOffset.y / scrollView.contentSize.height
                
                coordinator.animateAlongsideTransition({ (UIViewControllerTransitionCoordinatorContext) -> Void in
                    
                    // adjust if the contentOffset shows beyond the end on the contentSize
                    var x = xRatio * scrollView.contentSize.width
                    var y = yRatio * scrollView.contentSize.height
                    let beyondWidth = x + scrollView.bounds.width > scrollView.contentSize.width
                    let beyondHeight = y + scrollView.bounds.height > scrollView.contentSize.height
                    if beyondWidth {
                        x = scrollView.contentSize.width - scrollView.bounds.width
                    }
                    if beyondHeight {
                        y = scrollView.contentSize.height - scrollView.bounds.height
                    }
                    
                    // set the contentOffset
                    scrollView.contentOffset = CGPoint(x: x, y: y)
                    }, completion: nil)
            }
        }
    }
}

