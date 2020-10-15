import Foundation

enum APIResponse<T: Codable> {
  case success(T)
  case failure(APIError)
}
