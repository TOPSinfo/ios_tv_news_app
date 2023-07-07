//
//  CityListModel.swift
//  GujaratSamachar
//
//  Created by iMac on 30/06/23.
//

import Foundation

// MARK: - Article
class CityNewsModel: Codable {
    let code: Int
    let message: String
    let data: CityNewsDataClass

    init(code: Int, message: String, data: CityNewsDataClass) {
        self.code = code
        self.message = message
        self.data = data
    }
}

// MARK: - DataClass
class CityNewsDataClass: Codable {
    let totalCount, documentsPerPage: Int
    let documents: [CityNewsDocument]

    init(totalCount: Int, documentsPerPage: Int, documents: [CityNewsDocument]) {
        self.totalCount = totalCount
        self.documentsPerPage = documentsPerPage
        self.documents = documents
    }
}

// MARK: - Document
class CityNewsDocument: Codable {
    let documentID, name: String
    let position: Int
    let slug: String
    let id: Int

    enum CodingKeys: String, CodingKey {
        case documentID = "_id"
        case name, position, slug
        case id = "Id"
    }

    init(documentID: String, name: String, position: Int, slug: String, id: Int) {
        self.documentID = documentID
        self.name = name
        self.position = position
        self.slug = slug
        self.id = id
    }
}
