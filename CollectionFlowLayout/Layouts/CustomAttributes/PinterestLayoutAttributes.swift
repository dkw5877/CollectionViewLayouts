
import UIKit

class PinterestLayoutAttributes: UICollectionViewLayoutAttributes {

    var contentHeight:CGFloat = 0
    var annotationHeight:CGFloat = 0

    /*
     * implement any methods appropriate for copying your custom attributes to
     * new instances of your subclass
     */
    override func copy(with zone: NSZone? = nil) -> Any {
        let copy = super.copy(with: zone)
        if let copy = copy as? PinterestLayoutAttributes {
            copy.contentHeight = contentHeight
            copy.annotationHeight = annotationHeight
        }
        return copy
    }
    
    
    /*
     * The default implementation of this method checks only the existing properties of this class,
     * you must implement your own version of the method to compare any additional properties
     */
    override func isEqual(_ object: Any?) -> Bool {
        if let attributes = object as? PinterestLayoutAttributes {
            if contentHeight == attributes.contentHeight &&
                annotationHeight == attributes.annotationHeight {
                return super.isEqual(object)
            }
        }
        return false
    }
}
