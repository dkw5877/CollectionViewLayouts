

import UIKit

class SlantedCollectionViewCell: UICollectionViewCell {
    
    var parallaxOffset:CGFloat = 0 {
        didSet {
            imageView.center.y = parallaxOffset
            imageView.layoutIfNeeded()
            imageView.setNeedsDisplay()
        }
    }
    
    let imageView:UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .white
        return imageView
    }()
    
    let containerView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }
    
    private func setupViews() {
        clipsToBounds = false
        addSubview(containerView)
        containerView.addSubview(imageView)
        imageView.image = ImageLoader.loadRandomImage()
        containerView.clipsToBounds = true
        layoutViews()
    }
    
    private func layoutViews() {
        print("cell bounds", self.bounds)
        print("cell frame", self.frame)
        
        containerView.backgroundColor = .orange
        containerView.frame = self.bounds.insetBy(dx: -40, dy: 0)
        containerView.center.y = self.bounds.midY
        containerView.center.x = self.bounds.midX
        print("containerView frame", containerView.frame)
        print("containerView bounds", containerView.bounds)
        
        imageView.bounds = CGRect(x: 0, y: 0, width: containerView.bounds.width, height:containerView.bounds.height * 2)
        
        imageView.center = .init(x: containerView.bounds.midX, y: containerView.bounds.midY)
        print("image frame", imageView.frame)
        print("image bounds", imageView.bounds)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        layoutViews()
    }
    
    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)
        imageView.transform = layoutAttributes.transform.inverted()
    }
    
    public func updateParallaxOffset(collectionView bounds: CGRect){
        /* center of collection view */
        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        
        /* offset from center of the collectionview */
        let offsetFromCenter = CGPoint(x: center.x - self.center.x, y: center.y - self.center.y)
        
        /* cap the amount so the photo is always present */
        let maxVerticalOffset = bounds.height/2 + self.bounds.height/2
        
        /* how much to move by */
        let scaleFactor = 40/maxVerticalOffset //magic number

        /* move in opposite direction of the users scroll */
        parallaxOffset = -offsetFromCenter.y * scaleFactor

        print("parallax offset", parallaxOffset)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        print(#function)
        parallaxOffset = 0
    }
}
