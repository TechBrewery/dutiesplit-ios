//
//  URLSessionDataTaskResponse.swift
//  DutieSplit
//


/// Wrapper for default response of URLSessionDataTask
internal struct URLSessionDataTaskResponse {
    let data: Data?
    let response: URLResponseWrapper?
    let error: Error?
}

/// Defines response with only status code as a body
internal struct URLResponseWrapper {
    let statusCode: Int
}
