//
//  Models.swift
//  NetworkAppIOSClient
//
//  Created by Charlie Tuna on 2019-01-27.
//  Copyright © 2019 Charlie Tuna. All rights reserved.
//

import Foundation

struct Player: Codable {
    let id: String?
    let player_id: String?
    let email: String
    let elo: Int
    let losses: Int
    let matches: Int
    let tournamentsPlayed: Int
    let tournamentsWon: Int
    let wins: Int
}

struct Game: Codable {
    let player1: Player
    let player2: Player
    let result: Int?
    let startTime: String
    let endTime: String?
    let tournament: Int?
    let id: Int
}
struct NoReply: Codable {}

struct ResponseSession: Codable {
    let refresh_token: String
    let auth_token: String
}

struct LeaderBoard: Codable {
    let players: [Player]
}
