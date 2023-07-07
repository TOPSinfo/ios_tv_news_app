//
//  AppUtils.swift
//  GujaratSamachar
//
//  Created by Nand Parikh on 22/06/23.
//

import Foundation
import UIKit


func getViewController(_ name: String, onStoryboard storyboardName: String) -> UIViewController
{
    let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
    return storyboard.instantiateViewController(withIdentifier: name)
}

enum CellType : Int, CaseIterable {
    case topStories
    case topSubStories
    case gPlusTopStories
    case cityNews
    case mumbaiNews
    case indiaNews
    case worldNews
}

enum NewsDataType : Int, CaseIterable {
    case topStories
    case topSubStories
    case gPlusTopStories
    case cityNews
    case mumbaiNews
    case indiaNews
    case worldNews
}

enum CellpaperType : Int, CaseIterable {
    case mainEdition
    case magazines
    case districtEdition
}

struct APPCONST{
    static let imageBaseURL = "https://static.gujaratsamachar.com/articles/articles_thumbs/"
    static let videoImageBaseURL = "https://videos.gujaratsamachar.com/"
    static let videoBaseURL = "https://videos.gujaratsamachar.com/"
}
struct APICall
{
    static let topStories = "https://www.gujaratsamachar.com/api/top-stories?isMobile=true&pageIndex="
    static let Articles = "https://www.gujaratsamachar.com/api/article-list?isMobile=true&pageIndex="
    static let gPlusStories = "https://www.gujaratsamachar.com/api/magazine/gujarat-samachar-plus?isMobile=true&pageIndex="
    static let ahdNewsList = "https://www.gujaratsamachar.com/api/article-list?Id=4&listType=city&slug=ahmedabad&isMobile=true&pageIndex="
    static let mumbaiNewsList = "https://www.gujaratsamachar.com/api/article-list?Id=6&listType=category&slug=mumbai&isMobile=true&pageIndex="
    static let indiaNewsList = "https://www.gujaratsamachar.com/api/article-list?Id=3&listType=category&slug=national&isMobile=true&pageIndex="
    static let worldNewsList = "https://www.gujaratsamachar.com/api/article-list?Id=4&listType=category&slug=international&isMobile=true&pageIndex="

    static let videoList = "https://www.gujaratsamachar.com/api/video-list"
    static let gEpaper = "https://epaperadmin.gujaratsamachar.com/ws/v1/home_page"
    static let gEpaperDetails = "https://epaperadmin.gujaratsamachar.com/ws/v1/detail_page"
    
//    static let cityList = "https://www.gujaratsamachar.com/api/get-documents/Cities?sortBy=position"
}

extension UIView {
    func setRadiusToView(cornerRadius : CGFloat){
        self.layer.cornerRadius = cornerRadius
        self.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner,.layerMinXMaxYCorner,.layerMaxXMaxYCorner]
        self.layer.masksToBounds = true
    }
    
    func setBorderToView(borderColor : UIColor, borderWidth : CGFloat){
        layer.borderColor = borderColor.cgColor
        layer.borderWidth = borderWidth
    }
    
}

