//
//  APIClasses.swift
//  GujaratSamachar
//
//  Created by Nand Parikh on 22/06/23.
//

import Foundation

struct StoryModel : Codable {
    let code : Int?
    let message : String?
    let data : StoryDataClass?

    enum CodingKeys: String, CodingKey {

        case code = "code"
        case message = "message"
        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        code = try values.decodeIfPresent(Int.self, forKey: .code)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        data = try values.decodeIfPresent(StoryDataClass.self, forKey: .data)
    }

}

struct StoryDataClass : Codable {
    let totalCount : Int?
    let articles : [Article]?
    let articlePerPage : Int?

    enum CodingKeys: String, CodingKey {

        case totalCount = "totalCount"
        case articles = "articles"
        case articlePerPage = "articlePerPage"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        totalCount = try values.decodeIfPresent(Int.self, forKey: .totalCount)
        articles = try values.decodeIfPresent([Article].self, forKey: .articles)
        articlePerPage = try values.decodeIfPresent(Int.self, forKey: .articlePerPage)
    }

}

struct Article : Codable {
    let _id : String?
    let categories : [String]?
    let articleImage : String?
    let heading : String?
    let subHeadingOne : String?
    let subHeadingTwo : String?
    let content : String?
    let metaKeywords : [MetaKeywords]?
    let metaTag : [MetaTag]?
    let reporter : String?
    let createdAt : String?
    let articleUrl : String?
    let publishScheduleTime : String?
    let categorySlug : String?
    let categoryName : String?
    let reporterName : String?

    enum CodingKeys: String, CodingKey {

        case _id = "_id"
        case categories = "categories"
        case articleImage = "articleImage"
        case heading = "heading"
        case subHeadingOne = "subHeadingOne"
        case subHeadingTwo = "subHeadingTwo"
        case content = "content"
        case metaKeywords = "metaKeywords"
        case metaTag = "metaTag"
        case reporter = "reporter"
        case createdAt = "createdAt"
        case articleUrl = "articleUrl"
        case publishScheduleTime = "publishScheduleTime"
        case categorySlug = "categorySlug"
        case categoryName = "categoryName"
        case reporterName = "reporterName"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        _id = try values.decodeIfPresent(String.self, forKey: ._id)
        categories = try values.decodeIfPresent([String].self, forKey: .categories)
        articleImage = try values.decodeIfPresent(String.self, forKey: .articleImage)
        heading = try values.decodeIfPresent(String.self, forKey: .heading)
        subHeadingOne = try values.decodeIfPresent(String.self, forKey: .subHeadingOne)
        subHeadingTwo = try values.decodeIfPresent(String.self, forKey: .subHeadingTwo)
        content = try values.decodeIfPresent(String.self, forKey: .content)
        metaKeywords = try values.decodeIfPresent([MetaKeywords].self, forKey: .metaKeywords)
        metaTag = try values.decodeIfPresent([MetaTag].self, forKey: .metaTag)
        reporter = try values.decodeIfPresent(String.self, forKey: .reporter)
        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
        articleUrl = try values.decodeIfPresent(String.self, forKey: .articleUrl)
        publishScheduleTime = try values.decodeIfPresent(String.self, forKey: .publishScheduleTime)
        categorySlug = try values.decodeIfPresent(String.self, forKey: .categorySlug)
        categoryName = try values.decodeIfPresent(String.self, forKey: .categoryName)
        reporterName = try values.decodeIfPresent(String.self, forKey: .reporterName)
    }

}
// MARK: - MetaKeywords
struct MetaKeywords : Codable {
    let name : String?

    enum CodingKeys: String, CodingKey {

        case name = "name"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decodeIfPresent(String.self, forKey: .name)
    }

}

// MARK: - MetaTag
struct MetaTag : Codable {
    let name : String?

    enum CodingKeys: String, CodingKey {

        case name = "name"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decodeIfPresent(String.self, forKey: .name)
    }
}
