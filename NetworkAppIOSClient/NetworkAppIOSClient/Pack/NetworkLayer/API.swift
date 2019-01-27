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
        typealias ResponseType = Player
        private let headers = defaultHeaders
        public let params: [String:Any]

        var data: RequestData {
            return RequestData(path: path.listen,
                               method: .POST,
                               params: params,
                               headers: headers)
        }
    }
}
