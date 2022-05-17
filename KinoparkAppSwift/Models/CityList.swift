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

// MARK: - Datum
struct CityData: Decodable {
    let uuid, name, code, datumDescription: String?
    let sortOrder: Int?
    let location: String?
}

struct CinemasModel: Decodable {
    let total, perPage, currentPage, lastPage: Int?
    let currPageURL: String?
    let nextPageURL, prevPageURL: String?
    let urlParams: URLParams?
    let data: [CinemasData]?

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
struct CinemasData: Decodable {
    let uuid, name, code: String?
    let datumDescription: String?
    let sortOrder: Int?
    let isActive: Bool?
    let address: String?
    let phones: [String]?
    let url: String?
    let longitude, latitude: Double?
    let images: Images?
    let features: [String]?
    let openingDate: Date?
    let shortName: String?

    enum CodingKeys: String, CodingKey {
        case uuid, name, code
        case datumDescription = "description"
        case sortOrder = "sort_order"
        case isActive = "is_active"
        case address, phones, url, longitude, latitude, images, features
        case openingDate = "opening_date"
        case shortName = "short_name"
    }
}

// MARK: - Images
struct Images: Decodable {
    let vertical, horizontal: String?
}

struct URLParams: Decodable {
    let timezone, lang: String?
}

