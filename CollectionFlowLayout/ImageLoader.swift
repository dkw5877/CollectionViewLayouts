
import UIKit

class ImageLoader {

    static public func loadRandomImage() -> UIImage {
        let random = Int.random(in: 1...4)
        switch random {
        case 1:
            return UIImage(imageLiteralResourceName: "books")
        case 2:
            return UIImage(imageLiteralResourceName: "athens")
        case 3:
            return UIImage(imageLiteralResourceName: "odeion-of-herodes-atticus")
        case 4:
            return UIImage(imageLiteralResourceName: "acropolis")
        default:break
        }
        return UIImage()
    }
    
    private func loadImageFromBundle() {
    
    }
}
