//
//  MTUserDefaults.swift
//  KinoparkAppSwift
//
//  Created by Kuat Bodikov on 13.05.2022.
//

import Foundation

struct MTUserDefaults {
    
    static var shared = MTUserDefaults()
    
    var theme: Theme {
        get {
            Theme(rawValue: UserDefaults.standard.integer(forKey: "selectedTheme")) ?? .device
        }
        set {
            UserDefaults.standard.set(newValue.rawValue, forKey: "selectedTheme")
        }
    }
}
