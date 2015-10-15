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
    
    var scrollingHelper = ScrollingHelper()

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
        scrollingHelper.setupScrollingForPages(self.scrollContainer1, pages: scrollingHelper.sampleColorPages(), direction: RSScrollingDirection.horizontal, pagingEnabled: false)
    }
    
    func setupScrolling2() {
        scrollingHelper.setupScrollingForImage(self.scrollContainer2, imageName:"t_Bierstadt-Rocky Mountain landscape.jpg")
    }
    
    func setupScrolling3() {//in IB

    }
    
    func setupScrolling4() {
        let strings = ["opened at 3:15", "tapped at 4:15", "opened at 5:45"]
        scrollingHelper.setupScrollingForPages(self.scrollContainer4, pages: scrollingHelper.arrayOfLabelsForStrings(strings, font:nil), direction: RSScrollingDirection.vertical, pagingEnabled: false)
//        scrollingHelper.setupScrollingForPages(self.scrollContainer4, pages: scrollingHelper.sampleColorPages(), direction: RSScrollingDirection.horizontal, pagingEnabled: false)
    }
    
    func setupScrolling5() {
    scrollingHelper.setupScrollingForImage(self.scrollContainer5, imageName:"leonidAfremov.jpg")
    }
    
    func setupScrolling6() {
        let strings = ["opened at 3:15", "tapped at 4:15", "opened at 5:45"]
        scrollingHelper.setupScrollingForPages(self.scrollContainer6, pages: scrollingHelper.arrayOfTextViewsForStrings(strings), direction: RSScrollingDirection.horizontal, pagingEnabled: true)
    }
}
