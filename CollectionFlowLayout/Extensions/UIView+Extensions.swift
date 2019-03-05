

import UIKit

extension UIView {
    
    func calculateTextHeight(width:CGFloat, text:String, attributes:[NSAttributedString.Key:UIFont]) -> CGFloat {
        let size = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        let labelRect = text.boundingRect(with: size, options:[.usesLineFragmentOrigin, .usesFontLeading], attributes:attributes, context: nil)
        let height = ceil(labelRect.height)
        return height
    }
}
