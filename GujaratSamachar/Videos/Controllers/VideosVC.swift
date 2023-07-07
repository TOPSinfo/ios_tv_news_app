//
//  VideosVC.swift
//  GujaratSamachar
//
//  Created by Nand Parikh on 23/06/23.
//

import UIKit

class VideosVC: UIViewController,VideoTableViewCellDelegate {

    // MARK: - IBOutlets
    @IBOutlet weak var tblVideosViewList: UITableView!
    
    // MARK: - Global Variable
    var arrVideoLists : [Datum] = [Datum]()

    // MARK: - Viewcontroller life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
        makeAPIRequestForVideoList()
    }
    
    func setUpTableView(){
        tblVideosViewList.estimatedRowHeight = 540
        tblVideosViewList.rowHeight = UITableView.automaticDimension

        tblVideosViewList.register(UINib(nibName: "VideosViewCell", bundle: nil), forCellReuseIdentifier: "VideosViewCell")
        tblVideosViewList.reloadData()
    }
    
    func didSelectItem(videoURL: String, index: Int) {
        if let detailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "VideoDetailVC") as? VideoDetailVC {
            detailVC.videoURL = videoURL
            detailVC.videoData = self.arrVideoLists[index]
            //"https://videos.gujaratsamachar.com/video/video_1687506343749.mp4"
            self.present(detailVC, animated: true, completion: nil)
        }
    }
    
}

// MARK: - Tableview Delegate and Datasource Methods
extension VideosVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell : VideosViewCell = tableView.dequeueReusableCell(withIdentifier: "VideosViewCell") as? VideosViewCell{
            cell.delegate = self

            cell.arrVideoLists = self.arrVideoLists
            cell.clvVideos.reloadData()
            
            cell.tblHeight = self.tblVideosViewList.bounds.size.height
            
            cell.cnstVideosiewHeightConstraint.constant = self.tblVideosViewList.bounds.size.height

            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, canFocusRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
}


extension VideosVC {
    
    // MARK: - API Call
    func makeAPIRequestForVideoList() {
        
        // Create a URL object for the API endpoint
        guard let url = URL(string: APICall.videoList) else {
            print("Invalid URL")
            return
        }
        
        // Create a URLSession object
        let session = URLSession.shared
        
        // Create a data task
        let task = session.dataTask(with: url) { [self] (data, response, error) in
            // Check for any errors
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            
            // Check if a response was received
            guard let httpResponse = response as? HTTPURLResponse else {
                print("Invalid response")
                return
            }
            //https://gujaratsamachar.com/api/video-list
            
            // Check the status code
            if httpResponse.statusCode == 200 {
                // Parse and use the response data
                if let data = data {
                    // Process the data as needed
                    do {
                        if let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers),
                           let jsonData = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted) {
                            print(String(decoding: jsonData, as: UTF8.self))
                        } else {
                            print("json data malformed")
                        }
                        
                        do {
                            let storyVideoJson = try JSONDecoder().decode(VideoArticle.self, from: data)
                            arrVideoLists = storyVideoJson.data!
                            
                            DispatchQueue.main.async { [self] in
                                tblVideosViewList.reloadData()
                            }
                        } catch {
                            debugPrint(error)
                        }
                    } catch {
                        print("\(error.localizedDescription)")
                    }                    
                    
                }
            } else {
                print("HTTP Error: \(httpResponse.statusCode)")
            }
        }
        task.resume()
    }
}
