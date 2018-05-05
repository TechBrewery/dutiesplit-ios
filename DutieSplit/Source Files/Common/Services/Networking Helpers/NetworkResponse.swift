//
//  NetworkResponse.swift
//  DutieSplit
//


import Foundation

/// An network response representation that has to be just decodable
internal protocol NetworkResponse: Decodable { }

/// Common empty response
internal struct EmptyResponse: NetworkResponse { }
