
import UIKit

protocol PinterestCollectionViewLayoutDelegate {
    func collectionView(collectionView:UICollectionView, heightForContentItemAtIndexPath indexPath:IndexPath, width:CGFloat) -> CGFloat
    
    func collectionView(collectionView:UICollectionView, heightForAnnotationAtIndexPath indexPath:IndexPath, width:CGFloat) -> CGFloat
}

class PinterestLayout: UICollectionViewLayout {
    var delegate:PinterestCollectionViewLayoutDelegate!
    var numberOfColumns = 1
    
    private var cache = [PinterestLayoutAttributes]()
    private var contentHeight:CGFloat = 0
    private var width:CGFloat {
        get {
            return collectionView!.bounds.width
        }
    }
    
    private let cellInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    
    override class var layoutAttributesClass: AnyClass {
        return PinterestLayoutAttributes.self
    }

    /* These values represent the width and height of all the content, not just the content that is currently visible */
    override var collectionViewContentSize: CGSize {
        get {
            return .init(width:width, height:contentHeight)
        }
    }
    
    override func invalidateLayout() {
        super.invalidateLayout()
        cache.removeAll()
    }
    
    /* calculate the frames of cells and cache */
    override func prepare() {
        super.prepare()
        
        if cache.isEmpty {
            
            guard let collectionView = collectionView, let delegate = delegate else { return }
 
            let columnWidth = width/CGFloat(numberOfColumns)
            
            /* holds x-position for each cell item  */
            var xOffsets = [CGFloat]()
            
            /* x-position is 0, columnWidth, 2 * columnWidth, etc */
            for column in 0..<numberOfColumns {
                xOffsets.append(CGFloat(column) * columnWidth)
            }
            
             /* holds y-position for each cell item  */
            var yOffsets = [CGFloat](repeating: 0, count: numberOfColumns)
            
            /* y-position is based on the content size which we get from the collection view */
            var column = 0
            for item in 0..<collectionView.numberOfItems(inSection: 0){
                
                let indexPath = IndexPath(item: item, section: 0)
                
                /* ask delegate for content and annotation height */
                let width = columnWidth - cellInsets.left - cellInsets.right
                let contentsHeight = delegate.collectionView(collectionView: collectionView, heightForContentItemAtIndexPath: indexPath, width: width)
                
                let annotationHeight = delegate.collectionView(collectionView: collectionView, heightForAnnotationAtIndexPath: indexPath, width:width)
                
                let height = contentsHeight + annotationHeight
                
                /* calculate the frame using the offsets and height from delegate */
                let frame = CGRect(x: xOffsets[column], y: yOffsets[column], width: columnWidth, height: height)
                let insetFrame = frame.inset(by: cellInsets)
                
                /* get the attributes for the indexPath and update the frame */
                let attributes = PinterestLayoutAttributes(forCellWith: indexPath)
                attributes.frame = insetFrame
                attributes.contentHeight = contentsHeight
                attributes.annotationHeight = annotationHeight
                cache.append(attributes)
                
                /*
                 * calculate the height of the tallest column, then update content height
                 * to greater of current height or calculated frame
                 */
                contentHeight = max(contentHeight, frame.maxY)
             
                /* update the yOffsets for current column */
                yOffsets[column] += height
                
                /* check if there are other columns to process */
                column = (column >= (numberOfColumns - 1)) ? 0 : (column + 1)
            }
        }
    }
    
    /*
     * Returns the layout attributes for all of the cells and views in the specified rectangle.
     * Subclasses must override this method and use it to return layout information for all items
     * whose view intersects the specified rectangle.
     *
     * check if the frame of the cached attribute intersects with the rect provided, if so add to '
     * the list array of attributes to send to the collection view
    */
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var layoutAttributes = [UICollectionViewLayoutAttributes]()
        cache.forEach { (attributes) in
            if attributes.frame.intersects(rect){
                layoutAttributes.append(attributes)
            }
        }
        return layoutAttributes
    }
    
}
