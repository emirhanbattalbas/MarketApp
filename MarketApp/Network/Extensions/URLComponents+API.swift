import Foundation

extension URLComponents {
  
  init(router: Routable) {
    let url = router.baseURL.appendingPathComponent(router.path)
    self.init(url: url, resolvingAgainstBaseURL: false)!
    
    guard case let .parameters(parameters) = router.task, router.parametersEncoding == .url else { return }
    
    queryItems = parameters.map { key, value in
      return URLQueryItem(name: key, value: String(describing: value))
    }
  }
  
}
