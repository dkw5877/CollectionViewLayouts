

import UIKit

func degreesToRadians(degrees:Double) -> CGFloat {
    return CGFloat(Double.pi * (degrees / 180))
}

class SlantedlLayout: UICollectionViewFlowLayout {
    
    override func prepare() {
        super.prepare()
        collectionView?.contentInset = UIEdgeInsets(top: 50, left: 0, bottom: 50, right: 0)
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let layoutAttributes = super.layoutAttributesForElements(in: rect) else { return nil }
        
        for attributes in layoutAttributes {
        
            /* inset frame slightly before we rotate so entire cell is visible */
            attributes.frame = attributes.frame.insetBy(dx: 12, dy: 0)
            /* rotate counter clockwise 14 degress */
            attributes.transform = .init(rotationAngle: degreesToRadians(degrees: -14))
        }
        
        return layoutAttributes
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }

}
