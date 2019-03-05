//
//  CircularLayoutAttributes.swift
//  CollectionViewLayouts
//
//  Created by user on 1/17/19.
//  Copyright © 2019 user. All rights reserved.
//

import UIKit

class CircularLayoutAttributes: UICollectionViewLayoutAttributes {

    var anchorPoint = CGPoint(x: 0.5, y: 0.5)
    var angle:CGFloat = 0 {
        didSet {
            zIndex = Int(angle * 100000)
            transform = CGAffineTransform.init(rotationAngle: angle)
        }
    }
    
    override func copy(with zone: NSZone? = nil) -> Any {
        let copy = super.copy(with: zone)
        if let copy = copy as? CircularLayoutAttributes {
            copy.anchorPoint = anchorPoint
            copy.angle = angle
        }
        
        return copy
    }
    
    override func isEqual(_ object: Any?) -> Bool {
        if let attributes = object as? CircularLayoutAttributes {
            if attributes.anchorPoint == anchorPoint &&
                attributes.angle == angle {
                return super.isEqual(object)
            }
        }
        return false
    }
    
}
