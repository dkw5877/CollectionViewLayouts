
import UIKit

class ImageHeaderView: UICollectionReusableView {
    
    let imageView:UIImageView = {
        let image = UIImage(named: "books")
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        imageView.frame = frame
        addSubview(imageView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
    }
    
}
