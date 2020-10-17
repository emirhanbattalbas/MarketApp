import Foundation
import UIKit

extension UIViewController {
  
  func createDefaultAlert(title: String,
                          message:String,
                          okCallBack: (()->())? = nil,
                          cancelCallBack: (()->())? = nil) {
    
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    
    var action = UIAlertAction(title: "OK", style: .default, handler: nil)
    
    if okCallBack != nil{
      action = UIAlertAction(title: "OK", style: .default) { (action) in
        okCallBack?()
      }
    }
    
    if cancelCallBack != nil {
      let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
        cancelCallBack?()
      }
      alert.addAction(cancelAction)
    }
    
    alert.addAction(action)
    self.present(alert, animated: true, completion: nil)
  }
}
