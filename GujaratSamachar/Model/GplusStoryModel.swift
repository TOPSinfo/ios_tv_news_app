//
//  GplusStoryModel.swift
//  GujaratSamachar
//
//  Created by iMac on 29/06/23.
//

import Foundation

// MARK: - Article
struct GplusStoryModel : Codable {
    let code : Int?
    let message : String?
    let data : GplusStoryDataClass?

    enum CodingKeys: String, CodingKey {

        case code = "code"
        case message = "message"
        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        code = try values.decodeIfPresent(Int.self, forKey: .code)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        data = try values.decodeIfPresent(GplusStoryDataClass.self, forKey: .data)
    }
}

// MARK: - DataClass
struct GplusStoryDataClass : Codable {
    let totalCount : Int?
    let documents : [GplusStoryDocument]?
    let magazinePerPage : Int?

    enum CodingKeys: String, CodingKey {

        case totalCount = "totalCount"
        case documents = "documents"
        case magazinePerPage = "magazinePerPage"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        totalCount = try values.decodeIfPresent(Int.self, forKey: .totalCount)
        documents = try values.decodeIfPresent([GplusStoryDocument].self, forKey: .documents)
        magazinePerPage = try values.decodeIfPresent(Int.self, forKey: .magazinePerPage)
    }
}

// MARK: - Document
struct GplusStoryDocument : Codable {
    let _id : String?
    let categories : [String]?
    let articleImage : String?
    let heading : String?
    let subHeadingOne : String?
    let subHeadingTwo : String?
    let content : String?
    let metaKeywords : [GplusStoryMetaKeyword]?
    let metaTag : [GplusMetaTag]?
    let reporter : String?
    let magazine : String?
    let createdAt : String?
    let lastModifiedAt : String?
    let articleUrl : String?
    let publishScheduleTime : String?
    let magazineSlug : String?
    let magazineName : String?
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
        case magazine = "magazine"
        case createdAt = "createdAt"
        case lastModifiedAt = "lastModifiedAt"
        case articleUrl = "articleUrl"
        case publishScheduleTime = "publishScheduleTime"
        case magazineSlug = "magazineSlug"
        case magazineName = "magazineName"
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
        metaKeywords = try values.decodeIfPresent([GplusStoryMetaKeyword].self, forKey: .metaKeywords)
        metaTag = try values.decodeIfPresent([GplusMetaTag].self, forKey: .metaTag)
        reporter = try values.decodeIfPresent(String.self, forKey: .reporter)
        magazine = try values.decodeIfPresent(String.self, forKey: .magazine)
        createdAt = try values.decodeIfPresent(String.self, forKey: .createdAt)
        lastModifiedAt = try values.decodeIfPresent(String.self, forKey: .lastModifiedAt)
        articleUrl = try values.decodeIfPresent(String.self, forKey: .articleUrl)
        publishScheduleTime = try values.decodeIfPresent(String.self, forKey: .publishScheduleTime)
        magazineSlug = try values.decodeIfPresent(String.self, forKey: .magazineSlug)
        magazineName = try values.decodeIfPresent(String.self, forKey: .magazineName)
        reporterName = try values.decodeIfPresent(String.self, forKey: .reporterName)
    }
}

// MARK: - MetaKeyword
struct GplusStoryMetaKeyword : Codable {
    let name : String?
    let _id : String?

    enum CodingKeys: String, CodingKey {

        case name = "name"
        case _id = "_id"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        _id = try values.decodeIfPresent(String.self, forKey: ._id)
    }
}

// MARK: - MetaTag
struct GplusMetaTag : Codable {
    let name : String?

    enum CodingKeys: String, CodingKey {

        case name = "name"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decodeIfPresent(String.self, forKey: .name)
    }
}
