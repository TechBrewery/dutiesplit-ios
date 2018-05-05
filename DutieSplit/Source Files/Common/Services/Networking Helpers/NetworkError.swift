//
//  NetworkError.swift
//  DutieSplit
//

/// Contains errors that can be thrown by `NetworkService`.
internal enum NetworkError: Error {
    
    case connectionError(Error)
    case responseParseError(Error)
    case unacceptableStatusCode(Int)
    case missingResponse
    case missingData
    case unauthorized
    case errorStatus(NetworkStatus)
    
    /// - SeeAlso: Error.description
    internal var description: String {
        #if ENV_DEVELOPMENT || ENV_STAGING
            switch self {
            case .connectionError(let error):
                return "Connection failure: \(error.localizedDescription)"
            case .responseParseError(let error):
                return "Failed to parse URL response: \(error.localizedDescription)"
            case .unacceptableStatusCode(let actual):
                return "Unacceptable status code: \(actual)"
            case .missingResponse, .missingData:
                return "Missing data"
            case .unauthorized:
                return Localizable.Error.sessionExpired
            case .errorStatus(let status):
                return status.message
            }
        #else
            switch self {
            case .errorStatus(let status):
                return status.message
            case .unauthorized:
                return Localizable.error.sessionExpired
            default:
                return Localizable.error.unknownErrorOccurred
            }
        #endif
    }
}
