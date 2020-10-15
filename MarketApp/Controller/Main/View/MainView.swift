import Foundation
import UIKit

final class MainView: UIView {
  
  @IBOutlet var collectionView: UICollectionView!
  
  func customizeCollectionView() {
    collectionView.register(cellType: ProductCell.self)
  }
}
