import Foundation
import UIKit

final class MainView: UIView {
  
  @IBOutlet var collectionView: UICollectionView!
  
  func registerCell() {
    collectionView.register(cellType: ProductCell.self)
  }
}
