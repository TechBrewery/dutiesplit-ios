//
//  NetworkSession.swift
//  DutieSplit
//


import RxSwift
import UIKit.UIApplication

/// Defines interface for URLSession that can be used within the application.
internal protocol NetworkSession {

    /// Sends the URLRequest to the network.
    ///
    /// - Parameter request: Request to be sent.
    /// - Returns: Single with received response.
    func send(request: URLRequest) -> Single<URLSessionDataTaskResponse>
}

/// - SeeAlso: NetworkSession
final class DefaultNetworkSession: NetworkSession {

    private let session: URLSession

    init(session: URLSession = .shared) {
        self.session = session
    }

    /// - SeeAlso: NetworkSession.send(request:)
    func send(request: URLRequest) -> Single<URLSessionDataTaskResponse> {
        return .create { [unowned self] single in
            let task = self.session.dataTask(with: request) { data, response, error in
                let response = URLSessionDataTaskResponse(
                    data: data,
                    response: response as? HTTPURLResponse,
                    error: error
                )
                DispatchQueue.main.async { UIApplication.shared.isNetworkActivityIndicatorVisible = false }
                single(.success(response))
            }
            DispatchQueue.main.async { UIApplication.shared.isNetworkActivityIndicatorVisible = true }
            task.resume()
            return Disposables.create() {
                task.cancel()
            }
        }
    }
}
