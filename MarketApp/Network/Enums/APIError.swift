import Foundation

enum APIError {
  case unknown
  case decodingError(Error)
  case noJSONData
  //TODO: Will add more cases
}
