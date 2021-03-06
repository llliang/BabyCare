//
//  UIColor+extension.swift
//  Poems
//
//  Created by Neo on 16/9/27.
//  Copyright © 2016年 JL. All rights reserved.
//

import UIKit

extension UIColor{
    
    class func colorWithHex(hex:String) -> UIColor {
        return processColorWithHexAndAlpha(hex: hex, alpha: 1)
    }
    class func colorWithHexAndAlpha(hex:String, alpha:Float) -> UIColor {
        return processColorWithHexAndAlpha(hex: hex, alpha: alpha)
    }
    
    class private func processColorWithHexAndAlpha(hex:String, alpha:Float) -> UIColor {
        if hex.isEmpty {
            return UIColor(white: 0, alpha: CGFloat(alpha))
        }
        var tempHex = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
        if tempHex.characters.count<6 {
            return UIColor.clear
        }
        
        if tempHex.hasPrefix("0X") {
            tempHex = tempHex.substring(from: "0X".endIndex)
        }
        if tempHex.hasPrefix("#") {
            tempHex = tempHex.replacingOccurrences(of: "#", with: "")
        }
        if tempHex.characters.count<6 {
            return UIColor.clear
        }
        let rHex = tempHex.substring(to: tempHex.index(tempHex.startIndex, offsetBy: 2))
        
        let gHex = tempHex.substring(with: Range.init(uncheckedBounds: (tempHex.index(tempHex.startIndex, offsetBy: 2),tempHex.index(tempHex.startIndex, offsetBy: 4))))
        
        let bHex = tempHex.substring(from: tempHex.index(tempHex.startIndex, offsetBy: 4))
        
        var r: UInt32 = 0,g: UInt32 = 0 ,b: UInt32 = 0
        
        Scanner(string: rHex).scanHexInt32(&r)
        Scanner(string: gHex).scanHexInt32(&g)
        Scanner(string: bHex).scanHexInt32(&b)
        
        return UIColor(red: CGFloat(r)/255.0, green: CGFloat(g)/255.0, blue: CGFloat(b)/255.0, alpha: CGFloat(alpha))
    }
}
