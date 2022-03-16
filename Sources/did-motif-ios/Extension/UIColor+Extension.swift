//
//  File.swift
//  
//
//  Created by zY on 2022/3/16.
//

import Foundation
import UIKit

extension UIColor {
    convenience init(hex: String, alpha: CGFloat = 1) {
        var cString: String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if cString.hasPrefix("#") {
            cString.remove(at: cString.startIndex)
        }

        if cString.count != 6 {
            self.init(
                red: CGFloat((255 & 0xFF0000) >> 16) / 255.0,
                green: CGFloat((255 & 0x00FF00) >> 8) / 255.0,
                blue: CGFloat(255 & 0x0000FF) / 255.0,
                alpha: CGFloat(0.5)
            )
        } else {
            var rgbValue: UInt32 = 0
            Scanner(string: cString).scanHexInt32(&rgbValue)
            self.init(
                red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                alpha: CGFloat(alpha)
            )
        }
    }
}
