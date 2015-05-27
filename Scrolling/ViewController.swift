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
    @IBOutlet weak var scrollContainer4: UIView!
    @IBOutlet weak var scrollContainer5: UIView!
    @IBOutlet weak var scrollContainer6: UIView!
    
    var resizableScrolling = ResizableScrolling()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupScrolling1()
        setupScrolling2()
        setupScrolling3()
        setupScrolling4()
        setupScrolling5()
        setupScrolling6()
        
    }
}


// MARK: Different Scrolling Panes

extension ViewController {
    func setupScrolling1() {
        resizableScrolling.addPagesToScrollContainer(self.scrollContainer1, pages: resizableScrolling.sampleColorPages(), direction: RSScrollingDirection.horizontal, pagingEnabled: false)
    }
    
    func setupScrolling2() {
//        resizableScrolling.addPagesToScrollContainer(self.scrollContainer2, pages: resizableScrolling.sampleColorPages(), direction: RSScrollingDirection.horizontal, pagingEnabled: false)
    }
    
    func setupScrolling3() {//in IB
//        var resizableScrolling = ResizableScrolling()
//        resizableScrolling.addPagesToScrollContainer(self.scrollContainer3, pages: resizableScrolling.sampleColorPages(), direction: RSScrollingDirection.vertical, pagingEnabled: false)
    }
    
    func setupScrolling4() {
        var resizableScrolling = ResizableScrolling()
//        resizableScrolling.verticalScrollingWithContainerView(self.sampleView)
        resizableScrolling.addPagesToScrollContainer(self.scrollContainer4, pages: resizableScrolling.sampleColorPages(), direction: RSScrollingDirection.vertical, pagingEnabled: false)
    }
}

// MARK: Instructions how to code dynamic layout scrolling
/*



steps 1, 2, and 3 can be done in IB, 4 programatically if desired

1. add UIView named scrollContainer
    a. bind all 4 sides appropriately where you want them

2. add UIScrollView named scrollView as subview to scrollContainer
    a. bind all sides of scrollView to scrollContainer, (trailing, leading, bottom, top spaces = 0)

3. add UIView named contentView as subview to scrollView
    a. bind all sides of contentView to scrollview, (trailing, leading, bottom, top spaces = 0)

4. add subviews to contentView (your content) (see below for programmatically added)
    a. bind subviews how you want them in the 4 directions
    b. set width and height for each
        i. if scrolling all directions:
            can have space in-between subviews or a freeform layout
        ii. if scrolling vertically or horizontally
            line them up one after another appropriately with H: or V:
pagingEnabled
            set scrubbers



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
