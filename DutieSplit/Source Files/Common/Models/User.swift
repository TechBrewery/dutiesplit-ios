//
//  User.swift
//  DutieSplit
//


internal struct User: Codable {
    let id: String
    let email: String
    let name: String
    let groupIDs: [String]

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case email
        case name
        case groupIDs = "groups"
    }
}
