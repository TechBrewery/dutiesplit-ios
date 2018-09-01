//
//  NetworkStatus.swift
//  DutieSplit
//


/// Container for parsing `NetworkStatus`.
internal struct NetworkStatusResponse: Decodable {
    
    /// Status of the response containing message from the backend.
    let status: NetworkStatus
}

/// Status passed from some endpoints in case of errors.
/// Useful for displaying received messages from the backend.
internal struct NetworkStatus: Decodable {
    
    /// Message passed by the backend.
    let message: String
}
