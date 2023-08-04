//
//  VideoViewModel.swift
//  GujaratSamachar
//
//  Created by iMac on 14/07/23.
//

import Foundation
class VideoViewModel{
    var videoArticleModel : VideoArticleModel?
    var arrVideoLists : [Datum] = [Datum]()
    var action: (() -> Void)?
    
    
    func getData(){
        makeAPIRequestForVideoList(apiURL: URL(string: APICall.videoList)!) { [self] status, message in
            if status {
                print("abcd")
                if let videoList : [Datum] = videoArticleModel?.data {
                    arrVideoLists = videoList
                }
            }
            self.action?()
        }
//        makeAPIRequestWithURL(apiURL: URL(string: APICall.videoList)!) { [self] status, message  in
//            if status {
//                if let docs : [Datum] = videoArticleModel?.data {
//                    arrVideoLists = docs
//                }
//
//            }
//            self.action?()
//        }
    }
    
    func makeAPIRequestForVideoList(apiURL : URL,completion: @escaping (_ status:Bool,_ message:String) -> Void) {
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
                        let finalData = try jsonDecoder.decode(VideoArticleModel.self, from: data)
                        self.videoArticleModel = finalData
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
