//
//  AppUtils.swift
//  GujaratSamachar
//
//  Created by Nand Parikh on 22/06/23.
//

import Foundation
import UIKit

// MARK: - Make API Request with URL
func makeAPIRequestWithURL(apiURL : URL,completion: @escaping (_ status:Bool,_ message:String,_ resultData: Data?) -> Void) {
    let session = URLSession.shared
    
    // Create a data task
    let task = session.dataTask(with: apiURL) { (data, response, error) in
        // Check for any errors
        if let error = error {
            print("Error: \(error.localizedDescription)")
            completion(false,error.localizedDescription,nil)
            return
        }
        
        // Check if a response was received
        guard let httpResponse = response as? HTTPURLResponse else {
            print("Invalid response")
            completion(false,"",nil)
            return
        }
        
        // Check the status code
        if httpResponse.statusCode == 200 {
            // Parse and use the response data
            if let data = data {
                // Process the data as needed
                do {
                    let jsonObject = try JSONSerialization.jsonObject(with: data,options: .mutableLeaves)
                    completion(true,"",data)
                } catch {
                    print("\(error.localizedDescription)")
                    completion(false,"",nil)
                }
            }
        } else {
            print("HTTP Error: \(httpResponse.statusCode)")
            completion(false,"",nil)
        }
    }
    task.resume()
}
