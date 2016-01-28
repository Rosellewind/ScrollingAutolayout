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
        let strings = ["***Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi suscipit pulvinar orci nec vulputate. Aenean porta ac nulla id pulvinar. Duis odio ante, luctus eget pellentesque ut, faucibus et ex. Fusce mollis ut ante eu egestas. Maecenas vel mauris sed ipsum hendrerit condimentum at vitae nunc. Pellentesque ac tellus tortor. Nullam ante leo, iaculis quis lorem ultricies, consectetur iaculis ligula. Donec eget ex sit amet ipsum ultricies iaculis id sit amet ante.",
            "***Donec at quam accumsan, tristique ex eget, dictum ex. Fusce finibus molestie velit, vitae elementum risus maximus quis. Donec volutpat nulla eu dignissim tincidunt. Praesent dapibus convallis dui, id dignissim odio auctor id. Donec ut nisi vulputate, consequat leo in, tempus mi. Vivamus lacus eros, vestibulum vel tellus sed, commodo viverra libero. Suspendisse et euismod dui, feugiat placerat mi. Aenean dui ante, tempor eu placerat vitae, malesuada vel velit. Integer eget metus risus. Pellentesque ut viverra nibh. In hac habitasse platea dictumst.",
            "***Aliquam erat volutpat. Praesent et diam at quam maximus convallis id vitae nulla. Pellentesque ut tincidunt ipsum. Vivamus rhoncus, neque in pulvinar auctor, mauris sapien consectetur tellus, eget cursus mi sem et augue. Vestibulum quis maximus lorem, id vulputate leo. Etiam id consectetur quam. In convallis fringilla nibh.",
            "***Nulla faucibus odio nec nisl dignissim commodo. Suspendisse convallis tortor ac ullamcorper mollis. Vivamus ullamcorper euismod lectus, et facilisis purus imperdiet quis. Cras ultrices arcu ac dignissim hendrerit. Aenean id sem tristique, dictum lacus sit amet, laoreet justo. Donec porta, metus vitae hendrerit auctor, arcu quam porttitor lorem, ac porta nulla ligula eget enim. Integer ut ultrices enim, eget tristique ipsum. Integer pellentesque fringilla orci ac laoreet. Donec quis n eque velit. Suspendisse ultrices iaculis odio, eget imperdiet ante blandit at. Donec scelerisque suscipit nulla vel accumsan. Fusce quis arcu at est pellentesque accumsan. Maecenas aliquam sem augue, id hendrerit metus mattis ac. Lorem ipsum dolor sit amet, consectetur adipiscing elit."]
        scrollingHelper.setupScrollingForViews(self.scrollContainer4, views: scrollingHelper.arrayOfLabelsForStrings(strings, font:nil), direction: RSScrollingDirection.vertical, pagingEnabled: false, oneViewPerPage: false)

//        scrollingHelper.setupScrollingForPages(self.scrollContainer4, pages: scrollingHelper.sampleColorPages(), direction: RSScrollingDirection.horizontal, pagingEnabled: false)
    }
    
    func setupScrolling5() {
    scrollingHelper.setupScrollingForImage(self.scrollContainer5, imageName:"leonidAfremov.jpg")
    }
    
    func setupScrolling6() {
        let strings = ["opened at 3:15", "tapped at 4:15", "opened at 5:45"]
        scrollingHelper.setupScrollingForPages(self.scrollContainer6, pages: scrollingHelper.arrayOfLabelsForStrings(strings, font:nil), direction: RSScrollingDirection.horizontal, pagingEnabled: true)
    }
    func getScrollViews(view: UIView) -> [UIScrollView]{
        var scrollViews = [UIScrollView]()
        if view.isKindOfClass(UIScrollView) {
            scrollViews.append(view as! UIScrollView)
        }
        view.subviews.forEach { (subview: UIView) -> () in
            scrollViews += self.getScrollViews(subview)
        }
        return scrollViews
    }

    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        // for all subviews that are UIScrollView, adjust offset
        let scrollViews = self.getScrollViews(self.view)
        scrollViews.forEach { (scrollView: UIScrollView) -> () in
            if scrollView.bounds.width > 0 && scrollView.bounds.height > 0 {

                let xRatio = scrollView.contentOffset.x / scrollView.bounds.width
                let yRatio = scrollView.contentOffset.y / scrollView.bounds.height
                print("contentOffset: \(scrollView.contentOffset) xRatio: \(xRatio) yRatio: \(yRatio)")

                coordinator.animateAlongsideTransition({ (UIViewControllerTransitionCoordinatorContext) -> Void in
                    scrollView.contentOffset = CGPoint(x: xRatio * scrollView.bounds.width, y: yRatio * scrollView.bounds.height)
                    }, completion: nil)
            }
        }
    }
}
