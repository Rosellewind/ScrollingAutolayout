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

    @IBOutlet weak var scrollContainer1: UIView!
    @IBOutlet weak var scrollContainer2: UIView!
    @IBOutlet weak var contentView2: UIView!
    @IBOutlet weak var scrollContainer3: UIView!
    @IBOutlet weak var sampleView: UIView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupScrolling1()
        setupScrolling2()
        setupScrolling3()
        setupScrolling4()
    }
}


// MARK: Different Scrolling Panes

extension ViewController {
    func setupScrolling1() {
        var resizableScrolling = ResizableScrolling()
        resizableScrolling.addPagesToScrollContainer(self.scrollContainer1, pages: resizableScrolling.sampleColorPages(), direction: RSScrollingDirection.horizontal, pagingEnabled: false)
    }
    
    func setupScrolling2() {
        var resizableScrolling = ResizableScrolling()
        resizableScrolling.verticalScrollingWithContainerView(self.scrollContainer2)
//        resizableScrolling.addPagesToScrollContainer(self.scrollContainer2, pages: resizableScrolling.sampleColorPages(), direction: RSScrollingDirection.horizontal, pagingEnabled: false)
    }
    
    func setupScrolling3() {//in IB
//        var resizableScrolling = ResizableScrolling()
//        resizableScrolling.addPagesToScrollContainer(self.scrollContainer3, pages: resizableScrolling.sampleColorPages(), direction: RSScrollingDirection.vertical, pagingEnabled: false)
    }
    
    func setupScrolling4() {
        var resizableScrolling = ResizableScrolling()
//        resizableScrolling.verticalScrollingWithContainerView(self.sampleView)
        resizableScrolling.addPagesToScrollContainer(self.sampleView, pages: resizableScrolling.sampleColorPages(), direction: RSScrollingDirection.vertical, pagingEnabled: false)
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
        i. if scrolling all directions:
            can have space in-between subviews or a freeform layout
        ii. if scrolling vertically:
            no space in-between subviews
            bind “equal widths” of subviews to scrollContainer
        iii. if scrolling horizontally:
            no space in-between subviews
            bind “equal heights” of subviews to scrollContainer

notes for dynamic content:
steps 1, 2, and 3 can be done in IB
add outlet for contentView
if paging, add outlet for scrollContainer
step 4 can be done programmatically for dynamic content

*/
