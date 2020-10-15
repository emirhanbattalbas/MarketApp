import Foundation

final class APIClient {
  
  typealias DataTaskResult = (Data?, URLResponse?, Error?) -> ()
  
  private var session: URLSession = URLSession.shared
  
  static var shared = APIClient()
  
  func request<T>(responseType: T.Type, router: Routable, completion: @escaping (APIResponse<T>) -> ()) where T: Decodable {
    
    let request = URLRequest(router: router)
    
    let task = session.dataTask(with: request, completionHandler: { [weak self] data, response, error in
      
      DispatchQueue.main.async {
        let httpResponse = response as? HTTPURLResponse
        self?.handleDataResponse(data: data, response: httpResponse, error: error, completion: completion)
      }
      
    })
    
    task.resume()
    
  }
  
  private func handleDataResponse<T: Decodable>(data: Data?, response: HTTPURLResponse?, error: Error?, completion: (APIResponse<T>) -> ()) {
    
    guard error == nil else { return completion(.failure(.unknown)) }
    guard let response = response else { return completion(.failure(.noJSONData)) }
    
    switch response.statusCode {
    case 200...299:
      guard let data = data else { return completion(.failure(.unknown)) }
      
      do {
        let baseResponse = try JSONDecoder().decode(T.self, from: data)
        
        completion(.success(baseResponse))
        
        
      } catch let error {
        return completion(.failure(.decodingError(error)))
      }
      
    default:
      completion(.failure(.unknown))
    }
  }
}
