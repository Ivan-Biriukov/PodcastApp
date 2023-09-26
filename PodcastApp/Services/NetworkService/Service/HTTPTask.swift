import Foundation

public typealias HTTPHeader = [String: String]

enum HTTPTask {
    case request
    case requestParameters(bodyParam: Parameters?, urlParam: Parameters?)
    case requestHeaderParam(bodyParam: Parameters?, urlParam: Parameters?, header: HTTPHeader?)
}
