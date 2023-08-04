//
//  StoryViewModel.swift
//  GujaratSamachar
//
//  Created by iMac on 14/07/23.
//

import Foundation
class GplusStoryViewModel{
    
    var gplusStoryModel : GplusStoryModel?
    var arrGplusTopStories : [GplusStoryDocument] = [GplusStoryDocument]()
    var action: (() -> Void)?

    func getData(pageNumber : Int){
        makeAPIRequestForNews(newsDataType: NewsDataType.gPlusTopStories.rawValue, pageNumber: pageNumber)
    }
    
    func getDataForNewsType(pageNumber : Int, newsDataType : Int){
        if (newsDataType == NewsDataType.gPlusTopStories.rawValue) {
            makeAPIRequestForNews(newsDataType: NewsDataType.gPlusTopStories.rawValue, pageNumber: pageNumber)
        }
    }
    
    func makeAPIRequestForNews(newsDataType : Int, pageNumber : Int){
        let apiURL : String = getAPIURL(newsDataType: newsDataType, pageNumber: pageNumber)
        if (newsDataType == NewsDataType.gPlusTopStories.rawValue){
            makeAPIRequestWithURL(apiURL: URL(string: apiURL)!) { [self] status, message  in
                if status {
                    if let gplusData : GplusStoryDataClass = gplusStoryModel?.data {

                        if newsDataType == NewsDataType.gPlusTopStories.rawValue {
                            gplusStoryModel = gplusStoryModel                            
                            if let docs : [GplusStoryDocument] = gplusData.documents {
                                
                                if pageNumber == 1 {
                                    arrGplusTopStories = docs
                                }else{
                                    arrGplusTopStories.append(contentsOf: docs)
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
                        let finalData = try jsonDecoder.decode(GplusStoryModel.self, from: data)
                        self.gplusStoryModel = finalData
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
