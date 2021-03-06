//
//  Dispatcher.swift
//  NetworkAppIOSClient
//
//  Created by Charlie Tuna on 2019-01-27.
//  Copyright © 2019 Charlie Tuna. All rights reserved.
//

import Foundation

public struct URLSessionNetworkDispatcher: NetworkDispatcher {

    public static let instance = URLSessionNetworkDispatcher()
    private init() {}

    public func dispatch(request: RequestData, onSuccess: @escaping (Data) -> Void, onError: @escaping (Error) -> Void) {

        let dispatchGroup = DispatchGroup()

        guard let url = URL(string: request.path) else {
            onError(ConnError.invalidUrl)
            return
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue
        print(url)

        do {
            if let params = request.params {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: params, options: [])
                print(params)
            }
        } catch let error {
            onError(error)
            return
        }

        var headers: [String:String] = ["":""]
        if request.headers != nil {
            headers = request.headers!
        }

        if let additionalHeaders = request.additionalHeaders {
            headers = headers.merged(with: additionalHeaders)
        }

        dispatchGroup.enter()
        if request.withAuth {
            if let token = UserDefaults.standard.getAuthToken() {
                headers = headers.merged(with: ["Authorization":token])
                dispatchGroup.leave()
            } else {
                onError(ConnError.unauthorized)
                dispatchGroup.leave()
                return
            }
        } else {
            dispatchGroup.leave()
        }

        dispatchGroup.notify(queue: .main) {
            urlRequest.allHTTPHeaderFields = headers
            URLSession.shared.dataTask(with: urlRequest) {
                (data, response, error) in
                if let error = error {
                    onError(error)
                    return
                }
                guard let _data = data else {
                    onError(ConnError.noData)
                    return
                }
                if let httpResponse = response as? HTTPURLResponse {
                    switch httpResponse.statusCode {
                    case 200...299:
                        onSuccess(_data)
                        return
                    case 400...499:
                        onError(ConnError.unauthorized)
                        return
                    case 500...599:
                        onError(ConnError.badRequest)
                        return
                    default:
                        onError(ConnError.failure)
                        return
                    }
                } else {
                    print("Could not get http response")
                }
                }.resume()
        }
    }
}

public extension RequestType {
    public func execute(dispatcher: NetworkDispatcher = URLSessionNetworkDispatcher.instance,
                        onSuccess: @escaping (ResponseType) -> Void,
                        onError: @escaping (Error) -> Void) {

        dispatcher.dispatch(request: self.data,
                            onSuccess: { (responseData: Data) in
                                do {
                                    let jsonDecoder = JSONDecoder()
                                    let result = try jsonDecoder.decode(ResponseType.self, from: responseData)
                                    DispatchQueue.main.async {
                                        onSuccess(result)
                                    }
                                } catch let error {
                                    DispatchQueue.main.async {
                                        onError(error)
                                    }
                                }
        },
                            onError: { (error: Error) in
                                DispatchQueue.main.async {
                                    onError(error)
                                }
        })
    }
}
