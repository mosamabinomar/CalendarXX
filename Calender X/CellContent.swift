//
//  CellContent.swift
//  Calender X
//
//  Created by osama on 8/1/16.
//  Copyright © 2016 osama. All rights reserved.
//

import UIKit


class CellContent: UICollectionViewCell {
    var settings:SettingsController?
    var label: UILabel!
    var text: String! {
        get {
            return label.text
        }
        set(newText) {
            label.text = newText
            var newLabelFrame = label.frame
            var newContentFrame = contentView.frame
            let textSize = self.dynamicType.sizeForContentString(newText,forMaxWidth: maxWidth)
            newLabelFrame.size = textSize
            newContentFrame.size = textSize
            label.frame = newLabelFrame
            contentView.frame = newContentFrame
        }
    }
    //return the size of cell according to contents
    var maxWidth: CGFloat!
    class func sizeForContentString(s: String, forMaxWidth maxWidth: CGFloat)->CGSize{
        
        let maxSize: CGSize?
        if s.characters.count < 3 {
              maxSize = CGSizeMake(60,60)
        }else{
             maxSize = CGSizeMake(maxWidth, 20)
        }
        return maxSize!
        
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        label = UILabel(frame: self.contentView.bounds)
        label.opaque = false
        label.textColor = UIColor.blackColor()
        label.textAlignment = .Center
        label.font = self.dynamicType.defaultFont()
        contentView.addSubview(label)
        // add touch event to label
        label.userInteractionEnabled = true
        let tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(labelAction))
        label.addGestureRecognizer(tap)
        //get the setting controller instance
        settings = UIApplication.sharedApplication().keyWindow?.rootViewController?.childViewControllers.last?.childViewControllers.last as? SettingsController
        
        
    }
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
    }
    class func defaultFont() -> UIFont {
        return UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
    }

    //MARK: Gesture recognozer for UILabel
    func labelAction(gr:UITapGestureRecognizer) {
        if label.text! == " " || (label.text?.characters.count)! > 2{
            return   // label is other than a day then kindy return3
        }else{
        
            let month  = settings?.getCurrentMonth()
            let day = Int(label.text!)
            let message = settings?.getEventDescription(month!, day: day!)
            let alert = UIAlertController(title: "Date event", message:message, preferredStyle: .Alert)
            let action = UIAlertAction(title: "Done", style: .Default, handler: nil)
            alert.addAction(action)
            UIApplication.sharedApplication().keyWindow?.rootViewController?.presentViewController(alert, animated: true, completion: nil)
        }
        
    }
}

