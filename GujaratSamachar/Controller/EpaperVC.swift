//
//  EpaperVC.swift
//  GujaratSamachar
//
//  Created by iMac on 30/06/23.
//

import UIKit


class EpaperVC: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var collViewPaper: UICollectionView!
    
    // MARK: - Global Variable
    var paperType: CellpaperType = .mainEdition
    var strSelectedEpaperID = ""
    var strSelectedDate = ""
    
    // MARK: - Model and View Model Reference Variable
    var ePaperListModel : EpaperListModel?
    var ePaperListViewModel = EpaperListViewModel()
    
    var arrData : [Any] = [Any]()
    
    // MARK: - Viewcontroller life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureControl()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collViewPaper.reloadData()
    }
    
    // MARK: - Configure Control
    func configureControl() {
        registerNibs()
        
        //Get E-Papers and reload data
        ePaperListViewModel.getData()
        
        ePaperListViewModel.action = { [self] in
            arrData = ePaperListViewModel.arrMainEditions
            reloadClv()
        }
    }
    
    // MARK: - Reload Table
    func reloadClv(){
        DispatchQueue.main.async { [self] in
            collViewPaper.reloadData()
        }
    }
    
    func registerNibs(){
        collViewPaper.register(UINib(nibName: "EpaperViewCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "EpaperViewCollectionViewCell")
    }
    
    // MARK: - IBAction methods
    @IBAction func btnMainEditionsClicked(_ sender: Any) {
        paperType = .mainEdition
        arrData = ePaperListViewModel.arrMainEditions
        collViewPaper.reloadData()
    }
    
    @IBAction func btnDistrictEditionsClicked(_ sender: Any) {
        paperType = .districtEdition
        arrData = ePaperListViewModel.arrDistrictEditions
        collViewPaper.reloadData()
    }
    
    @IBAction func btnMagazinesClicked(_ sender: Any) {
        paperType = .magazines
        arrData = ePaperListViewModel.arrMagazines
        collViewPaper.reloadData()
    }
}

// MARK: - Collection Delegate and Datasource Methods
extension EpaperVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EpaperViewCollectionViewCell", for: indexPath) as? EpaperViewCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.layer.cornerRadius = 10
        cell.layer.borderWidth = 0.0
        cell.layer.borderColor = UIColor.clear.cgColor
        
        switch paperType {
        case .mainEdition:
            if let objMainEditions : Main_editions = self.arrData[indexPath.row] as? Main_editions {
                cell.configureCell(categoryName: objMainEditions.category_name ?? "", latestEpaperDate: objMainEditions.latest_epaper_date ?? "", imgName: objMainEditions.image_name ?? "")
            }
        case .magazines:
            if let objMagazines : Magazines = self.arrData[indexPath.row] as? Magazines {
                cell.configureCell(categoryName: objMagazines.category_name ?? "", latestEpaperDate: objMagazines.latest_epaper_date ?? "", imgName: objMagazines.image_name ?? "")
            }
        case .districtEdition:
            if let objDistrictEditions : District_editions = self.arrData[indexPath.row] as? District_editions {
                cell.configureCell(categoryName: objDistrictEditions.category_name ?? "", latestEpaperDate: objDistrictEditions.latest_epaper_date ?? "", imgName: objDistrictEditions.image_name ?? "")
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewWidth = collectionView.bounds.width
        let cellWidth = (collectionViewWidth - 40) / 3
        let cellHeight = cellWidth + 40
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch paperType {
        case .mainEdition:
            if let objMainEditions : Main_editions = self.arrData[indexPath.row] as? Main_editions {
                strSelectedDate = objMainEditions.latest_epaper_date ?? ""
                strSelectedEpaperID = objMainEditions.epaper_id ?? ""
            }
        case .magazines:
            if let objMagazines : Magazines = self.arrData[indexPath.row] as? Magazines {
                strSelectedDate = objMagazines.latest_epaper_date ?? ""
                strSelectedEpaperID = objMagazines.epaper_id ?? ""
            }
        case .districtEdition:
            if let objDistrictEditions : District_editions = self.arrData[indexPath.row] as? District_editions {
                strSelectedDate = objDistrictEditions.latest_epaper_date ?? ""
                strSelectedEpaperID = objDistrictEditions.epaper_id ?? ""
            }
        }
        
        if let detailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "EpaperDetailsVC") as? EpaperDetailsVC {
            detailVC.strSelectedDate = strSelectedDate
            detailVC.strSelectedEpaperID = strSelectedEpaperID
            self.present(detailVC, animated: true, completion: nil)
        }
    }
    
    // MARK: - Did Update Focus
    func collectionView(_ collectionView: UICollectionView, didUpdateFocusIn context: UICollectionViewFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        if let previousIndexPath = context.previouslyFocusedIndexPath {
            // Reset the border color of the previously focused cell
            if let previousCell = collectionView.cellForItem(at: previousIndexPath) {
                previousCell.layer.borderWidth = 0.0
                previousCell.layer.borderColor = UIColor.clear.cgColor
            }
        }
        
        if let nextIndexPath = context.nextFocusedIndexPath {
            // Customize the appearance of the focused cell
            if let nextCell = collectionView.cellForItem(at: nextIndexPath) {
                nextCell.layer.borderWidth = 5.0
                nextCell.layer.borderColor = UIColor.red.cgColor
            }
        }
    }
}
