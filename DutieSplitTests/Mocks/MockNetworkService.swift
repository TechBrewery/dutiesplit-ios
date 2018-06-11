//
//  MockNetworkService.swift
//  DutieSplitTests
//


@testable import DutieSplit
import RxSwift

internal final class MockNetworkService: DefaultNetworkService {
    
    static var mockedResponse: (json: String, statusCode: Int, error: Error?) = (json: "", statusCode: 400, error: nil)

    override func perform<Request>(request: Request) -> Observable<NetworkResponseResult<Request.Response>> where Request: NetworkRequest {
        return Observable<NetworkResponseResult<Request.Response>>.create { [unowned self] observer in
            let response = URLSessionDataTaskResponse(
                data: MockNetworkService.mockedResponse.json.data(using: .utf8)!,
                response: URLResponseWrapper(statusCode: MockNetworkService.mockedResponse.statusCode),
                error: MockNetworkService.mockedResponse.error
            )
            self.handle(dataTaskResponse: response, for: request, observer: observer)
            return Disposables.create()
        }
    }
    
    static func jsonFrom(filename: String) -> String {
        let bundle = Bundle(for: self)
        let path = bundle.path(forResource: filename, ofType: "json")
        return try! String(contentsOfFile: path!)
    }
}
