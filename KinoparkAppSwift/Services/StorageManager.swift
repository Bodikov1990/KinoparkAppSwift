//
//  StorageManager.swift
//  KinoparkAppSwift
//
//  Created by Kuat Bodikov on 14.04.2022.
//

import Foundation

class StorageManager {
    static let shared = StorageManager()
    
    private let userDefaults = UserDefaults.standard
    private let citiesKey = "city"
    
    private init() {}
    
    func save() {
        userDefaults.string(forKey: citiesKey)
    }
}
