//
//  EpaperDetailsModel.swift
//  GujaratSamachar
//
//  Created by iMac on 04/07/23.
//

import Foundation

// MARK: - EpaperDetailsModel
struct EpaperDetailsModel: Codable {
    let flag: Bool
    let message: String
    let data: DataClass
}

// MARK: - DataClass
struct DataClass: Codable {
    let categories: [Category]
    let epaperID, epaperDate, categoryName: String
    let epaperImages: [EpaperImage]

    enum CodingKeys: String, CodingKey {
        case categories
        case epaperID = "epaper_id"
        case epaperDate = "epaper_date"
        case categoryName = "category_name"
        case epaperImages = "epaper_images"
    }
}

// MARK: - Category
struct Category: Codable {
    let categoryName, epaperID: String

    enum CodingKeys: String, CodingKey {
        case categoryName = "category_name"
        case epaperID = "epaper_id"
    }
}

// MARK: - EpaperImage
struct EpaperImage: Codable {
    let pageNumber: String
    let imageName, imageNameThumbnail: String

    enum CodingKeys: String, CodingKey {
        case pageNumber = "page_number"
        case imageName = "image_name"
        case imageNameThumbnail = "image_name_thumbnail"
    }
}
