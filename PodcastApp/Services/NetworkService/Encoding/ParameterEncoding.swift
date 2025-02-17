import Foundation

typealias Parameters = [String: Any]

protocol ParameterEncoder {
 static func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws
}
