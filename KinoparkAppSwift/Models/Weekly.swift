//
//  Weekly.swift
//  KinoparkAppSwift
//
//  Created by Kuat Bodikov on 25.05.2022.
//

import Foundation

enum Weekly: String, CaseIterable {
    case today = "Сегодня"
    case tomorrow = "Завтра"
    case day3
    case day4
    case day5
    
    func dates(day: Int, dateFormat: String) -> String {
        switch self {
        case .today:
            return rawValue
        case .tomorrow:
            return rawValue
        case .day3:
            return getDates(day: day, dateFormat: dateFormat)
        case .day4:
            return getDates(day: day, dateFormat: dateFormat)
        case .day5:
            return getDates(day: day, dateFormat: dateFormat)
        }
    }
    
    func getDates(day: Int, dateFormat: String) -> String {
        let today = Date()
        let modifiedDate = Calendar.current.date(byAdding: .day, value: day, to: today) ?? today
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat
        let dates = formatter.string(from: modifiedDate as Date)
        return dates
    }
}
