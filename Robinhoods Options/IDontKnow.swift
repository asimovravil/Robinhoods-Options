//
//  AppServiceKok.swift
//  Cashens Language
//
//  Created by Ravil on 14.10.2023.
//

import Foundation

final class IDontKnow {
    
    static let userDefaults = UserDefaults.standard
    
    static var isOnboardingShowed: Bool {
        get {
            userDefaults.bool(forKey: "isOnboardingShowed")
        }
        set {
            userDefaults.set(newValue, forKey: "isOnboardingShowed")
        }
    }
    
    static var score: Int {
        get {
            userDefaults.integer(forKey: "score")
        }
        set {
            userDefaults.set(newValue, forKey: "score")
        }
    }

    static var url: String? {
        get {
            userDefaults.string(forKey: "url")
        }
        set {
            userDefaults.set(newValue, forKey: "url")
        }
    }
}
