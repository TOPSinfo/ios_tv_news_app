//
//  VideoViewModel.swift
//  GujaratSamachar
//
//  Created by iMac on 14/07/23.
//

import Foundation
class EpaperDetailViewModel{
    
    var epaperDetailsModel : EpaperDetailsModel?
    
    var arrEpaperDetails : [EpaperImage] = [EpaperImage]()
    
    var action: (() -> Void)?
    
    func getData(selectedDate : String, selectedEpaperID : String){
        
        makeAPIRequestToGetEpaperDetails(apiURL: URL(string: APICall.gEpaperDetails)!, selectedDate: selectedDate, selectedEpaperID: selectedEpaperID) { [self] status, message in
            if status {
                arrEpaperDetails = epaperDetailsModel?.data.epaperImages ?? []
            }
            self.action?()
        }
    }
    
    func makeAPIRequestToGetEpaperDetails(apiURL : URL,selectedDate : String, selectedEpaperID : String, completion: @escaping (_ status:Bool,_ message:String) -> Void) {
        let session = URLSession.shared
        
        var request = URLRequest(url: apiURL)
        request.httpMethod = "POST"
        
        // Create the parameter string in Form-Data format
        let parameters = "selected_date=\(selectedDate)&epaper_id=\(selectedEpaperID)"
        let formData = parameters.data(using: .utf8)
        
        // Set the content-type header for Form-Data
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        request.httpBody = formData
        
        
        // Create a data task
        let task = session.dataTask(with: request) { [self] (data, response, error) in
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
                        let finalData = try JSONDecoder().decode(EpaperDetailsModel.self, from: data)
                        self.epaperDetailsModel = finalData
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
