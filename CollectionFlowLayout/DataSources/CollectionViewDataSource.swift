

import UIKit

class CollectionViewDataSource: NSObject, UICollectionViewDataSource {
    
    var layout:Layout?
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        guard let layout = layout else { return 1 }
        switch layout {
        case .stickyHeadersLayout:
            return 5
        default:
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let layout = layout else { return 0 }
        switch layout {
        case .stickyHeadersLayout:
            return 5
        default:
            return 15
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        var header = UICollectionReusableView()
        if let layout = layout {
            switch layout {
            case .stretchyHeaderLayout:
                header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: Indentifiers.imageHeaderIdentifier.rawValue, for: indexPath)
            case .stickyHeadersLayout:
                header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: Indentifiers.basicHeaderIdentifier.rawValue, for: indexPath)
            default:break
                
            }
        }
    
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = UICollectionViewCell()
        guard let layout = layout else { return cell }
        
        switch layout {
        case .stretchyHeaderLayout:
            cell = basicCell(collectionView, cellForItemAt: indexPath)
            cell.backgroundColor = generateRandomColor()
        case .pinterestLayout:
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: Indentifiers.pinterestCellIdentifier.rawValue, for: indexPath)
        case .stickyHeadersLayout:
            cell = basicCell(collectionView, cellForItemAt: indexPath)
            cell.backgroundColor = .black
        case .featuredCellLayout:
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: Indentifiers.featureCellIdentifier.rawValue, for: indexPath)
            cell.backgroundColor = generateRandomColor()
        case .slantedLayout:
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: Indentifiers.slantedCellIdentifier.rawValue, for: indexPath)
            cell.backgroundColor = .white
            (cell as! SlantedCollectionViewCell).updateParallaxOffset(collectionView: collectionView.bounds)
        case .circularLayout:
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: Indentifiers.circularCellIdentifier.rawValue, for: indexPath)
            cell.backgroundColor = generateRandomColor()
        }
        return cell
    }
    
    private func basicCell(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Indentifiers.basicCellIdentifier.rawValue, for: indexPath)
        return cell
    }
    
    private func generateRandomColor() -> UIColor {
        let red:CGFloat = CGFloat(Int.random(in: 1...245))/255
        let green:CGFloat = CGFloat(Int.random(in: 1...245))/255
        let blue:CGFloat = CGFloat(Int.random(in: 1...245))/255
        return UIColor.init(red: red, green: green, blue: blue, alpha: 1.0)
    }
}
