//
//  LoginResponse.swift
//  DutieSplit
//


internal struct LoginResponse: NetworkResponse {
    let name: String
    let email: String
    let token: String
}

