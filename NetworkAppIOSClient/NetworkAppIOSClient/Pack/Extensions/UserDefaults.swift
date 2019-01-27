//
//  UserDefaults.swift
//  NetworkAppIOSClient
//
//  Created by Charlie Tuna on 2019-01-27.
//  Copyright © 2019 Charlie Tuna. All rights reserved.
//

import Foundation

extension UserDefaults {
    enum UserDefaultKeys: String {
        case email
        case appUserId
        case isLoggedIn
        case authToken
        case refreshToken
    }

    func setRefreshToken(token: String){
        set(token, forKey: UserDefaultKeys.refreshToken.rawValue)
    }

    func setAuthToken(token: String){
        set(token, forKey: UserDefaultKeys.authToken.rawValue)
    }

    func getRefreshToken() -> String? {
        return string(forKey: UserDefaultKeys.refreshToken.rawValue)
    }

    func getAuthToken() -> String? {
        return string(forKey: UserDefaultKeys.authToken.rawValue)
    }

    func setIsLoggedIn(_ bool: Bool) {
        set(bool, forKey: UserDefaultKeys.isLoggedIn.rawValue)
    }

    func setAppUserId(id: String) {
        set(id, forKey: UserDefaultKeys.appUserId.rawValue)
    }

    func setAppUserEmail(email: String){
        set(email, forKey: UserDefaultKeys.email.rawValue)
    }

    func getIsLoggedIn() -> Bool {
        return bool(forKey: UserDefaultKeys.isLoggedIn.rawValue)
    }

    func getAppUserId() -> String? {
        return string(forKey: UserDefaultKeys.appUserId.rawValue)
    }

    func getLoggedInUserEmail() -> String? {
        return string(forKey: UserDefaultKeys.email.rawValue)
    }

    func reset() {
        let domain = Bundle.main.bundleIdentifier!
        UserDefaults.standard.removePersistentDomain(forName: domain)
        UserDefaults.standard.synchronize()
        print(Array(UserDefaults.standard.dictionaryRepresentation().keys).count)
    }
}
