import Foundation

typealias Parameters = [String : String]

protocol ParameterEncoder {
 static func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws
}
