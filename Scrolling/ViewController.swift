//
//  ViewController.swift
//  Scrolling
//
//  Created by Roselle Milvich on 2/4/15.
//  Copyright (c) 2015 Roselle Tanner. All rights reserved.
//


import UIKit

// MARK: Class ViewController

class ViewController: UIViewController {
    var scrollViews = [UIScrollView]()
    var offsetRatios = [(x: CGFloat, y: CGFloat)]()

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
        
        // Sample of scrolling horizontally through pages (container width pages)
        scrollingHelper.setupScrollingForPages(self.scrollContainer1, pages: SampleViews.sampleColorPages(), direction: RSScrollingDirection.horizontal, pagingEnabled: false)
     }
    
    func setupScrolling2() {
        
        // Sample of scrolling an image
        scrollingHelper.setupScrollingForImage(self.scrollContainer2, imageName:"t_Bierstadt-Rocky Mountain landscape.jpg")
    }
    
    func setupScrolling3() {
        
        // Done in IB, Sample of scrolling vertically through pages (container width pages)

    }
    
    func setupScrolling4() {
        
        // Sample of scrolling through text
        let strings = ["***Lorem ipsum dolor sit amet, consectetur adipiscing elit. Morbi suscipit pulvinar orci nec vulputate. Aenean porta ac nulla id pulvinar. Duis odio ante, luctus eget pellentesque ut, faucibus et ex. Fusce mollis ut ante eu egestas. Maecenas vel mauris sed ipsum hendrerit condimentum at vitae nunc. Pellentesque ac tellus tortor. Nullam ante leo, iaculis quis lorem ultricies, consectetur iaculis ligula. Donec eget ex sit amet ipsum ultricies iaculis id sit amet ante.",
            "***Donec at quam accumsan, tristique ex eget, dictum ex. Fusce finibus molestie velit, vitae elementum risus maximus quis. Donec volutpat nulla eu dignissim tincidunt. Praesent dapibus convallis dui, id dignissim odio auctor id. Donec ut nisi vulputate, consequat leo in, tempus mi. Vivamus lacus eros, vestibulum vel tellus sed, commodo viverra libero. Suspendisse et euismod dui, feugiat placerat mi. Aenean dui ante, tempor eu placerat vitae, malesuada vel velit. Integer eget metus risus. Pellentesque ut viverra nibh. In hac habitasse platea dictumst.",
            "***Aliquam erat volutpat. Praesent et diam at quam maximus convallis id vitae nulla. Pellentesque ut tincidunt ipsum. Vivamus rhoncus, neque in pulvinar auctor, mauris sapien consectetur tellus, eget cursus mi sem et augue. Vestibulum quis maximus lorem, id vulputate leo. Etiam id consectetur quam. In convallis fringilla nibh.",
            "***Nulla faucibus odio nec nisl dignissim commodo. Suspendisse convallis tortor ac ullamcorper mollis. Vivamus ullamcorper euismod lectus, et facilisis purus imperdiet quis. Cras ultrices arcu ac dignissim hendrerit. Aenean id sem tristique, dictum lacus sit amet, laoreet justo. Donec porta, metus vitae hendrerit auctor, arcu quam porttitor lorem, ac porta nulla ligula eget enim. Integer ut ultrices enim, eget tristique ipsum. Integer pellentesque fringilla orci ac laoreet. Donec quis n eque velit. Suspendisse ultrices iaculis odio, eget imperdiet ante blandit at. Donec scelerisque suscipit nulla vel accumsan. Fusce quis arcu at est pellentesque accumsan. Maecenas aliquam sem augue, id hendrerit metus mattis ac. Lorem ipsum dolor sit amet, consectetur adipiscing elit."]
        scrollingHelper.setupScrollingForViews(self.scrollContainer4, views: SampleViews.labelsForStrings(strings), direction: RSScrollingDirection.vertical, pagingEnabled: false, oneViewPerPage: false)
    }
    
    func setupScrolling5() {
        
        // Sample of scrolling an image
    scrollingHelper.setupScrollingForImage(self.scrollContainer5, imageName:"leonidAfremov.jpg")
    }
    
    func setupScrolling6() {
        
        // Sample of scrolling label's as pages (container width pages)
        let strings = ["this is page 1", "this is page 2", "this is page 3"]
        scrollingHelper.setupScrollingForPages(self.scrollContainer6, pages: SampleViews.labelsForStrings(strings), direction: RSScrollingDirection.horizontal, pagingEnabled: true)
    }

    // handles rotation
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        scrollingHelper.prepareScrollViewsForTransitionToSize(self.view.scrollViews(), coordinator: coordinator)
    }
    
    /*
    // prior to ios8, to handle rotation, instead of viewWillTransiionToSize() and scrollingHelper.prepareScrollViewsForTransitionToSize(), do the following:
    // class properties
    var scrollViews = [UIScrollView]()
    var offsetRatios = [(x: CGFloat, y: CGFloat)]()
    
    // in viewDidLoad
    scrollViews = self.view.scrollViews()
    
    // save the ratio of offset/width before rotating
    override func willRotateToInterfaceOrientation(toInterfaceOrientation: UIInterfaceOrientation, duration: NSTimeInterval) {
        offsetRatios = []
        for scrollView in scrollViews {
            if scrollView.contentSize.width > 0 && scrollView.contentSize.height > 0 {
                let xRatio = scrollView.contentOffset.x / scrollView.contentSize.width
                let yRatio = scrollView.contentOffset.y / scrollView.contentSize.height
                offsetRatios.append((xRatio, yRatio))
            } else {
                offsetRatios.append((0.0, 0.0))
            }
        }
    }
    
    // set the offset to ratio * width to animate to
    override func willAnimateRotationToInterfaceOrientation(toInterfaceOrientation: UIInterfaceOrientation, duration: NSTimeInterval) {
        for i in 0..<scrollViews.count {
            let scrollView = scrollViews[i]
            scrollView.contentOffset = CGPoint(x: offsetRatios[i].x * scrollView.contentSize.width, y: offsetRatios[i].y * scrollView.contentSize.height)
        }
    }
*/
}
