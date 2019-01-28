//
//  API.swift
//  NetworkAppIOSClient
//
//  Created by Charlie Tuna on 2019-01-27.
//  Copyright © 2019 Charlie Tuna. All rights reserved.
//

import Foundation

fileprivate let defaultHeaders = ["Content-Type":"application/json"]
fileprivate let path = Path()

class API {
    struct Session: RequestType {
        typealias ResponseType = ResponseSession
        private let headers = defaultHeaders
        public let params: [String:Any]

        var data: RequestData {
            return RequestData(path: path.session,
                               method: .POST,
                               params: params,
                               headers: headers)
        }
    }

    struct SignUp: RequestType {
        typealias ResponseType = Player
        private let headers = defaultHeaders
        public let params: [String:Any]

        var data: RequestData {
            return RequestData(path: path.players,
                               method: .POST,
                               params: params,
                               headers: headers)
        }
    }

    struct ListenMatch: RequestType {
        typealias ResponseType = Game
        private let headers = defaultHeaders

        var data: RequestData {
            return RequestData(path: path.listen,
                               method: .GET,
                               headers: headers,
                               withAuth: true)
        }
    }

    struct RequestMatch: RequestType {
        typealias ResponseType = NoReply
        private let headers = defaultHeaders
        public let enemyId: String

        var data: RequestData {
            return RequestData(path: path.request_match(enemyId: enemyId),
                               method: .GET,
                               headers: headers,
                               withAuth: true)
        }
    }

    struct GameTouch: RequestType {
        typealias ResponseType = Game
        private let headers = defaultHeaders
        public let gameId: Int

        var data: RequestData {
            return RequestData(path: path.game_touch(gameId: gameId),
                               method: .POST,
                               headers: headers,
                               withAuth: true)
        }
    }

    struct LeaderBoard: RequestType {
        typealias ResponseType = [Player]
        private let headers = defaultHeaders

        var data: RequestData {
            return RequestData(path: path.leader_board,
                               method: .GET,
                               headers: headers)
        }
    }
}
