
import UIKit

class FeaturedCollectionViewCell: UICollectionViewCell {
    
    var image:UIImage? {
        didSet {
            imageView.image = image
        }
    }
    
    private var dimmerAlpha: CGFloat = 0 {
        didSet {
            dimmerView.alpha = dimmerAlpha
        }
    }
    
    private var imageView = UIImageView()    
    private let dimmerView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configureViews()
    }
    
    private func configureViews() {
        addSubview(imageView)
        addSubview(dimmerView)
        imageView.backgroundColor = .clear
        imageView.contentMode = .scaleAspectFill
        dimmerView.backgroundColor = .black
    }
    
    private func configureViewLayouts() {
        imageView.frame = bounds
        dimmerView.frame = bounds
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configureViewLayouts()
    }
    
    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)
        let standardHeight = FeaturedCellLayout.LayoutConstants.Cell.standardHeight
        let featuredHeight = FeaturedCellLayout.LayoutConstants.Cell.featuredHeight
        
        let delta = 1 - (featuredHeight - frame.height) / (featuredHeight - standardHeight)
        
        let minAplha:CGFloat = 0.10
        let maxAlpha:CGFloat = 0.70
        dimmerAlpha = maxAlpha - (delta * (maxAlpha - minAplha))
    }
    
}
