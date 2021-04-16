//
//  Authentication.swift
//  Swifty Companion
//
//  Created by Михаил Фокин on 26.01.2021.
//

import Foundation

final class Authentication {
    
    private enum DefaultsKey: String {
        case codeAuthorisation
        case isCodeAuthorisation
        case isAccessToken
        case accessToken
    }
    
    static var isCodeAuthorisation: Bool! {
        get {
            return UserDefaults.standard.bool(forKey: DefaultsKey.isCodeAuthorisation.rawValue)
        }
        set {
            let key = DefaultsKey.isCodeAuthorisation.rawValue
            if let isAut = newValue {
                UserDefaults.standard.set(isAut , forKey: key)
            } else {
                UserDefaults.standard.removeObject(forKey: key)
            }
        }
    }
    
    static var isAccessToken: Bool! {
        get {
            return UserDefaults.standard.bool(forKey: DefaultsKey.isAccessToken.rawValue)
        }
        set {
            let key = DefaultsKey.isAccessToken.rawValue
            if let isAut = newValue {
                UserDefaults.standard.set(isAut , forKey: key)
            } else {
                UserDefaults.standard.removeObject(forKey: key)
            }
        }
    }
    
    static var codeAuthorisation: String! {
        get {
            return UserDefaults.standard.string(forKey: DefaultsKey.codeAuthorisation.rawValue)
        }
        set {
            let key = DefaultsKey.codeAuthorisation.rawValue
            if let code = newValue {
                UserDefaults.standard.set(code , forKey: key)
            } else {
                UserDefaults.standard.removeObject(forKey: key)
            }
        }
    }
    
    static var accessToken: String! {
        get {
            return UserDefaults.standard.string(forKey: DefaultsKey.accessToken.rawValue)
        }
        set {
            let key = DefaultsKey.accessToken.rawValue
            if let accessToken = newValue {
                UserDefaults.standard.set(accessToken , forKey: key)
            } else {
                UserDefaults.standard.removeObject(forKey: key)
            }
        }
    }
}
