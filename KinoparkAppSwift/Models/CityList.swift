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
    let languauge: String?
    let isActive: Bool
    let cityName: String?
    let cinemaName: String?
    let hallName: String?
    let hallFormat: [String]?
    let hallMenu: HallMenu
    let movieName: String?
    let movieFormat: [String]?
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
}

struct HallMenu: Decodable {
    let ancestorUUID: String?
}

// MARK: - Images
struct Images: Decodable {
    let vertical, horizontal: String?
}

struct URLParams: Decodable {
    let timezone, lang: String?
}
