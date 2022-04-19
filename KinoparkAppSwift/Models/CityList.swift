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

// MARK: - URLParams
struct URLParams: Decodable {
    let timezone, lang: String?
}
