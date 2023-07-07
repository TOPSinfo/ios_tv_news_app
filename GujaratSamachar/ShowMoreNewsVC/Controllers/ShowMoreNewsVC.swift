//
//  ShowMoreNewsVC.swift
//  GujaratSamachar
//
//  Created by iMac on 06/07/23.
//

import UIKit

class ShowMoreNewsVC: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var clvShowMoreNews: UICollectionView!
    
    // MARK: - Global Variable
    var arrTopStories : [Article] = [Article]()
    var arrTopSubStories : [Article] = [Article]()
    var arrGplusTopStories : [GplusStoryDocument] = [GplusStoryDocument]()
    var arrCityNews : [Article] = [Article]()
    var arrMumbaiNews : [Article] = [Article]()
    var arrIndiaNews : [Article] = [Article]()
    var arrWorldNews : [Article] = [Article]()
    var selectedNewsDataType: NewsDataType = .topStories

    //Paggination
    var pageNumber: Int = 1
    var isPageRefreshing:Bool = false

    //FlowLayout
    let columnLayout = ColumnFlowLayout(
        cellsPerRow: 4,
        minimumInteritemSpacing: 10,
        minimumLineSpacing: 10,
        sectionInset: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    )
    
    // MARK: - Viewcontroller life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        registerNibs()
        makeAPIRequestForNews(newsDataType: selectedNewsDataType.rawValue, pageNumber: 1)
    }
    
    func registerNibs(){
        clvShowMoreNews?.collectionViewLayout = columnLayout
        clvShowMoreNews?.contentInsetAdjustmentBehavior = .always
        clvShowMoreNews.register(UINib(nibName: "ShowMoreNewsCell", bundle: nil), forCellWithReuseIdentifier: "ShowMoreNewsCell")
    }
}

// MARK: - Collection Delegate and Datasource Methods
extension ShowMoreNewsVC :UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch selectedNewsDataType {
        case .topStories:
            return self.arrTopStories.count
        case .topSubStories:
            return self.arrTopSubStories.count
        case .gPlusTopStories:
            return self.arrGplusTopStories.count
        case .cityNews:
            return self.arrCityNews.count
        case .mumbaiNews:
            return self.arrMumbaiNews.count
        case .indiaNews:
            return self.arrIndiaNews.count
        case .worldNews:
            return self.arrWorldNews.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell: ShowMoreNewsCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ShowMoreNewsCell", for: indexPath) as? ShowMoreNewsCell {
            
            switch selectedNewsDataType {
            case .topStories:
                cell.lblTitle.text = self.arrTopStories[indexPath.row].heading

                let strImgUrl : String = self.arrTopStories[indexPath.row].articleImage
                let imgURL = String(format: "%@%@",APPCONST.imageBaseURL,strImgUrl)
                print("Top Story - imgUrl is \(imgURL)")
                cell.imgStory.sd_setImage(with: URL(string:  imgURL), placeholderImage: UIImage(named: "gs_default"))
                cell.imgStory.contentMode = .scaleAspectFill
            
            case .topSubStories:
                cell.lblTitle.text = self.arrTopSubStories[indexPath.row].heading

                let strImgUrl : String = self.arrTopSubStories[indexPath.row].articleImage
                let imgURL = String(format: "%@%@",APPCONST.imageBaseURL,strImgUrl)
                print("Top Story - imgUrl is \(imgURL)")
                cell.imgStory.sd_setImage(with: URL(string:  imgURL), placeholderImage: UIImage(named: "gs_default"))
                cell.imgStory.contentMode = .scaleAspectFill
                
            case .gPlusTopStories:
                cell.lblTitle.text = self.arrGplusTopStories[indexPath.row].heading

                let strImgUrl : String = self.arrGplusTopStories[indexPath.row].articleImage
                let imgURL = String(format: "%@%@",APPCONST.imageBaseURL,strImgUrl)
                print("Top Story - imgUrl is \(imgURL)")
                cell.imgStory.sd_setImage(with: URL(string:  imgURL), placeholderImage: UIImage(named: "gs_default"))
                cell.imgStory.contentMode = .scaleAspectFill
                
                
            case .cityNews:
                cell.lblTitle.text = self.arrCityNews[indexPath.row].heading

                let strImgUrl : String = self.arrCityNews[indexPath.row].articleImage
                let imgURL = String(format: "%@%@",APPCONST.imageBaseURL,strImgUrl)
                print("Top Story - imgUrl is \(imgURL)")
                cell.imgStory.sd_setImage(with: URL(string:  imgURL), placeholderImage: UIImage(named: "gs_default"))
                cell.imgStory.contentMode = .scaleAspectFill
                
            case .mumbaiNews:
                cell.lblTitle.text = self.arrMumbaiNews[indexPath.row].heading

                let strImgUrl : String = self.arrMumbaiNews[indexPath.row].articleImage
                let imgURL = String(format: "%@%@",APPCONST.imageBaseURL,strImgUrl)
                print("Top Story - imgUrl is \(imgURL)")
                cell.imgStory.sd_setImage(with: URL(string:  imgURL), placeholderImage: UIImage(named: "gs_default"))
                cell.imgStory.contentMode = .scaleAspectFill
                
            case .indiaNews:
                cell.lblTitle.text = self.arrIndiaNews[indexPath.row].heading

                let strImgUrl : String = self.arrIndiaNews[indexPath.row].articleImage
                let imgURL = String(format: "%@%@",APPCONST.imageBaseURL,strImgUrl)
                print("Top Story - imgUrl is \(imgURL)")
                cell.imgStory.sd_setImage(with: URL(string:  imgURL), placeholderImage: UIImage(named: "gs_default"))
                cell.imgStory.contentMode = .scaleAspectFill
                
                
            case .worldNews:
                cell.lblTitle.text = self.arrWorldNews[indexPath.row].heading

                let strImgUrl : String = self.arrWorldNews[indexPath.row].articleImage
                let imgURL = String(format: "%@%@",APPCONST.imageBaseURL,strImgUrl)
                print("Top Story - imgUrl is \(imgURL)")
                cell.imgStory.sd_setImage(with: URL(string:  imgURL), placeholderImage: UIImage(named: "gs_default"))
                cell.imgStory.contentMode = .scaleAspectFill

            default:
                print("")
            }
            
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("selected index is \(indexPath.item)")
        
        
        var selectedItem: Article?
        var selectedGplus: GplusStoryDocument?
        var selectedCityNews: Article?
        var selectedMumbaiNews: Article?
        var selectedWorldNews: Article?
        
        if let detailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "DetailsVC") as? DetailsVC {
            
            switch selectedNewsDataType {
            case .topStories:
                selectedItem = self.arrTopStories[indexPath.row]
                detailVC.selectedNews = selectedItem
            case .topSubStories:
                selectedItem = self.arrTopSubStories[indexPath.row]
                detailVC.selectedNews = selectedItem
            case .gPlusTopStories:
                selectedGplus = self.arrGplusTopStories[indexPath.row]
                detailVC.selectedGplusNews = selectedGplus
            case .cityNews:
                selectedCityNews = self.arrCityNews[indexPath.row]
                detailVC.selectedCityNews = selectedCityNews
            case .mumbaiNews:
                selectedMumbaiNews = self.arrMumbaiNews[indexPath.row]
                detailVC.selectedMumbaiNews = selectedMumbaiNews
            case .indiaNews:
                print(1)

            case .worldNews:
                selectedWorldNews = self.arrWorldNews[indexPath.row]
                detailVC.selectedWorldNews = selectedWorldNews
            default:
                print("")
            }
            self.present(detailVC, animated: true, completion: nil)
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        clvShowMoreNews?.collectionViewLayout.invalidateLayout()
        super.viewWillTransition(to: size, with: coordinator)
    }
}

extension ShowMoreNewsVC {
    // MARK: - Scrollview Delegate Methods
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if(self.clvShowMoreNews.contentOffset.y >= (self.clvShowMoreNews.contentSize.height - self.clvShowMoreNews.bounds.size.height)) {
            if !isPageRefreshing {
                isPageRefreshing = true
                pageNumber = pageNumber + 1
                makeAPIRequestForNews(newsDataType: selectedNewsDataType.rawValue, pageNumber: pageNumber)
            }
        }
    }
}

// MARK: - UICollection FlowLayout
class ColumnFlowLayout: UICollectionViewFlowLayout {

    let cellsPerRow: Int

    init(cellsPerRow: Int, minimumInteritemSpacing: CGFloat = 0, minimumLineSpacing: CGFloat = 0, sectionInset: UIEdgeInsets = .zero) {
        self.cellsPerRow = cellsPerRow
        super.init()

        self.minimumInteritemSpacing = minimumInteritemSpacing
        self.minimumLineSpacing = minimumLineSpacing
        self.sectionInset = sectionInset
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepare() {
        super.prepare()

        guard let collectionView = collectionView else { return }
        let marginsAndInsets = sectionInset.left + sectionInset.right + collectionView.safeAreaInsets.left + collectionView.safeAreaInsets.right + minimumInteritemSpacing * CGFloat(cellsPerRow - 1)
        let itemWidth = ((collectionView.bounds.size.width - marginsAndInsets) / CGFloat(cellsPerRow)).rounded(.down)
        itemSize = CGSize(width: itemWidth, height: itemWidth)
    }

    override func invalidationContext(forBoundsChange newBounds: CGRect) -> UICollectionViewLayoutInvalidationContext {
        let context = super.invalidationContext(forBoundsChange: newBounds) as! UICollectionViewFlowLayoutInvalidationContext
        context.invalidateFlowLayoutDelegateMetrics = newBounds.size != collectionView?.bounds.size
        return context
    }
}

extension ShowMoreNewsVC {
    // MARK: - API Call
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
            isPageRefreshing = false
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
                                clvShowMoreNews.reloadData()
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
