//
//  UIColorExtension.swift
//  XplorPayMobile
//
//  Created by Carmen Jurcovan on 22.03.2022.
//

import UIKit

extension UIColor {
    /// Create color by a hex representation of RGB
    ///
    /// - Parameter hex: a valid hex value like 'fff'
    /// - Returns: UIColor as specified

    convenience init(hexString: String) {
        let scanner = Scanner(string: hexString.replacingOccurrences(of: "#", with: ""))
        var rgbValue: UInt64 = 0

        scanner.scanHexInt64(&rgbValue)

        let r = (rgbValue & 0xFF0000) >> 16
        let g = (rgbValue & 0xFF00) >> 8
        let b = rgbValue & 0xFF

        self.init(
            red: CGFloat(r) / 0xFF,
            green: CGFloat(g) / 0xFF,
            blue: CGFloat(b) / 0xFF, alpha: 1
        )
    }
}
