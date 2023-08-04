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
    
    // MARK: - Model and View Model Reference Variable
    var storyModel : StoryModel?
    var storyViewModel = StoryViewModel()
    
    var gPlusModel : GplusStoryModel?
    var gPlusViewModel = GplusStoryViewModel()
    
    
    // MARK: - Global Variable
    var arrData : [Any] = [Any]()
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
    
    // MARK: - Reload Collection View
    func reloadCLV(){
        DispatchQueue.main.async { [self] in
            clvShowMoreNews.reloadData()
        }
    }
    
    // MARK: - Viewcontroller life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureControl()
    }
    
    // MARK: - Configure Control
    func configureControl() {
        registerNibs()
        getData()
    }
    
    // MARK: - Get Data
    func getData(){
        if selectedNewsDataType.rawValue == NewsDataType.gPlusTopStories.rawValue {
            gPlusViewModel.getDataForNewsType(pageNumber: pageNumber, newsDataType: selectedNewsDataType.rawValue)
            gPlusViewModel.action = {[self] in
                if (selectedNewsDataType.rawValue == NewsDataType.gPlusTopStories.rawValue) {
                    self.arrData = gPlusViewModel.arrGplusTopStories
                }
                reloadCLV()
            }
        }else{
            storyViewModel.getDataForNewsType(pageNumber: pageNumber, newsDataType: selectedNewsDataType.rawValue)
            storyViewModel.action = { [self] in
                
                if (selectedNewsDataType.rawValue == NewsDataType.topStories.rawValue) {
                    self.arrData = storyViewModel.arrTopStories
                }else if (selectedNewsDataType.rawValue == NewsDataType.topSubStories.rawValue) {
                    self.arrData = storyViewModel.arrTopSubStories
                }else if (selectedNewsDataType.rawValue == NewsDataType.cityNews.rawValue) {
                    self.arrData = storyViewModel.arrCityNews
                }else if (selectedNewsDataType.rawValue == NewsDataType.mumbaiNews.rawValue) {
                    self.arrData = storyViewModel.arrMumbaiNews
                }else if (selectedNewsDataType.rawValue == NewsDataType.indiaNews.rawValue) {
                    self.arrData = storyViewModel.arrIndiaNews
                }else if (selectedNewsDataType.rawValue == NewsDataType.worldNews.rawValue) {
                    self.arrData = storyViewModel.arrWorldNews
                }
                reloadCLV()
            }
        }
    }
    
    // MARK: - Register Nibs
    func registerNibs(){
        clvShowMoreNews?.collectionViewLayout = columnLayout
        clvShowMoreNews?.contentInsetAdjustmentBehavior = .always
        clvShowMoreNews.register(UINib(nibName: "ShowMoreNewsCell", bundle: nil), forCellWithReuseIdentifier: "ShowMoreNewsCell")
    }
}

// MARK: - Collection Delegate and Datasource Methods
extension ShowMoreNewsVC :UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell: ShowMoreNewsCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ShowMoreNewsCell", for: indexPath) as? ShowMoreNewsCell {
            
            switch selectedNewsDataType {
            case .topStories:
                
                if let objTopStories : Article = self.arrData[indexPath.row] as? Article {
                    cell.configureCell(title: objTopStories.heading ?? "", modelArray: self.arrData, imageURL: objTopStories.articleImage ?? "", type: .topStories)
                    return cell
                }
                
            case .topSubStories:
                if let objTopSubStories : Article = self.arrData[indexPath.row] as? Article {
                    cell.configureCell(title: objTopSubStories.heading ?? "", modelArray: self.arrData, imageURL: objTopSubStories.articleImage ?? "", type: .topSubStories)
                    return cell
                }
                
            case .gPlusTopStories:
                
                if let objGplusStories : GplusStoryDocument = self.arrData[indexPath.row] as? GplusStoryDocument {
                    cell.configureCell(title: objGplusStories.heading ?? "", modelArray: self.arrData, imageURL: objGplusStories.articleImage ?? "", type: .gPlusTopStories)
                    return cell
                }
                
                
            case .cityNews:
                
                if let objCityNews : Article = self.arrData[indexPath.row] as? Article {
                    cell.configureCell(title: objCityNews.heading ?? "", modelArray: self.arrData, imageURL: objCityNews.articleImage ?? "", type: .cityNews)
                    return cell
                }
                
            case .mumbaiNews:
                
                if let objMumbaiNews : Article = self.arrData[indexPath.row] as? Article {
                    cell.configureCell(title: objMumbaiNews.heading ?? "", modelArray: self.arrData, imageURL: objMumbaiNews.articleImage ?? "", type: .mumbaiNews)
                    return cell
                }
                
            case .indiaNews:
                if let objIndiaNews : Article = self.arrData[indexPath.row] as? Article {
                    cell.configureCell(title: objIndiaNews.heading ?? "", modelArray: self.arrData, imageURL: objIndiaNews.articleImage ?? "", type: .indiaNews)
                    return cell
                }
                
                
            case .worldNews:
                if let objWorldNews : Article = self.arrData[indexPath.row] as? Article {
                    cell.configureCell(title: objWorldNews.heading ?? "", modelArray: self.arrData, imageURL: objWorldNews.articleImage ?? "", type: .worldNews)
                    return cell
                }
                
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
        var selectedIndia: Article?
        var selectedWorldNews: Article?
        
        if let detailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "DetailsVC") as? DetailsVC {
            
            switch selectedNewsDataType {
            case .topStories:
                selectedItem = arrData[indexPath.row] as? Article
                detailVC.selectedNews = selectedItem
            case .topSubStories:
                selectedItem = arrData[indexPath.row] as? Article
                detailVC.selectedNews = selectedItem
            case .gPlusTopStories:
                selectedGplus = arrData[indexPath.row] as? GplusStoryDocument
                detailVC.selectedGplusNews = selectedGplus
            case .cityNews:
                selectedCityNews = arrData[indexPath.row] as? Article
                detailVC.selectedCityNews = selectedCityNews
            case .mumbaiNews:
                selectedMumbaiNews = arrData[indexPath.row] as? Article
                detailVC.selectedMumbaiNews = selectedMumbaiNews
            case .indiaNews:
                selectedIndia = arrData[indexPath.row] as? Article
                detailVC.selectedIndiaNews = selectedIndia
            case .worldNews:
                selectedWorldNews = arrData[indexPath.row] as? Article
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
                pageNumber = pageNumber + 1
                getData()
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
