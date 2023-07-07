//
//  VideoAPIClasses.swift
//  GujaratSamachar
//
//  Created by Nand Parikh on 23/06/23.
//
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let article = try? JSONDecoder().decode(Article.self, from: jsonData)

import Foundation
struct Datum : Codable {
    let description : String?
    let videoUrl : String?
    let categoryName : String?
    let categorySlug : String?
    let metaKeywords : [MetaKeyword]?
    let _id : String?
    let title : String?
    let metaTitle : String?
    let videoThumb : String?
    let publishScheduleTime : String?
    let slug : String?
    let metaDescriptions : String?

    enum CodingKeys: String, CodingKey {

        case description = "description"
        case videoUrl = "videoUrl"
        case categoryName = "categoryName"
        case categorySlug = "categorySlug"
        case metaKeywords = "metaKeywords"
        case _id = "_id"
        case title = "title"
        case metaTitle = "metaTitle"
        case videoThumb = "videoThumb"
        case publishScheduleTime = "publishScheduleTime"
        case slug = "slug"
        case metaDescriptions = "metaDescriptions"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        videoUrl = try values.decodeIfPresent(String.self, forKey: .videoUrl)
        categoryName = try values.decodeIfPresent(String.self, forKey: .categoryName)
        categorySlug = try values.decodeIfPresent(String.self, forKey: .categorySlug)
        metaKeywords = try values.decodeIfPresent([MetaKeyword].self, forKey: .metaKeywords)
        _id = try values.decodeIfPresent(String.self, forKey: ._id)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        metaTitle = try values.decodeIfPresent(String.self, forKey: .metaTitle)
        videoThumb = try values.decodeIfPresent(String.self, forKey: .videoThumb)
        publishScheduleTime = try values.decodeIfPresent(String.self, forKey: .publishScheduleTime)
        slug = try values.decodeIfPresent(String.self, forKey: .slug)
        metaDescriptions = try values.decodeIfPresent(String.self, forKey: .metaDescriptions)
    }

}

struct VideoArticle : Codable {
    let message : String?
    let data : [Datum]?
    let code : Int?

    enum CodingKeys: String, CodingKey {

        case message = "message"
        case data = "data"
        case code = "code"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        data = try values.decodeIfPresent([Datum].self, forKey: .data)
        code = try values.decodeIfPresent(Int.self, forKey: .code)
    }

}

struct MetaKeyword : Codable {
    let _id : String?
    let name : String?

    enum CodingKeys: String, CodingKey {

        case _id = "_id"
        case name = "name"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        _id = try values.decodeIfPresent(String.self, forKey: ._id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
    }
}
