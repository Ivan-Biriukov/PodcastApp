//
//  UILabel + Extension.swift
//  PodcastApp
//
//  Created by Ilyas Tyumenev on 08.10.2023.
//

import UIKit

extension UILabel {
    convenience init(
        text: String = "", font: UIFont?,  textAlignment: NSTextAlignment,
        color: UIColor, numberOfLines: Int = 0
    ) {
        self.init()
        self.text = text
        self.font = font
        self.textColor = color
        self.textAlignment = textAlignment
        self.numberOfLines = numberOfLines
        self.adjustsFontSizeToFitWidth = false
    }
}
