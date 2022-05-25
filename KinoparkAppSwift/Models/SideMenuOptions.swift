//
//  SideMenuOptions.swift
//  KinoparkAppSwift
//
//  Created by Kuat Bodikov on 24.05.2022.
//

import Foundation

enum SideMenuOptions: String, CaseIterable {
    case city = "Город"
    case language = "Язык"
    case faq = "Часто задаваемые вопросы"
    case rules = "Пользовательское соглашение"
    case confidence = "Политика конфиденциальности"
    case contacts = "Связаться с нами"
    case darkMode = "Режим"
    
    var imageName: String {
        switch self {
        case .city:
            return "mappin.and.ellipse"
        case .language:
            return "questionmark.circle"
        case .faq:
            return "questionmark.circle"
        case .rules:
            return "hand.raised.slash"
        case .confidence:
            return "list.dash.header.rectangle"
        case .contacts:
            return "envelope"
        case .darkMode:
            return "moon"
        }
    }
}
