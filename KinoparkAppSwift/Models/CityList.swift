//
//  CityList.swift
//  KinoparkAppSwift
//
//  Created by Kuat Bodikov on 20.03.2022.

import Foundation

// MARK: - CityList
struct CityList: Codable {
    let total: Int?
    let perPage: Int?
    let currentPage: Int?
    let lastPage: Int?
    let currPageURL: String?
    let nextPageURL: String?
    let prevPageURL: String?
    let urlParams: URLParams?
    let data: [CitiesData]
    
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

// MARK: - CityData
struct CitiesData: Codable {
    let uuid: String
    let name: String?
    let code: String?
    let description: String?
    let sortOrder: Int?
    let location: String?
    
    enum CodingKeys: String, CodingKey {
        case uuid
        case name
        case code
        case description
        case sortOrder = "sort_order"
        case location
    }
}

// MARK: - CinemasModel
struct CinemasModel: Codable {
    let total: Int?
    let perPage: Int?
    let currentPage: Int?
    let lastPage: Int?
    let currPageURL: String?
    let nextPageURL: String?
    let prevPageURL: String?
    let urlParams: URLParams?
    let data: [CinemasData]
    
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

// MARK: - CinemasData
struct CinemasData: Codable {
    let uuid: String
    let name: String
    let code: String?
    let description: String?
    let sortOrder: Int?
    let isActive: Bool
    let address: String?
    let phones: [String]?
    let url: String?
    let longitude: Double?
    let latitude: Double?
    let city: CityData
    let images: Images?
    let features: [String]?
    let openingDate: String?
    let hall: Hall
    let shortName: String?
    
    enum CodingKeys: String, CodingKey {
        case uuid
        case name
        case code
        case description
        case sortOrder = "sort_order"
        case isActive = "is_active"
        case address
        case phones
        case url
        case longitude
        case latitude
        case city
        case images
        case features
        case openingDate = "opening_date"
        case hall
        case shortName = "short_name"
    }
}

struct CityData: Codable {
    let uuid: String?
    let name: String?
    let code: String?
    let description: String?
    let sortOrder: Int?
    let isActive: Bool
    let location: String?
    
    enum CodingKeys: String, CodingKey {
        case uuid
        case name
        case code
        case description
        case sortOrder = "sort_order"
        case isActive = "is_active"
        case location
    }

}

struct Hall: Codable {
    let count: Int?
    let seat_count: Int?
}

struct MoviesModel: Codable {
    let total: Int?
    let perPage: Int?
    let currentPage: Int?
    let lastPage: Int?
    let currPageURL: String?
    let nextPageURL: String?
    let prevPageURL: String?
    let urlParams: URLParams?
    let data: [MoviesData]
    
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

struct MoviesData: Codable {
    let movieUUID: String
    let movieName: String?
    let movieCode: String?
    let description: String?
    let sortOrder: Int?
    let isActive: Bool
    let releaseDate: String?
    let duration: Int?
    let actors: [String]?
    let directors: [String]?
    let countries: [String]?
    let genre: [String]
    let ageLimitationText: String?
    let trailerLink: String?
    let isNew: Bool
    let tmdbID: Int?
    let images: Images
    let format: [String]?
    let rating: [String]?
    
    enum CodingKeys: String, CodingKey {
        case movieUUID = "uuid"
        case movieName = "name"
        case movieCode = "code"
        case description = "description"
        case sortOrder = "sort_order"
        case isActive = "is_active"
        case releaseDate = "release_date"
        case duration, actors, directors, countries, genre
        case ageLimitationText = "age_limitation_text"
        case trailerLink = "trailer_link"
        case isNew = "is_new"
        case tmdbID = "tmdb_id"
        case images, format, rating
    }
}

// MARK: - SeancesModel
struct SeancesModel: Codable {
    let total: Int?
    let perPage: Int?
    let currentPage: Int?
    let lastPage: Int?
    let currPageURL: String?
    let nextPageURL: String?
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
struct SeancesData: Codable {
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
struct Discount: Codable {
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

struct HallMenu: Codable {
    let ancestorUUID: String?
    
    enum CodingKeys: String, CodingKey {
        case ancestorUUID = "ancestor_uuid"
    }
}

// MARK: - Images
struct Images: Codable {
    let vertical, horizontal: String?
}

struct URLParams: Codable {
    let timezone: String?
    let lang: String?
}
