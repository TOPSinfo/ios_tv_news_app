//
//  NewsViewCell.swift
//  GujaratSamachar
//
//  Created by Nand Parikh on 22/06/23.
//

import UIKit
import SDWebImage

protocol NewsViewCellDelegate: AnyObject {
    func didSelectItem(_ item: Article?, _ gplusItem : GplusStoryDocument?, _ cityItem : Article?, _ mumbaiItem : Article?,  _ worldItem : Article?)
}

class NewsViewCell: UITableViewCell {

    // MARK: - IBOutlets
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var cnstStoryViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var clvStory: UICollectionView!
    @IBOutlet weak var btnShowMore: UIButton!
    
    // MARK: - Global Variable
    var type: CellType = .topStories
    var arrData : [Any] = [Any]()
    weak var delegate: NewsViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        clvStory.delegate = self
        clvStory.dataSource = self
        registerNibs()
    }
  
    func registerNibs(){
        clvStory.register(UINib(nibName: "TopStoriesCell", bundle: nil), forCellWithReuseIdentifier: "TopStoriesCell")
        clvStory.register(UINib(nibName: "ArticleCell", bundle: nil), forCellWithReuseIdentifier: "ArticleCell")
    }

    // MARK: - Configure Cell
    func configureCell<T>(title : String, modelArray: [T], type : CellType) {
        lblTitle.text = title
        arrData = modelArray
        self.type = type
    }
}

// MARK: - Collection Delegate and Datasource Methods
extension NewsViewCell :UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch type {
        case .topStories:
            if let cell: TopStoriesCell = collectionView.dequeueReusableCell(withReuseIdentifier: "TopStoriesCell", for: indexPath) as? TopStoriesCell {
                if let objTopStories : Article = self.arrData[indexPath.row] as? Article {
                    cell.configureCell(title: objTopStories.heading ?? "", imageURL: objTopStories.articleImage ?? "", type: type)
                    return cell
                }
            }
        case .topSubStories:
            if let cell: ArticleCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ArticleCell", for: indexPath) as? ArticleCell {
                if let objTopSubStories : Article = self.arrData[indexPath.row] as? Article {
                    cell.configureCell(title: objTopSubStories.heading ?? "", imageURL: objTopSubStories.articleImage ?? "", type: type)
                    return cell
                }
            }
        case .gPlusTopStories:
            if let cell: ArticleCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ArticleCell", for: indexPath) as? ArticleCell {
                
                if let objGPlusTopStories : GplusStoryDocument = self.arrData[indexPath.row] as? GplusStoryDocument {
                    cell.configureCell(title: objGPlusTopStories.heading ?? "", imageURL: objGPlusTopStories.articleImage ?? "", type: type)
                    return cell
                }
            }
        case .cityNews:
            if let cell: TopStoriesCell = collectionView.dequeueReusableCell(withReuseIdentifier: "TopStoriesCell", for: indexPath) as? TopStoriesCell {
                if let objCityNews : Article = self.arrData[indexPath.row] as? Article {
                    cell.configureCell(title: objCityNews.heading ?? "", imageURL: objCityNews.articleImage ?? "", type: type)
                    return cell
                }
            }
        case .mumbaiNews:
            if let cell: TopStoriesCell = collectionView.dequeueReusableCell(withReuseIdentifier: "TopStoriesCell", for: indexPath) as? TopStoriesCell {
                if let objMumbaiNews : Article = self.arrData[indexPath.row] as? Article {
                    cell.configureCell(title: objMumbaiNews.heading ?? "", imageURL: objMumbaiNews.articleImage ?? "", type: type)
                    return cell
                }
            }
        case .indiaNews:
            if let cell: TopStoriesCell = collectionView.dequeueReusableCell(withReuseIdentifier: "TopStoriesCell", for: indexPath) as? TopStoriesCell {
                if let objIndiaNews : Article = self.arrData[indexPath.row] as? Article {
                    cell.configureCell(title: objIndiaNews.heading ?? "", imageURL: objIndiaNews.articleImage ?? "", type: type)
                    return cell

                }
            }
        case .worldNews:
            if let cell: TopStoriesCell = collectionView.dequeueReusableCell(withReuseIdentifier: "TopStoriesCell", for: indexPath) as? TopStoriesCell {
                if let objWorldNews : Article = self.arrData[indexPath.row] as? Article {
                    cell.configureCell(title: objWorldNews.heading ?? "", imageURL: objWorldNews.articleImage ?? "", type: type)
                    return cell
                }
            }
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 500, height: 360)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        var selectedItem: Article?
        var selectedGplus: GplusStoryDocument?
        var selectedCityNews: Article?
        var selectedMumbaiNews: Article?
        var selectedIndiaNews: Article?
        var selectedWorldNews: Article?
        
        switch type {
        case .topStories:
            if indexPath.row < arrData.count {
                selectedItem = arrData[indexPath.row] as? Article
            }
        case .topSubStories:
            if indexPath.row < arrData.count {
                selectedItem = arrData[indexPath.row] as? Article
            }
        case .gPlusTopStories:
            if indexPath.row < arrData.count {
                selectedGplus = arrData[indexPath.row] as? GplusStoryDocument
            }
        case .cityNews:
            if indexPath.row < arrData.count {
                selectedCityNews = arrData[indexPath.row] as? Article
            }
        case .mumbaiNews:
            if indexPath.row < arrData.count {
                selectedMumbaiNews = arrData[indexPath.row] as? Article
            }
        case .indiaNews:
            if indexPath.row < arrData.count {
                selectedIndiaNews = arrData[indexPath.row] as? Article
            }
        case .worldNews:
            if indexPath.row < arrData.count {
                selectedWorldNews = arrData[indexPath.row] as? Article
            }
        }
        
        if let item = selectedItem {
            delegate?.didSelectItem(item, nil, nil, nil, nil)
        } else if let gplus = selectedGplus {
            delegate?.didSelectItem(nil, gplus, nil, nil, nil)
        }else if let cityItem = selectedCityNews {
            delegate?.didSelectItem(nil, nil, cityItem, nil, nil)
        }else if let mumbaiItem = selectedMumbaiNews {
            delegate?.didSelectItem(nil, nil, nil, mumbaiItem,nil)
        }else if let mumbaiItem = selectedIndiaNews {
            delegate?.didSelectItem(nil, nil, nil, mumbaiItem,nil)
        }
        else if let worldItem = selectedWorldNews {
            delegate?.didSelectItem(nil, nil, nil, nil,worldItem)
        }
        else {
            // Handle the case where both `selectedItem` and `selectedGplus` are `nil`
        }
    }
}

class YourViewController: UIViewController, NewsViewCellDelegate {
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
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsViewCell", for: indexPath) as! NewsViewCell
        cell.delegate = self
        return cell
    }
}
