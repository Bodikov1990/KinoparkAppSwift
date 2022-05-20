//
//  CityList.swift
//  KinoparkAppSwift
//
//  Created by Kuat Bodikov on 20.03.2022.

import Foundation

// MARK: - CityList
struct CityList: Decodable {
    let total, perPage, currentPage, lastPage: Int?
    let currPageURL: String?
    let nextPageURL, prevPageURL: String?
    let urlParams: URLParams?
    let data: [CityData]?
}

// MARK: - CityData
struct CityData: Decodable {
    let uuid, name, code, datumDescription: String?
    let sortOrder: Int?
    let location: String?
}

// MARK: - CinemasModel
struct CinemasModel: Decodable {
    let total, perPage, currentPage, lastPage: Int?
    let currPageURL: String?
    let nextPageURL, prevPageURL: String?
    let urlParams: URLParams?
    let data: [CinemasData]
}

// MARK: - CinemasData
struct CinemasData: Decodable {
    let uuid: String
    let name: String
    let code: String?
    let datumDescription: String?
    let sortOrder: Int?
    let isActive: Bool
    let address: String?
    let phones: [String]?
    let url: String?
    let longitude, latitude: Double?
    let images: Images?
    let features: [String]?
    let openingDate: String?
    let shortName: String?
}

// MARK: - SeancesModel
struct SeancesModel: Decodable {
    let total, perPage, currentPage, lastPage: Int?
    let currPageURL, nextPageURL: String?
    let prevPageURL: String?
    let urlParams: URLParams?
    let data: [SeancesData]
    
    enum CodingKeys: String, CodingKey {
        case total
        case perPage = "per_page"
        case currentPage = "current_page"
        case lastPage = "last_page"
        case currPageURL = "curr_page_url"
        case nextPageURL = "next_page_url"
        case prevPageURL = "prev_page_url"
        case urlParams = "url_params"
        case data
    }
}

// MARK: - SeancesData
struct SeancesData: Decodable {
    let cityUUID: String?
    let cinemaUUID: String?
    let hallUUID: String?
    let movieUUID: String?
    let seanceUUID: String?
    let basePrice: Int?
    let startDate: String?
    let startTime: String?
    let endTime: String?
    let duration: Int?
    let sortOrder: Int?
    let discounts: [Discount]?
    let format: [String]?
    let language: String?
    let isActive: Bool
    let cityName: String?
    let cinemaName: String?
    let hallName: String?
    let hallFormat: [String]?
    let hallMenu: HallMenu
    let movieName: String?
    let movieFormat: [String]?
    
    enum CodingKeys: String, CodingKey {
        case cityUUID = "city_uuid"
        case cinemaUUID = "cinema_uuid"
        case hallUUID = "hall_uuid"
        case movieUUID = "movie_uuid"
        case seanceUUID = "seance_uuid"
        case basePrice = "base_price"
        case startDate = "start_date"
        case startTime = "start_time"
        case endTime = "end_time"
        case duration
        case sortOrder = "sort_order"
        case discounts, format, language
        case isActive = "is_active"
        case cityName = "city_name"
        case cinemaName = "cinema_name"
        case hallName = "hall_name"
        case hallFormat = "hall_format"
        case hallMenu = "hall_menu"
        case movieName = "movie_name"
        case movieFormat = "movie_format"
    }
}

// MARK: - Discount
struct Discount: Decodable {
    let uuid: String?
    let name: String?
    let code: String?
    let sortOrder: Int?
    let isActive, isShow: Bool
    let value: Int?
    let type: String?
    
    enum CodingKeys: String, CodingKey {
        case uuid, name, code
        case sortOrder = "sort_order"
        case isActive = "is_active"
        case isShow = "is_show"
        case value, type
    }
}

struct HallMenu: Decodable {
    let ancestorUUID: String?
    
    enum CodingKeys: String, CodingKey {
        case ancestorUUID = "ancestor_uuid"
    }
}

// MARK: - Images
struct Images: Decodable {
    let vertical, horizontal: String?
}

struct URLParams: Decodable {
    let timezone, lang: String?
}

/*
 // This file was generated from JSON Schema using quicktype, do not modify it directly.
 // To parse the JSON, add this file to your project and do:
 //
 //   let seancesModel = try? newJSONDecoder().decode(SeancesModel.self, from: jsonData)

 import Foundation

 // MARK: - SeancesModel
 struct SeancesModel: Codable {
     let total, perPage, currentPage, lastPage: Int?
     let currPageURL, nextPageURL: String?
     let prevPageURL: String?
     let urlParams: URLParams?
     let data: [Datum]?

     enum CodingKeys: String, CodingKey {
         case total
         case perPage = "per_page"
         case currentPage = "current_page"
         case lastPage = "last_page"
         case currPageURL = "curr_page_url"
         case nextPageURL = "next_page_url"
         case prevPageURL = "prev_page_url"
         case urlParams = "url_params"
         case data
     }
 }

 // MARK: - Datum
 struct Datum: Codable {
     let cityUUID, cinemaUUID, hallUUID, movieUUID: String?
     let seanceUUID: String?
     let basePrice: Int?
     let startDate, startTime, endTime: Date?
     let duration, sortOrder: Int?
     let discounts: [Discount]?
     let format: [String]?
     let language: Language?
     let isActive: Bool?
     let cityName: CityName?
     let cinemaName: CinemaName?
     let hallName: String?
     let hallFormat: [HallFormat]?
     let hallMenu: HallMenu?
     let movieName: String?
     let movieFormat: [String]?

     enum CodingKeys: String, CodingKey {
         case cityUUID = "city_uuid"
         case cinemaUUID = "cinema_uuid"
         case hallUUID = "hall_uuid"
         case movieUUID = "movie_uuid"
         case seanceUUID = "seance_uuid"
         case basePrice = "base_price"
         case startDate = "start_date"
         case startTime = "start_time"
         case endTime = "end_time"
         case duration
         case sortOrder = "sort_order"
         case discounts, format, language
         case isActive = "is_active"
         case cityName = "city_name"
         case cinemaName = "cinema_name"
         case hallName = "hall_name"
         case hallFormat = "hall_format"
         case hallMenu = "hall_menu"
         case movieName = "movie_name"
         case movieFormat = "movie_format"
     }
 }

 enum CinemaName: String, Codable {
     case kinopark7Keruencity = "Kinopark 7 Keruencity"
 }

 enum CityName: String, Codable {
     case актобе = "Актобе"
 }

 // MARK: - Discount
 struct Discount: Codable {
     let uuid: String?
     let name: Name?
     let code: Code?
     let sortOrder: Int?
     let isActive, isShow: Bool?
     let value: Int?
     let type: TypeEnum?

     enum CodingKeys: String, CodingKey {
         case uuid, name, code
         case sortOrder = "sort_order"
         case isActive = "is_active"
         case isShow = "is_show"
         case value, type
     }
 }

 enum Code: String, Codable {
     case detskij = "detskij"
     case pensionnyj = "pensionnyj"
     case studencheskij = "studencheskij"
 }

 enum Name: String, Codable {
     case детский = "Детский"
     case пенсионный = "Пенсионный"
     case студенческий = "Студенческий"
 }

 enum TypeEnum: String, Codable {
     case child = "child"
     case pension = "pension"
     case student = "student"
 }

 enum HallFormat: String, Codable {
     case comfort = "COMFORT"
     case standart = "STANDART"
 }

 // MARK: - HallMenu
 struct HallMenu: Codable {
     let ancestorUUID: String?

     enum CodingKeys: String, CodingKey {
         case ancestorUUID = "ancestor_uuid"
     }
 }

 enum Language: String, Codable {
     case kaz = "kaz"
     case rus = "rus"
 }

 // MARK: - URLParams
 struct URLParams: Codable {
     let timezone, lang: String?
 }

 */
