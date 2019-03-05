
import UIKit
import AVFoundation

class PinterestLayoutDelegate:NSObject, UICollectionViewDelegate, PinterestCollectionViewLayoutDelegate {
    func collectionView(collectionView: UICollectionView, heightForContentItemAtIndexPath indexPath: IndexPath, width: CGFloat) -> CGFloat {
        let size = CGSize(width: CGFloat.random(in: 100...300), height: CGFloat.random(in: 100...500))
        /* create sizing rect with largest height based on width */
        let boundingRect = CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude)
        let rect = AVMakeRect(aspectRatio: size, insideRect: boundingRect)
        return ceil(rect.height)
    }
    
    func collectionView(collectionView: UICollectionView, heightForAnnotationAtIndexPath indexPath: IndexPath, width: CGFloat) -> CGFloat {
        
        let annotation = "Integer sit amet ipsum non odio aliquet consequat"
        let comment = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed suscipit ante id justo sodales mollis. Nullam mauris libero, volutpat ac justo at, cursus iaculis felis. Vivamus aliquet lacus a purus."
        
        let annotationHeight = calculateTextHeight(width: width, text: annotation, attributes: [NSAttributedString.Key.font: FontUtility.caption])
        
        let commentHeight = calculateTextHeight(width: width, text: comment, attributes: [NSAttributedString.Key.font: FontUtility.body])
        
        let spacing:CGFloat = 10.0
        let height = ceil(annotationHeight + commentHeight + spacing * 2)
        return height
    }
    
    func calculateTextHeight(width:CGFloat, text:String, attributes:[NSAttributedString.Key:UIFont]) -> CGFloat {
        let size = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        let labelRect = text.boundingRect(with: size, options:[.usesLineFragmentOrigin, .usesFontLeading], attributes:attributes, context: nil)
        let height = labelRect.height
        return height
    }
}
