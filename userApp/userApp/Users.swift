//
//  Users.swift
//  userApp
//
//  Created by Lucas Da Silva on 24/06/20.
//  Copyright © 2020 Lucas Da Silva. All rights reserved.
//

import Foundation

struct Company: Decodable {
    var name: String
}

struct Address: Decodable {
    var city: String
}

struct User: Decodable {
    var id: Int
    var name: String
    var username: String
    var website: String
    var address: Address
    var company: Company
}
