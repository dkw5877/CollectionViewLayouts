
import UIKit

class PinterestCollectionViewCell: UICollectionViewCell {
    
    private let content = UIImageView(frame: .zero)
    
    private let annotation:UILabel = {
        let label = UILabel(frame: .zero)
        label.numberOfLines = 0
        label.font = FontUtility.caption
        label.text = "Integer sit amet ipsum non odio aliquet consequat"
        return label
    }()
    
    private let comment:UILabel = {
        let label = UILabel(frame: .zero)
        label.numberOfLines = 0
        label.font = FontUtility.body
        label.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed suscipit ante id justo sodales mollis. Nullam mauris libero, volutpat ac justo at, cursus iaculis felis. Vivamus aliquet lacus a purus."
        return label
    }()
    
    private var contentHeight:CGFloat = 0.0
    private var annotationHeight:CGFloat = 0.0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(content)
        addSubview(annotation)
        addSubview(comment)
        layer.cornerRadius = 5.0
        layer.masksToBounds = true
        content.backgroundColor = UIColor(named: "darkGreen")
        annotation.backgroundColor = .white
        comment.backgroundColor = .white
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        content.frame = .init(x: 0, y: 0, width: frame.width, height: contentHeight)
        var textHeight:CGFloat = 0
        
        if let text = annotation.text {
            textHeight = calculateTextHeight(width: frame.width, text: text, attributes: [NSAttributedString.Key.font: annotation.font])
            annotation.frame = .init(x: 0, y: content.frame.maxY, width: frame.width, height:  textHeight)
        }

        if let text = comment.text {
            textHeight = calculateTextHeight(width: frame.width, text: text, attributes: [NSAttributedString.Key.font: comment.font])

            let height =  annotationHeight - annotation.frame.height
            comment.frame = .init(x: 0, y: annotation.frame.maxY, width: frame.width, height: height)
           
        }
    }
    
    /*
     * If the layout object supports custom layout attributes, you can use this method to apply those attributes to the view
     * This method is called after the appropriate init method and before layout subviews
     */
    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)
        if let attributes = layoutAttributes as? PinterestLayoutAttributes {
            contentHeight = attributes.contentHeight
            annotationHeight = attributes.annotationHeight
        }
    }
}
