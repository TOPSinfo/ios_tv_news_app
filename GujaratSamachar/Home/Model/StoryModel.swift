//
//  APIClasses.swift
//  GujaratSamachar
//
//  Created by Nand Parikh on 22/06/23.
//

import Foundation

// MARK: - StoryModel
class StoryModel: Codable {
    let code: Int
    let message: String
    let data: StoryDataClass

    init(code: Int, message: String, data: StoryDataClass) {
        self.code = code
        self.message = message
        self.data = data
    }
}

// MARK: - DataClass
class StoryDataClass: Codable {
    let totalCount: Int
    let articles: [Article]
    let articlePerPage: Int

    init(totalCount: Int, articles: [Article], articlePerPage: Int) {
        self.totalCount = totalCount
        self.articles = articles
        self.articlePerPage = articlePerPage
    }
}

// MARK: - Article
class Article: Codable {
    let id: String
    let categories: [String]
    let articleImage, heading, subHeadingOne, subHeadingTwo: String
    let content: String
    let metaKeywords, metaTag: [Meta]
    let reporter, createdAt, articleURL, publishScheduleTime: String
    let categorySlug, categoryName, reporterName: String

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case categories, articleImage, heading, subHeadingOne, subHeadingTwo, content, metaKeywords, metaTag, reporter, createdAt
        case articleURL = "articleUrl"
        case publishScheduleTime, categorySlug, categoryName, reporterName
    }

   
    init(id: String, categories: [String], articleImage: String, heading: String, subHeadingOne: String, subHeadingTwo: String, content: String, metaKeywords: [Meta], metaTag: [Meta], reporter: String, createdAt: String, articleURL: String, publishScheduleTime: String, categorySlug: String, categoryName: String, reporterName: String) {
        self.id = id
        self.categories = categories
        self.articleImage = articleImage
        self.heading = heading
        self.subHeadingOne = subHeadingOne
        self.subHeadingTwo = subHeadingTwo
        self.content = content
        self.metaKeywords = metaKeywords
        self.metaTag = metaTag
        self.reporter = reporter
        self.createdAt = createdAt
        self.articleURL = articleURL
        self.publishScheduleTime = publishScheduleTime
        self.categorySlug = categorySlug
        self.categoryName = categoryName
        self.reporterName = reporterName
    }
}

// MARK: - Meta
class Meta: Codable {
    let name: String
    let id: String?

    enum CodingKeys: String, CodingKey {
        case name
        case id = "_id"
    }

    init(name: String, id: String?) {
        self.name = name
        self.id = id
    }
}
