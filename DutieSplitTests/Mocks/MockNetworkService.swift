//
//  MockNetworkService.swift
//  DutieSplitTests
//


@testable import DutieSplit
import RxSwift

internal final class MockNetworkService: DefaultNetworkService {
    
    static var mockedResponse: (json: String, statusCode: Int, error: Error?) = (json: "", statusCode: 400, error: nil)

    override func perform<Request>(request: Request) -> Observable<NetworkResponseResult<Request.Response>> where Request: NetworkRequest {
        let response = URLSessionDataTaskResponse(
            data: MockNetworkService.mockedResponse.json.data(using: .utf8)!,
            response: HTTPURLResponseWrapper(statusCode: MockNetworkService.mockedResponse.statusCode),
            error: MockNetworkService.mockedResponse.error
        )
        return parse(dataTaskResponse: response, for: request).asObservable()
    }
    
    static func jsonFrom(filename: String) -> String {
        let bundle = Bundle(for: self)
        let path = bundle.path(forResource: filename, ofType: "json")
        return try! String(contentsOfFile: path!)
    }
}
