//
//  MockNetworkService.swift
//  DutieSplitTests
//


@testable import DutieSplit
import RxSwift

/// - SeeAlso: NetworkSession
final class MockNetworSession: NetworkSession {

    static var mockedResponse: (json: String, statusCode: Int, error: Error?) = (json: "", statusCode: 400, error: nil)

    static func jsonFrom(filename: String) -> String {
        let bundle = Bundle(for: self)
        let path = bundle.path(forResource: filename, ofType: "json")
        return try! String(contentsOfFile: path!)
    }

    /// - SeeAlso: NetworkSession.send(request:)
    func send(request: URLRequest) -> Single<URLSessionDataTaskResponse> {
        return .create { single in
            let response = URLSessionDataTaskResponse(
                data: MockNetworSession.mockedResponse.json.data(using: .utf8)!,
                response: HTTPURLResponse(
                    url: request.url!,
                    statusCode: MockNetworSession.mockedResponse.statusCode,
                    httpVersion: nil,
                    headerFields: nil
                ),
                error: MockNetworSession.mockedResponse.error
            )
            single(.success(response))
            return Disposables.create()
        }
    }
}
