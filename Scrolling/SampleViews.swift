//
//  SampleViews.swift
//  Scrolling
//
//  Created by Roselle Milvich on 2/1/16.
//  Copyright © 2016 Roselle Tanner. All rights reserved.
//

import UIKit

class SampleViews {
    
    // returns an array of UIViews the colors of green, red, and purple
    class func sampleColorPages() -> [UIView] {
        let colors = [UIColor.greenColor(), UIColor.redColor(), UIColor.purpleColor()]
        var views = [UIView]()
        for i in 0..<colors.count {
            let color = colors[i]
            let colorView = UIView()
            colorView.backgroundColor = color
            views.append(colorView)
        }
        return views
    }
    
    // returns an array of UITextViews from the strings provided
    class func textViewsForStrings(strings: [String]) -> [UITextView] {
        var array = [UITextView]()
        for string in strings {
            let textView = UITextView()
            textView.text = string
            textView.textAlignment = NSTextAlignment.Center
            array.append(textView)
        }
        return array
    }
    
    // returns an array of labels from the strings provided
    class func labelsForStrings(strings: [String], font: UIFont? = UIFont(name: "arial", size: 8)) -> [UILabel] {
        var array = [UILabel]()
        for string in strings {
            let label = UILabel()
            label.text = string
            label.textAlignment = NSTextAlignment.Center
            label.adjustsFontSizeToFitWidth = true
            label.minimumScaleFactor = 10/label.font.pointSize
            label.baselineAdjustment = UIBaselineAdjustment.AlignCenters
            label.numberOfLines = 0
            label.lineBreakMode = NSLineBreakMode.ByWordWrapping
            if font != nil {
                label.font = font
            }
            array.append(label)
        }
        return array
    }
}


