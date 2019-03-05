
import UIKit

enum Indentifiers:String {
    case basicCellIdentifier
    case pinterestCellIdentifier
    case circularCellIdentifier
    case imageHeaderIdentifier
    case featureCellIdentifier
    case slantedCellIdentifier
    case basicHeaderIdentifier
}

enum Layout {
    case stretchyHeaderLayout
    case pinterestLayout
    case stickyHeadersLayout
    case featuredCellLayout
    case slantedLayout
    case circularLayout
}

class CollectionViewController: UICollectionViewController {

    private var dataSource = CollectionViewDataSource()
    private var flowLayoutDelegate:UICollectionViewDelegateFlowLayout = StretchyHeadersLayoutDelegate()
    private let pinterestLayoutDelegate = PinterestLayoutDelegate()
    private var currentLayout:UICollectionViewLayout = UICollectionViewFlowLayout()
    var layoutType:Layout = .slantedLayout
    
    override init(collectionViewLayout layout: UICollectionViewLayout) {
        super.init(collectionViewLayout: layout)
        currentLayout = layout
    }
    
    convenience init(collectionViewLayout layout: UICollectionViewLayout, layoutType:Layout) {
        self.init(collectionViewLayout:layout)
        self.layoutType = layoutType
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        switch layoutType {
        case .stretchyHeaderLayout:
            setupStretchyHeaderLayout()
        case .pinterestLayout:
            setupPinterestLayout()
        case .stickyHeadersLayout:
            setupStickyHeadersLayout()
        case.featuredCellLayout:
            setupFeaturedCellLayout()
        case.slantedLayout:
            setupSlantedLayout()
        case.circularLayout:
            setupCircularLayout()
        }
        setupCollectionView()
    }
    
    private func setupCollectionView(){
        /* extend view under status bar */
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.dataSource = dataSource
        regisisterCells()
    }
    
    private func regisisterCells() {
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: Indentifiers.basicCellIdentifier.rawValue)
        collectionView.register(PinterestCollectionViewCell.self, forCellWithReuseIdentifier: Indentifiers.pinterestCellIdentifier.rawValue)
        collectionView.register(CircularCollectionViewCell.self, forCellWithReuseIdentifier: Indentifiers.circularCellIdentifier.rawValue)
        collectionView.register(FeaturedCollectionViewCell.self, forCellWithReuseIdentifier: Indentifiers.featureCellIdentifier.rawValue)
        collectionView.register(SlantedCollectionViewCell.self, forCellWithReuseIdentifier: Indentifiers.slantedCellIdentifier.rawValue)
        
        /* header views */
        collectionView.register(ImageHeaderView.self, forSupplementaryViewOfKind:UICollectionView.elementKindSectionHeader, withReuseIdentifier: Indentifiers.imageHeaderIdentifier.rawValue)
        collectionView.register(BasicHeaderView.self, forSupplementaryViewOfKind:UICollectionView.elementKindSectionHeader, withReuseIdentifier: Indentifiers.basicHeaderIdentifier.rawValue)
    }
    
    /* For FlowLayout, the delegate is expected to be the collection view's delegate */
    private func setupStretchyHeaderLayout() {
        if currentLayout.isKind(of: StretchyHeaderLayout.self){
            collectionView.backgroundColor = .white
            flowLayoutDelegate = StretchyHeadersLayoutDelegate()
            dataSource.layout = .stretchyHeaderLayout
            collectionView.delegate = flowLayoutDelegate
        }
    }
    
    /* For Pinterest layout, the layout has a custom delegate */
    private func setupPinterestLayout() {
        if currentLayout.isKind(of: PinterestLayout.self) {
            let layout = currentLayout as! PinterestLayout
            layout.delegate = pinterestLayoutDelegate
            layout.numberOfColumns = 2
            dataSource.layout = .pinterestLayout
            collectionView.backgroundColor = .black
        }
    }
    
    /* For Sticky headers layout, the delegate is expected to be the collection view's delegate */
    private func setupStickyHeadersLayout() {
        if currentLayout.isKind(of: StickyHeadersLayout.self) {
            collectionView.backgroundColor = .black
            dataSource.layout = .stickyHeadersLayout
            flowLayoutDelegate = StickyHeadersLayoutDelegate()
            collectionView.delegate = flowLayoutDelegate
        }
    }
    
    private func setupFeaturedCellLayout() {
        if currentLayout.isKind(of: FeaturedCellLayout.self){
            collectionView.backgroundColor = .white
            collectionView.decelerationRate = .fast
            dataSource.layout = .featuredCellLayout
        }
    }
    
    private func setupSlantedLayout() {
        if currentLayout.isKind(of:  SlantedlLayout.self ) {
            collectionView.backgroundColor = .black
            let layout = currentLayout as! SlantedlLayout
            layout.minimumInteritemSpacing = 16.0
            dataSource.layout = .slantedLayout
            flowLayoutDelegate = SlantedLayoutDelegate(collectionView: collectionView)
            collectionView.delegate = flowLayoutDelegate
        }
    }
    
    private func setupCircularLayout() {
        if currentLayout.isKind(of:  CircularLayout.self ) {
            collectionView.backgroundColor = .white
            dataSource.layout = .circularLayout
            collectionView.delegate = flowLayoutDelegate
        }
    }
    
    private func changeLayout(to layout:Layout){
     
        layoutType = layout
        
        switch layoutType {
        case .stretchyHeaderLayout:
            currentLayout = StretchyHeaderLayout()
            setupStretchyHeaderLayout()
            collectionViewLayout.invalidateLayout()
            collectionView.setCollectionViewLayout(currentLayout, animated: true){ (finished) in
                self.collectionView.reloadData()
            }
        case .pinterestLayout:
            currentLayout = PinterestLayout()
            setupPinterestLayout()
            collectionViewLayout.invalidateLayout()
            self.collectionView.setCollectionViewLayout(currentLayout, animated: true) { (finished) in
                self.collectionView.reloadData()
            }
        case .stickyHeadersLayout:
            currentLayout = StickyHeadersLayout()
            setupStickyHeadersLayout()
        case .featuredCellLayout:
            currentLayout = FeaturedCellLayout()
            invalidateAndReload()
        case .slantedLayout:
            currentLayout = SlantedlLayout()
            invalidateAndReload()
        case .circularLayout:
            currentLayout = CircularLayout()
            invalidateAndReload()
        }
    }
    
    private func invalidateAndReload() {
        collectionViewLayout.invalidateLayout()
        self.collectionView.setCollectionViewLayout(currentLayout, animated: true) { (finished) in
            self.collectionView.reloadData()
        }
    }
    
     /* Invalidate the layout when the device rotates */
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        super.willTransition(to: newCollection, with: coordinator)
        collectionViewLayout.invalidateLayout()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        updateLayout(delay: 3.0)
//        updateLayout(delay: 7.0)
    }
    
    private func updateLayout(delay:Double) {
//        DispatchQueue.main.asyncAfter(deadline: .now() + delay) { [weak self] in
//            print("changing layout")
//            guard let currentLayout = self?.layoutType else { return }
//            switch currentLayout {
//            case .stretchyHeaderLayout:
//                self?.changeLayout(to: .pinterestLayout)
//            case .pinterestLayout:
//                self?.changeLayout(to: .stickyHeadersLayout)
//            case .stickyHeadersLayout:
//                self?.changeLayout(to: .stretchyHeaderLayout)
//            case .circularLayout:
//                self?.changeLayout(to: .pinterestLayout)
//            }
//        }
    }
}

extension CollectionViewController {
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let cells = collectionView.visibleCells as? [SlantedCollectionViewCell] else { return }
        let bounds = collectionView.bounds
        for cell in cells {
            cell.updateParallaxOffset(collectionView: bounds)
        }
    }
}


