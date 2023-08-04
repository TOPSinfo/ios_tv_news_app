//
//  AppUtils.swift
//  GujaratSamachar
//
//  Created by Nand Parikh on 22/06/23.
//

import Foundation
import UIKit

// MARK: - GET VIEW CONTROLLER
func getViewController(_ name: String, onStoryboard storyboardName: String) -> UIViewController
{
    let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
    return storyboard.instantiateViewController(withIdentifier: name)
}

// MARK: - HOME SCREEN NEWS TYPE
enum CellType : Int, CaseIterable {
    case topStories
    case topSubStories
    case gPlusTopStories
    case cityNews
    case mumbaiNews
    case indiaNews
    case worldNews
}

// MARK: - HOME SCREEN NEWS TYPE
enum NewsDataType : Int, CaseIterable {
    case topStories
    case topSubStories
    case gPlusTopStories
    case cityNews
    case mumbaiNews
    case indiaNews
    case worldNews
}

// MARK: - EPAPER TYPE
enum CellpaperType : Int, CaseIterable {
    case mainEdition
    case magazines
    case districtEdition
}

// MARK: - BASE_URL
struct APPCONST{
    static let imageBaseURL = "https://static.gujaratsamachar.com/articles/articles_thumbs/"
    static let videoImageBaseURL = "https://videos.gujaratsamachar.com/"
    static let videoBaseURL = "https://videos.gujaratsamachar.com/"
}

// MARK: - APICall
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
}

// MARK: - Extension UIView
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

// MARK: - String
extension String {
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return nil }
        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]
        return try? NSAttributedString(data: data, options: options, documentAttributes: nil)
    }
}

// MARK: - UIColor
extension UIColor {
    convenience init(hex: String) {
        var hexString = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if hexString.hasPrefix("#") {
            hexString.remove(at: hexString.startIndex)
        }

        var rgbValue: UInt64 = 0
        Scanner(string: hexString).scanHexInt64(&rgbValue)

        let red = CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgbValue & 0x0000FF) / 255.0

        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }
}

// MARK: - Get API URL
func getAPIURL(newsDataType : Int, pageNumber : Int) -> String{
    var strURL : String = ""
    switch newsDataType {
    case NewsDataType.topStories.rawValue:
        strURL = APICall.topStories + "\(pageNumber)"
    case NewsDataType.topSubStories.rawValue:
        strURL = APICall.Articles + "\(pageNumber)"
    case NewsDataType.gPlusTopStories.rawValue:
        strURL = APICall.gPlusStories + "\(pageNumber)"
    case NewsDataType.cityNews.rawValue:
        strURL = APICall.ahdNewsList + "\(pageNumber)"
    case NewsDataType.mumbaiNews.rawValue:
        strURL = APICall.mumbaiNewsList + "\(pageNumber)"
    case NewsDataType.indiaNews.rawValue:
        strURL = APICall.indiaNewsList + "\(pageNumber)"
    case NewsDataType.worldNews.rawValue:
        strURL = APICall.worldNewsList + "\(pageNumber)"
    default:
        strURL = ""
    }
    
    return strURL
}
