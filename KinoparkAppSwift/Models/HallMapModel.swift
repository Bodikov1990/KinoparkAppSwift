//
//  HallMapModel.swift
//  KinoparkAppSwift
//
//  Created by Kuat Bodikov on 22.04.2022.
//

import Foundation

// MARK: - HallMap
struct HallMap: Decodable {
    let name, hallMapDescription: String
    let width, height: Int
    let seats: [Seat]
}

// MARK: - Seat
struct Seat: Decodable {
    let id: Int
    let rowText, seatText: String
    let x, y, width, height: Int
    let status: Int
}
