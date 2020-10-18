import UIKit

extension UIImageView {
    func loadImageFromURL(URL: URL) {
        let request = URLRequest(url: URL as URL)
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let imageData = data {
                DispatchQueue.main.async {
                    self.image = UIImage(data: imageData)
                }
            }
        }
        task.resume()
    }
}
