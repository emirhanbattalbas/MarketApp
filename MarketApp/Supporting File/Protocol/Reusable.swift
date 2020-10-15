import Foundation
import UIKit

// MARK:- Reusable Protocol
protocol Reusable {
    static var reuseIdentifier: String { get }
    static var nib: UINib { get }
}

// MARK:- Reusable Extension
extension Reusable {
    static var reuseIdentifier: String { return String(describing: self) }
    static var nib: UINib {
        return UINib(nibName: String(describing: self), bundle: nil)
    }
}
