//
//  CustomSlider.swift
//  PodcastApp
//
//  Created by Ilyas Tyumenev on 05.10.2023.
//

import UIKit

class CustomSlider: UISlider {
    
    var trackWidth: CGFloat = 1 {
        didSet { setNeedsDisplay() }
    }
    
    override open func trackRect(forBounds bounds: CGRect) -> CGRect {
        let defaultBounds = super.trackRect(forBounds: bounds)
        
        return CGRect(
            x: defaultBounds.origin.x,
            y: defaultBounds.origin.y + defaultBounds.size.height/2 - trackWidth/2,
            width: defaultBounds.size.width,
            height: trackWidth
        )
    }
}
