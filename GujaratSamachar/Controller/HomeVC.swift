//
//  HomeVC.swift
//  GujaratSamachar
//
//  Created by Nand Parikh on 22/06/23.
//

import UIKit

class HomeVC: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var homeDataTableView: UITableView!
    
    // MARK: - Model and View Model Reference Variable
    var storyModel : StoryModel?
    var storyViewModel = StoryViewModel()
    
    var gPlusModel : GplusStoryModel?
    var gPlusViewModel = GplusStoryViewModel()
    
    // MARK: - Viewcontroller life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureControl()
    }
    
    // MARK: - Configure Control
    func configureControl() {
        setUpTableView()
        
        storyViewModel.getData(pageNumber: 1)
        storyViewModel.action = { [self] in
            reloadTBL()
        }
        
        gPlusViewModel.getData(pageNumber: 1)
        gPlusViewModel.action = {[self] in
            reloadTBL()
        }
    }
    
    // MARK: - Reload Table
    func reloadTBL(){
        DispatchQueue.main.async { [self] in
            homeDataTableView.reloadData()
        }
    }
    
    // MARK: - Setup TableView
    func setUpTableView(){
        homeDataTableView.register(UINib(nibName: "NewsViewCell", bundle: nil), forCellReuseIdentifier: "NewsViewCell")
        homeDataTableView.estimatedRowHeight = 580
        homeDataTableView.rowHeight = UITableView.automaticDimension
        homeDataTableView.reloadData()
    }
}

// MARK: - Tableview Delegate and Datasource Methods
extension HomeVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CellType.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell : NewsViewCell = tableView.dequeueReusableCell(withIdentifier: "NewsViewCell") as? NewsViewCell, let cellType = CellType(rawValue: indexPath.row) {
            cell.delegate = self
            switch cellType {
            case .topStories:
                cell.configureCell(title: "TOP STORIES", modelArray: storyViewModel.arrTopStories, type: .topStories)
                
                cell.btnShowMore.tag = indexPath.row
                cell.btnShowMore.addTarget(self, action: #selector(self.btnShowMoreClicked(_:)), for: .primaryActionTriggered)
                cell.clvStory.reloadData()
                return cell
            case .topSubStories:
                cell.configureCell(title: "TOP SUB-STORIES", modelArray: storyViewModel.arrTopSubStories, type: .topSubStories)
                
                cell.btnShowMore.tag = indexPath.row
                cell.btnShowMore.addTarget(self, action: #selector(self.btnShowMoreClicked(_:)), for: .primaryActionTriggered)
                cell.clvStory.reloadData()
                return cell
            case .gPlusTopStories:
                
                cell.configureCell(title: "G PLUS TOP STORY", modelArray: gPlusViewModel.arrGplusTopStories, type: .gPlusTopStories)
                
                cell.btnShowMore.tag = indexPath.row
                cell.btnShowMore.addTarget(self, action: #selector(self.btnShowMoreClicked(_:)), for: .primaryActionTriggered)
                cell.clvStory.reloadData()
                return cell
            case .cityNews:
                cell.configureCell(title: "AHMEDABAD", modelArray: storyViewModel.arrCityNews, type: .cityNews)
                
                cell.btnShowMore.tag = indexPath.row
                cell.btnShowMore.addTarget(self, action: #selector(self.btnShowMoreClicked(_:)), for: .primaryActionTriggered)
                cell.clvStory.reloadData()
                return cell
            case .mumbaiNews:
                cell.configureCell(title: "MUMBAI", modelArray: storyViewModel.arrMumbaiNews, type: .mumbaiNews)
                
                cell.btnShowMore.tag = indexPath.row
                cell.btnShowMore.addTarget(self, action: #selector(self.btnShowMoreClicked(_:)), for: .primaryActionTriggered)
                cell.clvStory.reloadData()
                return cell
            case .indiaNews:
                cell.configureCell(title: "INDIA", modelArray: storyViewModel.arrIndiaNews, type: .indiaNews)
                
                cell.btnShowMore.tag = indexPath.row
                cell.btnShowMore.addTarget(self, action: #selector(self.btnShowMoreClicked(_:)), for: .primaryActionTriggered)
                cell.clvStory.reloadData()
                return cell
            case .worldNews:
                cell.configureCell(title: "WORLD", modelArray: storyViewModel.arrWorldNews, type: .worldNews)
                
                cell.btnShowMore.tag = indexPath.row
                cell.btnShowMore.addTarget(self, action: #selector(self.btnShowMoreClicked(_:)), for: .primaryActionTriggered)
                cell.clvStory.reloadData()
                return cell
            }
            
        }
        return UITableViewCell()
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
                print("")
            }
            
            self.present(showMoreNewsVC, animated: true, completion: nil)
        }
    }
}

// MARK: - News View Cell Delegate
extension HomeVC: NewsViewCellDelegate {
    func didSelectItem(_ item: Article?, _ gplusItem: GplusStoryDocument?, _ cityItem: Article?, _ mumbaiItem: Article?, _ worldItem: Article?) {
        if let detailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "DetailsVC") as? DetailsVC {
            detailVC.selectedNews = item
            detailVC.selectedGplusNews = gplusItem
            detailVC.selectedCityNews = cityItem
            detailVC.selectedMumbaiNews = mumbaiItem
            detailVC.selectedWorldNews = worldItem
            self.present(detailVC, animated: true, completion: nil)
        }
    }
}
