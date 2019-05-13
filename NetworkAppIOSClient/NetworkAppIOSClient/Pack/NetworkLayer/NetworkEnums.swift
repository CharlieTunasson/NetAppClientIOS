//
//  NetworkEnums.swift
//  NetworkAppIOSClient
//
//  Created by Charlie Tuna on 2019-01-27.
//  Copyright © 2019 Charlie Tuna. All rights reserved.
//

import Foundation

public typealias Parameters = [String:Any]

let baseUrl = "http://netappsmm.eu-north-1.elasticbeanstalk.com/"

public enum HTTPMethod : String {
    case GET = "GET"
    case POST = "POST"
    case PUT = "PUT"
    case DELETE = "DELETE"
}

public enum ConnError: Swift.Error {
    case invalidUrl
    case noData
    case unauthorized
    case badRequest
    case failure
    case noConnection
}

enum NetworkResponse: String {
    case success
    case authenticationError = "You need to be authenticated first."
    case badRequest = "Bad request"
    case outdated = "The url you requested is outdated."
    case failed = "Network request failed."
    case noData = "Response returned with no data to decode."
    case unableToDecode = "We could not decode the response."
}

struct Path {
    public let base = baseUrl
    public let session = "\(baseUrl)/session"
    public let players = "\(baseUrl)/players"
    public let listen = "\(baseUrl)/games/listen"
    public let leader_board = "\(baseUrl)/players/leaderboard"
    public let me_info = "\(baseUrl)/players/me"
    public func request_match(enemyId: String) -> String {
        return  "\(baseUrl)/games/request/\(enemyId)"
    }
    public func game_touch(gameId: Int) -> String {
        return  "\(baseUrl)/games/\(gameId)"
    }
}

public func configuredHeaders(additionalHeaders: [String:String]?, headers: [String:String]) -> [String:String] {
    if let _additionalHeaders = additionalHeaders {
        return headers.merged(with: _additionalHeaders)
    } else {
        return headers
    }
}

