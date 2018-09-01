//
//  URLSessionDataTaskResponse.swift
//  DutieSplit
//


/// Wrapper for default response of URLSessionDataTask
internal struct URLSessionDataTaskResponse {
    let data: Data?
    let response: HTTPURLResponse?
    let error: Error?
}
