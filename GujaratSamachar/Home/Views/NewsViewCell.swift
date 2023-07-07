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

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var cnstStoryViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var clvStory: UICollectionView!
    @IBOutlet weak var btnShowMore: UIButton!
    
    var type: CellType = .topStories
    
    var arrTopStories : [Article] = [Article]()
    var arrTopSubStories : [Article] = [Article]()
    var arrGplusTopStories : [GplusStoryDocument] = [GplusStoryDocument]()
    var arrCityNews : [Article] = [Article]()
    var arrMumbaiNews : [Article] = [Article]()
    var arrIndiaNews : [Article] = [Article]()
    var arrWorldNews : [Article] = [Article]()
        
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

}

extension NewsViewCell :UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch type {
        case .topStories:
            return arrTopStories.count
        case .topSubStories:
            return arrTopSubStories.count
        case .gPlusTopStories:
            return arrGplusTopStories.count
        case .cityNews:
            return arrCityNews.count
        case .mumbaiNews:
            return arrMumbaiNews.count
        case .indiaNews:
            return arrIndiaNews.count
        case .worldNews:
            return arrWorldNews.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch type {
        case .topStories:
//            print("Top-Stories")
            if let cell: TopStoriesCell = collectionView.dequeueReusableCell(withReuseIdentifier: "TopStoriesCell", for: indexPath) as? TopStoriesCell {                
                cell.lblTitle.text = self.arrTopStories[indexPath.row].heading
                cell.type = type

                let strImgUrl : String = self.arrTopStories[indexPath.row].articleImage
                let imgURL = String(format: "%@%@",APPCONST.imageBaseURL,strImgUrl)
                print("Top Story - imgUrl is \(imgURL)")
                cell.imgStory.sd_setImage(with: URL(string:  imgURL), placeholderImage: UIImage(named: "gs_default"))
                return cell
            }
        case .topSubStories:
//            print("Top Sub-Stories")
            if let cell: ArticleCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ArticleCell", for: indexPath) as? ArticleCell {
                cell.lblTitle.text = self.arrTopSubStories[indexPath.row].heading
                cell.type = type
                
                let strImgUrl : String = self.arrTopSubStories[indexPath.row].articleImage
                let imgURL = String(format: "%@%@",APPCONST.imageBaseURL,strImgUrl)
                cell.imgStory.sd_setImage(with: URL(string:  imgURL), placeholderImage: UIImage(named: "gs_default"))

                return cell
            }
        case .gPlusTopStories:
//            print("Top Sub-Stories")
            if let cell: ArticleCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ArticleCell", for: indexPath) as? ArticleCell {
                cell.lblTitle.text = self.arrGplusTopStories[indexPath.row].heading
                cell.type = type
                
                let strImgUrl : String = self.arrGplusTopStories[indexPath.row].articleImage
                let imgURL = String(format: "%@%@",APPCONST.imageBaseURL,strImgUrl)
                cell.imgStory.sd_setImage(with: URL(string:  imgURL), placeholderImage: UIImage(named: "gs_default"))

                return cell
            }
        case .cityNews:
            if let cell: TopStoriesCell = collectionView.dequeueReusableCell(withReuseIdentifier: "TopStoriesCell", for: indexPath) as? TopStoriesCell {
                cell.lblTitle.text = self.arrCityNews[indexPath.row].heading
                cell.type = type

                let strImgUrl : String = self.arrCityNews[indexPath.row].articleImage
                let imgURL = String(format: "%@%@",APPCONST.imageBaseURL,strImgUrl)
                print("Top Story - imgUrl is \(imgURL)")
                cell.imgStory.sd_setImage(with: URL(string:  imgURL), placeholderImage: UIImage(named: "gs_default"))
                return cell
            }
        case .mumbaiNews:
            if let cell: TopStoriesCell = collectionView.dequeueReusableCell(withReuseIdentifier: "TopStoriesCell", for: indexPath) as? TopStoriesCell {
                cell.lblTitle.text = self.arrMumbaiNews[indexPath.row].heading
                cell.type = type

                let strImgUrl : String = self.arrMumbaiNews[indexPath.row].articleImage
                let imgURL = String(format: "%@%@",APPCONST.imageBaseURL,strImgUrl)
                print("Top Story - imgUrl is \(imgURL)")
                cell.imgStory.sd_setImage(with: URL(string:  imgURL), placeholderImage: UIImage(named: "gs_default"))
                return cell
            }
        case .indiaNews:
            if let cell: TopStoriesCell = collectionView.dequeueReusableCell(withReuseIdentifier: "TopStoriesCell", for: indexPath) as? TopStoriesCell {
                cell.lblTitle.text = self.arrIndiaNews[indexPath.row].heading
                cell.type = type

                let strImgUrl : String = self.arrIndiaNews[indexPath.row].articleImage
                let imgURL = String(format: "%@%@",APPCONST.imageBaseURL,strImgUrl)
                print("Top Story - imgUrl is \(imgURL)")
                cell.imgStory.sd_setImage(with: URL(string:  imgURL), placeholderImage: UIImage(named: "gs_default"))
                return cell
            }
        case .worldNews:
            if let cell: TopStoriesCell = collectionView.dequeueReusableCell(withReuseIdentifier: "TopStoriesCell", for: indexPath) as? TopStoriesCell {
                cell.lblTitle.text = self.arrWorldNews[indexPath.row].heading
                cell.type = type

                let strImgUrl : String = self.arrWorldNews[indexPath.row].articleImage
                let imgURL = String(format: "%@%@",APPCONST.imageBaseURL,strImgUrl)
                print("Top Story - imgUrl is \(imgURL)")
                cell.imgStory.sd_setImage(with: URL(string:  imgURL), placeholderImage: UIImage(named: "gs_default"))
                return cell
            }
        }
        
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch type {
        case .topStories:
            return CGSize(width: 500, height: 360)
        case .topSubStories:
            return CGSize(width: 500, height: 360)
        case .gPlusTopStories:
            return CGSize(width: 500, height: 360)
        case .cityNews:
            return CGSize(width: 500, height: 360)
        case .mumbaiNews:
            return CGSize(width: 500, height: 360)
        case .indiaNews:
            return CGSize(width: 500, height: 360)
        case .worldNews:
            return CGSize(width: 500, height: 360)
        }
        
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
            if indexPath.row < arrTopStories.count {
                selectedItem = arrTopStories[indexPath.row]
            }
        case .topSubStories:
            if indexPath.row < arrTopSubStories.count {
                selectedItem = arrTopSubStories[indexPath.row]
            }
        case .gPlusTopStories:
            if indexPath.row < arrGplusTopStories.count {
                selectedGplus = arrGplusTopStories[indexPath.row]
            }
        case .cityNews:
            if indexPath.row < arrCityNews.count {
                selectedCityNews = arrCityNews[indexPath.row]
            }
        case .mumbaiNews:
            if indexPath.row < arrMumbaiNews.count {
                selectedMumbaiNews = arrMumbaiNews[indexPath.row]
            }
        case .indiaNews:
            if indexPath.row < arrIndiaNews.count {
                selectedIndiaNews = arrIndiaNews[indexPath.row]
            }
        case .worldNews:
            if indexPath.row < arrWorldNews.count {
                selectedMumbaiNews = arrWorldNews[indexPath.row]
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
    
//    func didSelectItem(_ item: Article?, _ gplusItem: GplusStoryDocument?, _ cityItem: Article?, _ mumbaiItem: Article?) {
//        if let detailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "DetailsVC") as? DetailsVC {
//            detailVC.selectedNews = item
//            detailVC.selectedGplusNews = gplusItem
//            detailVC.selectedCityNews = cityItem
//            detailVC.selectedMumbaiNews = mumbaiItem
//            self.present(detailVC, animated: true, completion: nil)
//        }
//    }
    
//    func didSelectItem(_ item: Article?, _ gplusItem: GplusStoryDocument?, _ cityItem: Article?) {
//        if let detailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "DetailsVC") as? DetailsVC {
//            detailVC.selectedNews = item
//            detailVC.selectedGplusNews = gplusItem
//            detailVC.selectedCityNews = cityItem
//            self.present(detailVC, animated: true, completion: nil)
//        }
//    }
    
//    func didSelectItem(_ item: Article?, _ gplusItem: GplusStoryDocument?) {
//        if let detailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "DetailsVC") as? DetailsVC {
//            detailVC.selectedNews = item
//            detailVC.selectedGplusNews = gplusItem
//            self.present(detailVC, animated: true, completion: nil)
//        }
//    }
    
    
   
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsViewCell", for: indexPath) as! NewsViewCell
        cell.delegate = self
        return cell
    }
}
