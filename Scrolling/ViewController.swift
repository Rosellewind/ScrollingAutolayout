//
//  ViewController.swift
//  Scrolling
//
//  Created by Roselle Milvich on 2/4/15.
//  Copyright (c) 2015 Roselle Tanner. All rights reserved.
//

// instructions to set-up a scrollView are at the bottom of the page

import UIKit

// MARK: Class ViewController
class ViewController: UIViewController {

    @IBOutlet weak var scrollContainer2: UIView!
    @IBOutlet weak var contentView2: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupScrolling2()
    }
}

// MARK: Scrolling 2 - Using an Array
// This is an example of horizontal paging using an array of data to populate the views
extension ViewController {

    func setupScrolling2() {
        
        // sample content
        let colors = [UIColor.greenColor(), UIColor.redColor(), UIColor.purpleColor()]
        var colorViews: [UIView] = []
        
        for i in 0..<colors.count {
            
            // make and add a subview
            let color = colors[i]
            var colorView = UIView()
            colorView.backgroundColor = color
            colorView.setTranslatesAutoresizingMaskIntoConstraints(false)   //don't forget this!
            self.contentView2.addSubview(colorView)
            colorViews.append(colorView)
            
            // use constraints instead of frames
            // each colorView is bound on all 4 sides, plus "equal width" with scrollContainer for paging
            // results in the following visual format (colors denoting colorView's):
            //      H:|[green(==scrollContainer)][red(==scrollContainer)][purple(==scrollContainer)]|
            //      V:|[green]|
            //      V:|[red]|
            //      V:|[purple]|
            
            if i == 0 {
                // this constrains colorView's leading edge to its superview(contentView2)
                let leadingConstraint = NSLayoutConstraint.constraintsWithVisualFormat("H:|[colorView]", options: NSLayoutFormatOptions.DirectionLeadingToTrailing, metrics: nil, views: ["colorView" : colorView, "contentView2" : contentView2])
                self.view.addConstraints(leadingConstraint)
            } else {
                // this constrains horizontal spacing between colors to 0
                let previousColorView = colorViews[i-1]
                let spacingConstraint = NSLayoutConstraint.constraintsWithVisualFormat("H:[previousColorView][colorView]", options: NSLayoutFormatOptions.DirectionLeadingToTrailing, metrics: nil, views: ["previousColorView" : previousColorView, "colorView" : colorView])
                self.view.addConstraints(spacingConstraint)
            }
            if i == colors.count - 1 {
                
                // this constrains colorView's trailing edge to its superview(contentView2)
                let trailingConstraint = NSLayoutConstraint.constraintsWithVisualFormat("H:[colorView]|", options: NSLayoutFormatOptions.DirectionLeadingToTrailing, metrics: nil, views: ["colorView" : colorView, "contentView2" : contentView2])
                self.view.addConstraints(trailingConstraint)
            }
            
            //this constraint binds colorView "equal widths" to containerForScrollView
            let equalWidthsConstraint = NSLayoutConstraint.constraintsWithVisualFormat("H:[colorView(==scrollContainer2)]", options: NSLayoutFormatOptions.DirectionLeadingToTrailing, metrics: nil, views: ["colorView" : colorView, "scrollContainer2" : scrollContainer2])
            self.view.addConstraints(equalWidthsConstraint)
            
            // this constrains colorView's top and bottom edges to its superview(contentView2)
            let topBottomConstraint = NSLayoutConstraint.constraintsWithVisualFormat("V:|[colorView]|", options: NSLayoutFormatOptions.DirectionLeadingToTrailing, metrics: nil, views: ["colorView" : colorView, "contentView2" : contentView2])
            self.view.addConstraints(topBottomConstraint)
        }
    }
}

// MARK: Instructions
/*

1. add UIView named scrollContainer
    a. bind all 4 sides appropriately where you want them

2. add UIScrollView named scrollView as subview to scrollContainer
    a. bind all sides of scrollView to scrollContainer, (trailing, leading, bottom, top spaces = 0)

3. add UIView named contentView as subview to scrollView
    a. bind all sides of contentView to scrollview, (trailing, leading, bottom, top spaces = 0)
    b. set your scrollview scrolling/paging enabled, horizontal/vertical indicators
        i. if scrolling both horizontally and vertically, go on to step 4
        ii. if only vertical scrolling, bind contentView “equal widths” to scrollContainer
        iii.if only horizontal scrolling, bind contentView “equal heights” to scrollContainer

4. add subviews to contentView (your content) (see below for programmatically added)
    a. bind subviews how you want them in the 4 directions
        i. if no paging:
            can have space in-between subviews or a freeform layout
        ii. if paging vertically:
            no space in-between subviews
            bind “equal widths” of subviews to scrollContainer
        iii. if paging horizontally:
            no space in-between subviews
            bind “equal heights” of subviews to scrollContainer

notes for dynamic content:
steps 1, 2, and 3 can be done in IB
add outlet for contentView
if paging, add outlet for scrollContainer
step 4 can be done programmatically for dynamic content

*/
