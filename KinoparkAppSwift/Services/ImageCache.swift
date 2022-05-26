//
//  ImageCache.swift
//  KinoparkAppSwift
//
//  Created by Kuat Bodikov on 26.05.2022.
//

import UIKit

class ImageCache {
    static let shared = NSCache<NSString, UIImage>()
    
    private init() {}
}
