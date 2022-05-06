//
//  CinemasModel.swift
//  KinoparkAppSwift
//
//  Created by Kuat Bodikov on 06.05.2022.
//

import Foundation

// MARK: - CinemasModel
struct CinemasModel: Decodable {
    let total, perPage, currentPage, lastPage: Int?
    let currPageURL: String?
    let nextPageURL, prevPageURL: String?
    let urlParams: URLParams?
    let data: [CinemasData]?
}

// MARK: - CinemasData
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
}

// MARK: - Images
struct Images: Decodable {
    let vertical, horizontal: String?
}

