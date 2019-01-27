//
//  Models.swift
//  NetworkAppIOSClient
//
//  Created by Charlie Tuna on 2019-01-27.
//  Copyright © 2019 Charlie Tuna. All rights reserved.
//

import Foundation

struct Player: Codable {
    let id: String
    let email: String
    let elo: Int
    let losses: Int
    let matches: Int
    let tournamentsPlayed: Int
    let tournamentsWon: Int
    let wins: Int
}

struct ResponseSession: Codable {
    let refresh_token: String
    let auth_token: String
}
