//
//  VideoViewModel.swift
//  GujaratSamachar
//
//  Created by iMac on 14/07/23.
//

import Foundation
class EpaperListViewModel{
    var epaperListModel : EpaperListModel?
    
    var arrMainEditions : [Main_editions] = [Main_editions]()
    var arrMagazines : [Magazines] = [Magazines]()
    var arrDistrictEditions : [District_editions] = [District_editions]()
    
    var action: (() -> Void)?
    
    func getData(){
        makeAPIRequestToGetEpaper(apiURL: URL(string: APICall.gEpaper)!) { [self] status, message in
            if status {
                arrMainEditions = epaperListModel?.data?.main_editions ?? []
                arrMagazines = epaperListModel?.data?.magazines ?? []
                arrDistrictEditions = epaperListModel?.data?.district_editions ?? []
            }
            self.action?()
        }
    }
    
    func makeAPIRequestToGetEpaper(apiURL : URL,completion: @escaping (_ status:Bool,_ message:String) -> Void) {
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
                        let finalData = try JSONDecoder().decode(EpaperListModel.self, from: data)
                        self.epaperListModel = finalData
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
