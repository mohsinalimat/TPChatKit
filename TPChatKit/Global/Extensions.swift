//
//  Extensions.swift
//  TPChatKit
//
//  Created by Tarun Prajapati on 8/23/18.
//  Copyright © 2018 Tarun Prajapati. All rights reserved.
//

import Foundation
import UIKit

extension UILabel{
    
    static func heightForSingleLine(font: UIFont, fontPointSize pointSize: CGFloat) -> CGFloat {
        let label = UILabel()
        label.font = font.withSize(pointSize)
        label.numberOfLines = 0
        label.text = "TPChatKit"
        return label.sizeThatFits(CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude)).height
    }
    
    static func getSizeToFitText(text: String, font: UIFont, fontPointSize pointSize: CGFloat, maxWidth: CGFloat, maxHeight: CGFloat?) -> CGSize {
        let label = UILabel()
        label.font = font.withSize(pointSize)
        label.numberOfLines = 0
        label.text = text
        return label.sizeThatFits(CGSize(width: maxWidth, height: maxHeight ?? CGFloat.greatestFiniteMagnitude))
    }
    
}

extension UITextView{
    
    static func getSizeToFitText(text: String, font: UIFont, fontPointSize pointSize: CGFloat, maxWidth: CGFloat, maxHeight: CGFloat?) -> CGSize {
        let textView = UITextView()
        textView.font = font.withSize(pointSize)
        textView.textContainerInset = .zero
        textView.text = text
        return textView.sizeThatFits(CGSize(width: maxWidth, height: maxHeight ?? CGFloat.greatestFiniteMagnitude))
    }
    
    
    static func getLines(text: String, font: UIFont, fontPointSize pointSize: CGFloat, maxWidth: CGFloat) -> [String] {
        var linesArray = [String]()
        
        let myFont: CTFont = CTFontCreateWithName(font.fontName as CFString, font.pointSize, nil)
        let attStr = NSMutableAttributedString(string: text)
        attStr.addAttribute(kCTFontAttributeName as NSAttributedString.Key, value: myFont, range: NSRange(location: 0, length: attStr.length))
        
        let frameSetter: CTFramesetter = CTFramesetterCreateWithAttributedString(attStr as CFAttributedString)
        let path: CGMutablePath = CGMutablePath()
        path.addRect(CGRect(x: 0, y: 0, width: maxWidth, height: CGFloat.greatestFiniteMagnitude), transform: .identity)
        
        let frame: CTFrame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, 0), path, nil)
        guard let lines = CTFrameGetLines(frame) as? [Any] else {return linesArray}
        
        for line in lines {
            let lineRef = line as! CTLine
            let lineRange: CFRange = CTLineGetStringRange(lineRef)
            let range = NSRange(location: lineRange.location, length: lineRange.length)
            let lineString: String = (text as NSString).substring(with: range)
            linesArray.append(lineString)
        }
        
        return linesArray
    }
    
    
}


extension String{
    
    static func getTimeStampForMsgBubbleForDate(date: Date) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.string(from: date)
    }
    
}

extension UICollectionView {
    func scrollToBottom() {
        guard numberOfSections > 0 else {
            return
        }
        
        let lastSection = numberOfSections - 1
        
        guard numberOfItems(inSection: lastSection) > 0 else {
            return
        }
        
        let lastItemIndexPath = IndexPath(item: numberOfItems(inSection: lastSection) - 1,
                                          section: lastSection)
        scrollToItem(at: lastItemIndexPath, at: .bottom, animated: true)
    }
}

extension Date{
    
    func getHeaderViewString() -> String{
        
        //check if date is today
        if Calendar.current.compare(self, to: Date(), toGranularity: Calendar.Component.day) == .orderedSame{
            return "Today"
        }
        
        let dateFormatter = DateFormatter()
        //date is last within 7 days
        if Calendar.current.compare(self, to: Date(), toGranularity: Calendar.Component.weekOfYear) == .orderedSame{
            dateFormatter.dateFormat = "EEEE"
            return dateFormatter.string(from: self)
        }
        
        if Calendar.current.compare(self, to: Date(), toGranularity: Calendar.Component.year) == .orderedSame{
            dateFormatter.dateFormat = "MMM d"
        }else{
            dateFormatter.dateFormat = "dd/MM/yy"
        }
        
        return dateFormatter.string(from: self)
    }
    
}


