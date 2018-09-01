//
//  NetworkApplication.swift
//  DutieSplit
//


import Foundation

/// Defines scheme to be used for the network application
internal enum NetworkScheme: String {
    case HTTP = "http"
    case HTTPS = "https"
}

/// Defines interface for basic network application
internal protocol NetworkApplication {
    
    /// The scheme subcomponent of the URL.
    var scheme: NetworkScheme { get }
    
    /// The host subcomponent.
    var host: String { get }
    
    /// The root subcomponent.
    var root: String { get }
}

/// Staging Service
internal struct StagingNetworkApplication: NetworkApplication {
    let scheme: NetworkScheme = .HTTPS
    let host: String = "dutiesplit-staging.herokuapp.com"
    let root: String = "/api"
}

/// Production Service
internal struct ProductionNetworkApplication: NetworkApplication {
    let scheme: NetworkScheme = .HTTPS
    let host: String = "dutiesplit.herokuapp.com"
    let root: String = "/api"
}
