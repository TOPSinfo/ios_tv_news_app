//
//  HomeVC.swift
//  GujaratSamachar
//
//  Created by Nand Parikh on 22/06/23.
//

import UIKit

class HomeVC: UIViewController {

    @IBOutlet weak var homeDataTableView: UITableView!
    var arrTopStories : [Article] = [Article]()
    var arrTopSubStories : [Article] = [Article]()
    var arrGplusTopStories : [GplusStoryDocument] = [GplusStoryDocument]()
    var arrCityNews : [Article] = [Article]()
    var arrMumbaiNews : [Article] = [Article]()
    var arrIndiaNews : [Article] = [Article]()
    var arrWorldNews : [Article] = [Article]()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
        
        makeAPIRequestForNews(newsDataType: NewsDataType.topStories.rawValue, pageNumber: 1)
        makeAPIRequestForNews(newsDataType: NewsDataType.topSubStories.rawValue, pageNumber: 1)
        makeAPIRequestForNews(newsDataType: NewsDataType.gPlusTopStories.rawValue, pageNumber: 1)
        makeAPIRequestForNews(newsDataType: NewsDataType.cityNews.rawValue, pageNumber: 1)
        makeAPIRequestForNews(newsDataType: NewsDataType.mumbaiNews.rawValue, pageNumber: 1)
        makeAPIRequestForNews(newsDataType: NewsDataType.indiaNews.rawValue, pageNumber: 1)
        makeAPIRequestForNews(newsDataType: NewsDataType.worldNews.rawValue, pageNumber: 1)
    }
    
    func setUpTableView(){
        homeDataTableView.register(UINib(nibName: "NewsViewCell", bundle: nil), forCellReuseIdentifier: "NewsViewCell")
        homeDataTableView.estimatedRowHeight = 580
        homeDataTableView.rowHeight = UITableView.automaticDimension
        homeDataTableView.reloadData()
    }
}

extension HomeVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CellType.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell : NewsViewCell = tableView.dequeueReusableCell(withIdentifier: "NewsViewCell") as? NewsViewCell, let cellType = CellType(rawValue: indexPath.row) {
            cell.delegate = self
            switch cellType {
            case .topStories:
                cell.lblTitle.text = "TOP STORIES"
                cell.arrTopStories = self.arrTopStories
                cell.type = .topStories
                
                cell.btnShowMore.tag = indexPath.row
                cell.btnShowMore.addTarget(self, action: #selector(self.btnShowMoreClicked(_:)), for: .primaryActionTriggered)
                cell.clvStory.reloadData()
                return cell
            case .topSubStories:
                cell.lblTitle.text = "TOP SUB-STORIES"
                cell.arrTopSubStories = self.arrTopSubStories
                cell.type = .topSubStories
                
                cell.btnShowMore.tag = indexPath.row
                cell.btnShowMore.addTarget(self, action: #selector(self.btnShowMoreClicked(_:)), for: .primaryActionTriggered)
                cell.clvStory.reloadData()
                return cell
            case .gPlusTopStories:
                cell.lblTitle.text = "G PLUS TOP STORY"
                cell.arrGplusTopStories = self.arrGplusTopStories
                cell.type = .gPlusTopStories
                
                cell.btnShowMore.tag = indexPath.row
                cell.btnShowMore.addTarget(self, action: #selector(self.btnShowMoreClicked(_:)), for: .primaryActionTriggered)
                cell.clvStory.reloadData()
                return cell
            case .cityNews:
                cell.lblTitle.text = "AHMEDABAD"
                cell.arrCityNews = self.arrCityNews
                cell.type = .cityNews
                
                cell.btnShowMore.tag = indexPath.row
                cell.btnShowMore.addTarget(self, action: #selector(self.btnShowMoreClicked(_:)), for: .primaryActionTriggered)
                cell.clvStory.reloadData()
                return cell
            case .mumbaiNews:
                cell.lblTitle.text = "MUMBAI"
                cell.arrMumbaiNews = self.arrMumbaiNews
                cell.type = .mumbaiNews
                
                cell.btnShowMore.tag = indexPath.row
                cell.btnShowMore.addTarget(self, action: #selector(self.btnShowMoreClicked(_:)), for: .primaryActionTriggered)
                cell.clvStory.reloadData()
                return cell
            case .indiaNews:
                cell.lblTitle.text = "INDIA"
                cell.arrIndiaNews = self.arrIndiaNews
                cell.type = .indiaNews
                
                cell.btnShowMore.tag = indexPath.row
                cell.btnShowMore.addTarget(self, action: #selector(self.btnShowMoreClicked(_:)), for: .primaryActionTriggered)
                cell.clvStory.reloadData()
                return cell
            case .worldNews:
                cell.lblTitle.text = "WORLD"
                cell.arrWorldNews = self.arrWorldNews
                cell.type = .worldNews
                
                cell.btnShowMore.tag = indexPath.row
                cell.btnShowMore.addTarget(self, action: #selector(self.btnShowMoreClicked(_:)), for: .primaryActionTriggered)
                cell.clvStory.reloadData()
                return cell
            }
            
        }
        return UITableViewCell()
    }
    
    @objc func btnShowMoreClicked(sender: UIButton){
//    func btnShowMoreClicked(){
       //...
        print("show more index is \(sender.tag)")
    }
    
    func tableView(_ tableView: UITableView, canFocusRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    @objc func btnShowMoreClicked(_ sender:UIButton)
    {
        print("show more index is \(sender.tag)")
        
        if let showMoreNewsVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "ShowMoreNewsVC") as? ShowMoreNewsVC {
            
            switch sender.tag {
            case NewsDataType.topStories.rawValue:
                showMoreNewsVC.selectedNewsDataType = .topStories
            case NewsDataType.topSubStories.rawValue:
                showMoreNewsVC.selectedNewsDataType = .topSubStories
            case NewsDataType.gPlusTopStories.rawValue:
                showMoreNewsVC.selectedNewsDataType = .gPlusTopStories
            case NewsDataType.cityNews.rawValue:
                showMoreNewsVC.selectedNewsDataType = .cityNews
            case NewsDataType.mumbaiNews.rawValue:
                showMoreNewsVC.selectedNewsDataType = .mumbaiNews
            case NewsDataType.indiaNews.rawValue:
                showMoreNewsVC.selectedNewsDataType = .indiaNews
            case NewsDataType.worldNews.rawValue:
                showMoreNewsVC.selectedNewsDataType = .worldNews
            default:
                showMoreNewsVC.arrTopStories = self.arrTopStories
            }
            
            
            self.present(showMoreNewsVC, animated: true, completion: nil)
        }
    }

}

//API
extension HomeVC {
    func makeAPIRequestForNews(newsDataType : Int, pageNumber : Int) {
        // Create a URL object for the API endpoint
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
        guard let url = URL(string: strURL) else {
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
            
            // Check the status code
            if httpResponse.statusCode == 200 {
                // Parse and use the response data
                if let data = data {
                    // Process the data as needed
                    do {
                        let jsonObject = try JSONSerialization.jsonObject(with: data,options: .mutableLeaves)
                        //print("json object is \(jsonObject)")
                        
                        do {
                            if newsDataType == NewsDataType.topStories.rawValue {
                                let storyJson = try JSONDecoder().decode(StoryModel.self, from: data)
                                if pageNumber == 1 {
                                    arrTopStories = storyJson.data.articles
                                }else{
                                    arrTopStories.append(contentsOf: storyJson.data.articles)
                                }
                            }else if newsDataType == NewsDataType.topSubStories.rawValue {
                                let storyJson = try JSONDecoder().decode(StoryModel.self, from: data)
                                if pageNumber == 1 {
                                    arrTopSubStories = storyJson.data.articles
                                }else{
                                    arrTopSubStories.append(contentsOf: storyJson.data.articles)
                                }
                            }else if newsDataType == NewsDataType.gPlusTopStories.rawValue {
                                let gplusStory = try JSONDecoder().decode(GplusStoryModel.self, from: data)
                                if pageNumber == 1 {
                                    arrGplusTopStories = gplusStory.data.documents
                                }else{
                                    arrGplusTopStories.append(contentsOf: gplusStory.data.documents)
                                }
                            }else if newsDataType == NewsDataType.cityNews.rawValue {
                                let storyJson = try JSONDecoder().decode(StoryModel.self, from: data)
                                if pageNumber == 1 {
                                    arrCityNews = storyJson.data.articles
                                }else{
                                    arrCityNews.append(contentsOf: storyJson.data.articles)
                                }
                            }else if newsDataType == NewsDataType.mumbaiNews.rawValue {
                                let storyJson = try JSONDecoder().decode(StoryModel.self, from: data)
                                if pageNumber == 1 {
                                    arrMumbaiNews = storyJson.data.articles
                                }else{
                                    arrMumbaiNews.append(contentsOf: storyJson.data.articles)
                                }
                            }else if newsDataType == NewsDataType.indiaNews.rawValue {
                                let storyJson = try JSONDecoder().decode(StoryModel.self, from: data)
                                if pageNumber == 1 {
                                    arrIndiaNews = storyJson.data.articles
                                }else{
                                    arrIndiaNews.append(contentsOf: storyJson.data.articles)
                                }
                            }else if newsDataType == NewsDataType.worldNews.rawValue {
                                let storyJson = try JSONDecoder().decode(StoryModel.self, from: data)
                                if pageNumber == 1 {
                                    arrWorldNews = storyJson.data.articles
                                }else{
                                    arrWorldNews.append(contentsOf: storyJson.data.articles)
                                }
                            }
                            
                            DispatchQueue.main.async { [self] in
                                homeDataTableView.reloadData()
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
extension HomeVC: NewsViewCellDelegate {
    func didSelectItem(_ item: Article?, _ gplusItem: GplusStoryDocument?, _ cityItem: Article?, _ mumbaiItem: Article?, _ worldItem: Article?) {
        if let detailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "DetailsVC") as? DetailsVC {
            detailVC.selectedNews = item
            detailVC.selectedGplusNews = gplusItem
            detailVC.selectedCityNews = cityItem
            detailVC.selectedMumbaiNews = mumbaiItem
            self.present(detailVC, animated: true, completion: nil)
        }
    }
}
