//
//  EpaperListModel.swift
//  Gujrat Samachar News
//
//  Created by iMac on 21/06/23.
//

import Foundation

struct EpaperListModel : Codable {
    let message : String?
    let flag : Bool?
    let data : epaperData?

    enum CodingKeys: String, CodingKey {

        case message = "message"
        case flag = "flag"
        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        flag = try values.decodeIfPresent(Bool.self, forKey: .flag)
        data = try values.decodeIfPresent(epaperData.self, forKey: .data)
    }

}
struct epaperData : Codable {
    let latest_date : String?
    let main_editions : [Main_editions]?
    let magazines : [Magazines]?
    let district_editions : [District_editions]?

    enum CodingKeys: String, CodingKey {

        case latest_date = "latest_date"
        case main_editions = "main_editions"
        case magazines = "magazines"
        case district_editions = "district_editions"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        latest_date = try values.decodeIfPresent(String.self, forKey: .latest_date)
        main_editions = try values.decodeIfPresent([Main_editions].self, forKey: .main_editions)
        magazines = try values.decodeIfPresent([Magazines].self, forKey: .magazines)
        district_editions = try values.decodeIfPresent([District_editions].self, forKey: .district_editions)
    }

}
struct Main_editions : Codable {
    let epaper_id : String?
    let latest_epaper_date : String?
    let image_name : String?
    let photo_video_category : String?
    let category_name : String?

    enum CodingKeys: String, CodingKey {

        case epaper_id = "epaper_id"
        case latest_epaper_date = "latest_epaper_date"
        case image_name = "image_name"
        case photo_video_category = "photo_video_category"
        case category_name = "category_name"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        epaper_id = try values.decodeIfPresent(String.self, forKey: .epaper_id)
        latest_epaper_date = try values.decodeIfPresent(String.self, forKey: .latest_epaper_date)
        image_name = try values.decodeIfPresent(String.self, forKey: .image_name)
        photo_video_category = try values.decodeIfPresent(String.self, forKey: .photo_video_category)
        category_name = try values.decodeIfPresent(String.self, forKey: .category_name)
    }

}
struct Magazines : Codable {
    let photo_video_category : String?
    let category_name : String?
    let epaper_id : String?
    let image_name : String?
    let latest_epaper_date : String?

    enum CodingKeys: String, CodingKey {

        case photo_video_category = "photo_video_category"
        case category_name = "category_name"
        case epaper_id = "epaper_id"
        case image_name = "image_name"
        case latest_epaper_date = "latest_epaper_date"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        photo_video_category = try values.decodeIfPresent(String.self, forKey: .photo_video_category)
        category_name = try values.decodeIfPresent(String.self, forKey: .category_name)
        epaper_id = try values.decodeIfPresent(String.self, forKey: .epaper_id)
        image_name = try values.decodeIfPresent(String.self, forKey: .image_name)
        latest_epaper_date = try values.decodeIfPresent(String.self, forKey: .latest_epaper_date)
    }

}
struct District_editions : Codable {
    let category_name : String?
    let latest_epaper_date : String?
    let epaper_id : String?
    let image_name : String?
    let photo_video_category : String?

    enum CodingKeys: String, CodingKey {

        case category_name = "category_name"
        case latest_epaper_date = "latest_epaper_date"
        case epaper_id = "epaper_id"
        case image_name = "image_name"
        case photo_video_category = "photo_video_category"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        category_name = try values.decodeIfPresent(String.self, forKey: .category_name)
        latest_epaper_date = try values.decodeIfPresent(String.self, forKey: .latest_epaper_date)
        epaper_id = try values.decodeIfPresent(String.self, forKey: .epaper_id)
        image_name = try values.decodeIfPresent(String.self, forKey: .image_name)
        photo_video_category = try values.decodeIfPresent(String.self, forKey: .photo_video_category)
    }
}
