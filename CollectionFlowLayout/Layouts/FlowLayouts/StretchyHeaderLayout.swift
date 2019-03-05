
import UIKit

class StretchyHeaderLayout: UICollectionViewFlowLayout {

    let padding:CGFloat = 16
    
    override init() {
        super.init()
        sectionInset = .init(top: padding, left: padding, bottom: padding, right: padding)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let collectionView = collectionView else { return nil }
        let layoutAttributes = super.layoutAttributesForElements(in: rect)
        
        let contentOffset = collectionView.contentOffset
        
         if contentOffset.y < 0 {
            layoutAttributes?.forEach({ (attribute) in
                if attribute.representedElementKind == UICollectionView.elementKindSectionHeader {
                    let height = attribute.frame.height - contentOffset.y
                    attribute.frame = CGRect(x: 0, y: contentOffset.y, width: attribute.frame.width, height: height)
                }
            })
        }
        
        return layoutAttributes
    }
}
