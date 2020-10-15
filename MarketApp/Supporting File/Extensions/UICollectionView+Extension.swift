import Foundation
import UIKit

// MARK:- UICollectionView Extension

extension UICollectionView {
    
    final func register<T: UICollectionViewCell>(cellType: T.Type)
        where T:Reusable {
            self.register(cellType.nib, forCellWithReuseIdentifier: cellType.reuseIdentifier)
    }
    
    final func registerSupplementaryView<T: UICollectionViewCell>(cellType: T.Type)
        where T:Reusable {
            self.register(cellType.nib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: cellType.reuseIdentifier)
    }
    
    final func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath, cellType: T.Type = T.self) -> T
        where T: Reusable {
            guard let cell = self.dequeueReusableCell(withReuseIdentifier: cellType.reuseIdentifier, for: indexPath) as? T else {
                fatalError(
                    "Failed to dequeue a cell with identifier \(cellType.reuseIdentifier) matching type \(cellType.self). "
                        + "Check that the reuseIdentifier is set properly in your XIB/Storyboard "
                        + "and that you registered the cell beforehand"
                )
            }
            return cell
    }
    
    
    final func dequeueReusableSupplementaryView<T: UICollectionViewCell>(for indexPath: IndexPath, kind: String, cellType: T.Type = T.self) -> T
        where T: Reusable {
            guard let cell = self.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: cellType.reuseIdentifier, for: indexPath) as? T else {
                fatalError(
                    "Failed to dequeue a cell with identifier \(cellType.reuseIdentifier) matching type \(cellType.self). "
                        + "Check that the reuseIdentifier is set properly in your XIB/Storyboard "
                        + "and that you registered the cell beforehand"
                )
            }
            return cell
    }
}
