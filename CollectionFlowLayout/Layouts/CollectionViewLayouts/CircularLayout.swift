

import UIKit

class CircularLayout: UICollectionViewLayout {

    override class var layoutAttributesClass : AnyClass {
        return CircularLayoutAttributes.self
    }
    
    let itemSize = CGSize(width: 133, height: 173)
    
    var radius:CGFloat = 0 {
        didSet {
            invalidateLayout()
        }
    }
    
    var anglePerItem:CGFloat {
        return atan(itemSize.width / radius)
    }
    
    var attributeList = [CircularLayoutAttributes]()
    
    override var collectionViewContentSize: CGSize {
        guard let collectionView = collectionView else { return .zero }
        let width = CGFloat(collectionView.numberOfItems(inSection: 0)) * itemSize.width
        return .init(width: width, height: collectionView.frame.maxY)
    }
    
    var angleAtExtreme: CGFloat {
        return collectionView!.numberOfItems(inSection: 0) > 0 ?
            -CGFloat(collectionView!.numberOfItems(inSection: 0) - 1) * anglePerItem : 0
    }
    var angle: CGFloat {
        return angleAtExtreme * collectionView!.contentOffset.x / (collectionViewContentSize.width - collectionView!.bounds.width)
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    override func prepare() {
        super.prepare()
        
        guard let collectionView = collectionView else { return }
        radius = collectionView.bounds.width * 0.45
        let centerX = collectionView.contentOffset.x +  (collectionView.bounds.width / 2.0)
        
        let anchorPointY = (( itemSize.height / 2.0 ) + radius) / itemSize.height
        
        attributeList = (0..<collectionView.numberOfItems(inSection: 0)).map {
            (i) -> CircularLayoutAttributes in
            let attributes = CircularLayoutAttributes(forCellWith: IndexPath(item: i, section: 0))
            attributes.size = itemSize
            attributes.center = .init(x:centerX, y:collectionView.bounds.midY)
            attributes.angle = angle + (self.anglePerItem * CGFloat(i))
            attributes.anchorPoint = .init(x:0.5, y:anchorPointY)
            return attributes
        }
    }

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return attributeList
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return attributeList[indexPath.row]
    }
    
}

