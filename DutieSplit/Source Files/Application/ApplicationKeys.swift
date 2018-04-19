//
//  ApplicationKeys.swift
//  DutieSplit
//


import Foundation

/// Common interface for securely providing keys
internal struct ApplicationKeys {
    
    /// The cocoapods-keys instance
    let keys: DutieSplitKeys

    /// The Hockey App app identifier
    internal var hockeyAppIdentifier: String {
        #if ENV_PRODUCTION
            return keys.beta_hockeyAppIdentifier
        #elseif ENV_STAGING || ENV_DEVELOPMENT
            return keys.staging_hockeyAppIdentifier
        #endif
    }
}
