
import UIKit

/**
 * STICKY HEADERS WAS ADDED AS AN OPTION IN iOS 9 BY SETTING THE PROPERTY
 * sectionHeadersPinToVisibleBounds = true
 * THIS CRASHES IF COUNT OF ITEMS IN SECTION EXCEEDS THE NUMBER OF SECTIONS
 */

class StickyHeadersLayout: UICollectionViewFlowLayout {
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        guard let collectionView = collectionView else { return nil }
        guard var layoutAttributes = super.layoutAttributesForElements(in: rect) else { return nil }

        /*
         * example: how to get attributes for element category (cell, supplementary, decorator)
         * get all missing headers sections so we can create attributes
         * first get all the cells, then we can get the index and from
         * the section
         */
        var headersNeedingLayout = IndexSet()
        for attribute in layoutAttributes {
            if attribute.representedElementCategory == .cell {
                headersNeedingLayout.insert(attribute.indexPath.section)
            }
        }
        
        /*
         * example: how to find attributes by element kind (header/footer)
         * remove from headers any header where the attributes are already in the
         * headers attribute array.
         */
        for attributes in layoutAttributes {
            if let elementKind = attributes.representedElementKind {
                if elementKind == UICollectionView.elementKindSectionHeader {
                    headersNeedingLayout.remove(attributes.indexPath.section)
                }
            }
        }
        
        /*
         * Get all the layout attributes for the supplementary headers
         *
         */
        for (index, _) in headersNeedingLayout.enumerated() {
            let indexPath = IndexPath(item: 0, section: index)
            let attribtues = self.layoutAttributesForSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader , at: indexPath)
            layoutAttributes.append(attribtues!)
        }
        
        /*
         * apply the three rules
         *
         */
        for attributes in layoutAttributes {
            if let elementKind = attributes.representedElementKind {
                if elementKind == UICollectionView.elementKindSectionHeader {
                    
                    //get section
                    let section = attributes.indexPath.section
                    if let attributesForFirstItemInSection = layoutAttributesForItem(at: IndexPath(item: 0, section: section)) {
                        
                        let lastItem = collectionView.numberOfItems(inSection: section) - 1
                        let indexPath = IndexPath(item: 0, section: lastItem)
                        
                        if let attributesForLastItemInSection = layoutAttributesForItem(at: indexPath){
                            var frame = attributes.frame
                            let offset = collectionView.contentOffset.y
                            
                            /* The header should never go further up than one-header-height above
                             the upper bounds of the first cell in the current section */
                            let minY = attributesForFirstItemInSection.frame.minY - frame.height
                            
                            /* The header should never go further down than one-header-height above
                             the lower bounds of the last cell in the section */
                            let maxY = attributesForLastItemInSection.frame.maxY - frame.height
                            
                            /* If it doesn't break either of those two rules then it should be
                             positioned using the y value of the content offset */
                            let y = min(max(offset, minY), maxY)
                            frame.origin.y = y
                            attributes.frame = frame
                            attributes.zIndex = 99
                        }
                    }
                }
            }
        }
        return layoutAttributes
    }
}
