
import UIKit

class StickyHeadersLayoutDelegate: NSObject, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let layout = collectionViewLayout as! StickyHeadersLayout
        let insets:CGFloat = layout.sectionInset.left +  layout.sectionInset.right
        let width = collectionView.frame.size.width
        return CGSize(width: width - insets, height: 60)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let size = collectionView.frame.size
        return CGSize(width: size.width, height: 40.0)
    }
}
