//
//  StoryViewModel.swift
//  GujaratSamachar
//
//  Created by iMac on 14/07/23.
//

import Foundation
class StoryViewModel{
    
    var storyModel : StoryModel?
    var gplusStoryModel : GplusStoryModel?

    var arrTopStories : [Article] = [Article]()
    var arrTopSubStories : [Article] = [Article]()
    var arrCityNews : [Article] = [Article]()
    var arrMumbaiNews : [Article] = [Article]()
    var arrIndiaNews : [Article] = [Article]()
    var arrWorldNews : [Article] = [Article]()
    
    var action: (() -> Void)?
    
    func getData(pageNumber : Int){
        makeAPIRequestForNews(newsDataType: NewsDataType.topStories.rawValue, pageNumber: pageNumber)
        makeAPIRequestForNews(newsDataType: NewsDataType.topSubStories.rawValue, pageNumber: pageNumber)
        makeAPIRequestForNews(newsDataType: NewsDataType.cityNews.rawValue, pageNumber: pageNumber)
        makeAPIRequestForNews(newsDataType: NewsDataType.mumbaiNews.rawValue, pageNumber: pageNumber)
        makeAPIRequestForNews(newsDataType: NewsDataType.indiaNews.rawValue, pageNumber: pageNumber)
        makeAPIRequestForNews(newsDataType: NewsDataType.worldNews.rawValue, pageNumber: pageNumber)
    }
    
    func getDataForNewsType(pageNumber : Int, newsDataType : Int){
        if (newsDataType == NewsDataType.topStories.rawValue) {
            makeAPIRequestForNews(newsDataType: NewsDataType.topStories.rawValue, pageNumber: pageNumber)
        }else if (newsDataType == NewsDataType.topSubStories.rawValue) {
            makeAPIRequestForNews(newsDataType: NewsDataType.topSubStories.rawValue, pageNumber: pageNumber)
        }else if (newsDataType == NewsDataType.cityNews.rawValue) {
            makeAPIRequestForNews(newsDataType: NewsDataType.cityNews.rawValue, pageNumber: pageNumber)
        }else if (newsDataType == NewsDataType.mumbaiNews.rawValue) {
            makeAPIRequestForNews(newsDataType: NewsDataType.mumbaiNews.rawValue, pageNumber: pageNumber)
        }else if (newsDataType == NewsDataType.indiaNews.rawValue) {
            makeAPIRequestForNews(newsDataType: NewsDataType.indiaNews.rawValue, pageNumber: pageNumber)
        }else if (newsDataType == NewsDataType.worldNews.rawValue) {
            makeAPIRequestForNews(newsDataType: NewsDataType.worldNews.rawValue, pageNumber: pageNumber)
        }
    }
    
    func makeAPIRequestForNews(newsDataType : Int, pageNumber : Int){
        let apiURL : String = getAPIURL(newsDataType: newsDataType, pageNumber: pageNumber)
        
        if (newsDataType == NewsDataType.topStories.rawValue || newsDataType == NewsDataType.topSubStories.rawValue || newsDataType == NewsDataType.cityNews.rawValue || newsDataType == NewsDataType.mumbaiNews.rawValue || newsDataType == NewsDataType.indiaNews.rawValue || newsDataType == NewsDataType.worldNews.rawValue) {
            
            makeAPIRequestWithURL(apiURL: URL(string: apiURL)!) { [self] status, message in
                if status {
                    
                    if let storyData : StoryDataClass = storyModel?.data {
                     
                        if newsDataType == NewsDataType.topStories.rawValue {
                            storyModel = storyModel
                            
                            if let articles : [Article] = storyData.articles {
                                if pageNumber == 1 {
                                    arrTopStories = articles
                                }else{
                                    arrTopStories.append(contentsOf: articles)
                                }
                            }

                        }
                        else if newsDataType == NewsDataType.topSubStories.rawValue {
                            storyModel = storyModel
                            if let articles : [Article] = storyData.articles {
                                if pageNumber == 1 {
                                    arrTopSubStories = articles
                                }else{
                                    arrTopSubStories.append(contentsOf: articles)
                                }
                            }

                        }else if newsDataType == NewsDataType.cityNews.rawValue {
                            storyModel = storyModel
                            if let articles : [Article] = storyData.articles {
                                if pageNumber == 1 {
                                    arrCityNews = articles
                                }else{
                                    arrCityNews.append(contentsOf: articles)
                                }
                            }
                            
                        }else if newsDataType == NewsDataType.mumbaiNews.rawValue {
                            storyModel = storyModel
                            if let articles : [Article] = storyData.articles {
                                if pageNumber == 1 {
                                    arrMumbaiNews = articles
                                }else{
                                    arrMumbaiNews.append(contentsOf: articles)
                                }
                            }

                        }else if newsDataType == NewsDataType.indiaNews.rawValue {
                            storyModel = storyModel
                            if let articles : [Article] = storyData.articles {
                                if pageNumber == 1 {
                                    arrIndiaNews = articles
                                }else{
                                    arrIndiaNews.append(contentsOf: articles)
                                }
                            }

                        }else if newsDataType == NewsDataType.worldNews.rawValue {
                            storyModel = storyModel
                            if let articles : [Article] = storyData.articles {
                                if pageNumber == 1 {
                                    arrWorldNews = articles
                                }else{
                                    arrWorldNews.append(contentsOf: articles)
                                }
                            }
                        }
                    }
                }
                self.action?()
            }
        }
    }
    
    func makeAPIRequestWithURL(apiURL : URL,completion: @escaping (_ status:Bool,_ message:String) -> Void) {
        let session = URLSession.shared
        
        // Create a data task
        let task = session.dataTask(with: apiURL) { (data, response, error) in
            // Check for any errors
            if let error = error {
                print("Error: \(error.localizedDescription)")
                completion(false,error.localizedDescription)
                return
            }
            
            // Check if a response was received
            guard let httpResponse = response as? HTTPURLResponse else {
                print("Invalid response")
                completion(false,"")
                return
            }
            
            // Check the status code
            if httpResponse.statusCode == 200 {
                // Parse and use the response data
                if let data = data {
                    // Process the data as needed
                    do {                        
                        let jsonDecoder = JSONDecoder()
                        if apiURL == URL(string: getAPIURL(newsDataType: 2, pageNumber: 1)) {
                            let finalData = try jsonDecoder.decode(GplusStoryModel.self, from: data)
                            self.gplusStoryModel = finalData
                        }else {
                            let finalData = try jsonDecoder.decode(StoryModel.self, from: data)
                            self.storyModel = finalData
                        }
                        completion(true,"")
                    } catch {
                        print("\(error.localizedDescription)")
                        completion(false,"")
                    }
                }
            } else {
                print("HTTP Error: \(httpResponse.statusCode)")
                completion(false,"")
            }
        }
        task.resume()
    }
}
