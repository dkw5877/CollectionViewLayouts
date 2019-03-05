
import UIKit

class SlantedLayoutDelegate: NSObject, UICollectionViewDelegateFlowLayout {

    weak var collectionView:UICollectionView?
    
    init(collectionView:UICollectionView) {
        self.collectionView = collectionView
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let layout = collectionViewLayout as! SlantedlLayout
        let insets:CGFloat = layout.sectionInset.left +  layout.sectionInset.right
        let width = collectionView.frame.size.width
        return CGSize(width: width - insets, height: 150)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let collectionView = collectionView else { return }
        guard let cells = collectionView.visibleCells as? [SlantedCollectionViewCell] else { return }
        let bounds = collectionView.bounds
        for cell in cells {
            cell.updateParallaxOffset(collectionView: bounds)
        }
    }
}
