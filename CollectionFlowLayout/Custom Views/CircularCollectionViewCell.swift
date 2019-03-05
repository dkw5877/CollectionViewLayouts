
import UIKit

class CircularCollectionViewCell: UICollectionViewCell {
 
    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)
        if let attributes = layoutAttributes as? CircularLayoutAttributes {
            layer.anchorPoint = attributes.anchorPoint
            center.y = (attributes.anchorPoint.y - 0.5) * bounds.height
        }
    }
}
