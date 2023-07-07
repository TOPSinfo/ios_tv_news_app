//
//  EpaperVC.swift
//  GujaratSamachar
//
//  Created by iMac on 30/06/23.
//

import UIKit


class EpaperVC: UIViewController {
    
    @IBOutlet weak var collViewPaper: UICollectionView!
    
    var arrMainEditions : [Main_editions] = [Main_editions]()
    var arrMagazines : [Magazines] = [Magazines]()
    var arrDistrictEditions : [District_editions] = [District_editions]()
    
    var paperType: CellpaperType = .mainEdition
    var strSelectedEpaperID = ""
    var strSelectedDate = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerNibs()
        getEpaper()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collViewPaper.reloadData()
    }
    
    func registerNibs(){
        collViewPaper.register(UINib(nibName: "EpaperViewCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "EpaperViewCollectionViewCell")
    }
    
    @IBAction func btnMainEditionsClicked(_ sender: Any) {
        paperType = .mainEdition
        collViewPaper.reloadData()
    }
    
    @IBAction func btnDistrictEditionsClicked(_ sender: Any) {
        paperType = .districtEdition
        collViewPaper.reloadData()
    }
    
    @IBAction func btnMagazinesClicked(_ sender: Any) {
        paperType = .magazines
        collViewPaper.reloadData()
    }
}


extension EpaperVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch paperType {
        case .mainEdition:
            return arrMainEditions.count
        case .magazines:
            return arrMagazines.count
        case .districtEdition:
            return arrDistrictEditions.count
        }
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
            cell.lblPaper.text = arrMainEditions[indexPath.row].category_name
            cell.lblPaperDate.text = arrMainEditions[indexPath.row].latest_epaper_date
            let strImgUrl = arrMainEditions[indexPath.row].image_name ?? ""
            cell.imgPaper.sd_setImage(with: URL(string: strImgUrl), placeholderImage: UIImage(named: "gs_default"))
        case .magazines:
            cell.lblPaper.text = arrMagazines[indexPath.row].category_name
            cell.lblPaperDate.text = arrMagazines[indexPath.row].latest_epaper_date
            let strImgUrl = arrMagazines[indexPath.row].image_name ?? ""
            cell.imgPaper.sd_setImage(with: URL(string: strImgUrl), placeholderImage: UIImage(named: "gs_default"))
        case .districtEdition:
            cell.lblPaper.text = arrDistrictEditions[indexPath.row].category_name
            cell.lblPaperDate.text = arrDistrictEditions[indexPath.row].latest_epaper_date
            let strImgUrl = arrDistrictEditions[indexPath.row].image_name ?? ""
            cell.imgPaper.sd_setImage(with: URL(string: strImgUrl), placeholderImage: UIImage(named: "gs_default"))
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
            strSelectedDate = arrMainEditions[indexPath.row].latest_epaper_date ?? ""
            strSelectedEpaperID = arrMainEditions[indexPath.row].epaper_id ?? ""
        case .magazines:
            strSelectedDate = arrMagazines[indexPath.row].latest_epaper_date ?? ""
            strSelectedEpaperID = arrMagazines[indexPath.row].epaper_id ?? ""
        case .districtEdition:
            strSelectedDate = arrDistrictEditions[indexPath.row].latest_epaper_date ?? ""
            strSelectedEpaperID = arrDistrictEditions[indexPath.row].epaper_id ?? ""
        }
        
        if let detailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "EpaperDetailsVC") as? EpaperDetailsVC {
            detailVC.strSelectedDate = strSelectedDate
            detailVC.strSelectedEpaperID = strSelectedEpaperID
            self.present(detailVC, animated: true, completion: nil)
        }
    }
    
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


extension EpaperVC {
    func getEpaper() {
        guard let url = URL(string: APICall.gEpaper) else {
            print("Invalid URL")
            return
        }
        
        let session = URLSession.shared
        let task = session.dataTask(with: url) { [self] (data, response, error) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                print("Invalid response")
                return
            }
            
            if httpResponse.statusCode == 200, let data = data {
                do {
                    let gplusStory = try JSONDecoder().decode(EpaperListModel.self, from: data)
                    arrMainEditions = gplusStory.data?.main_editions ?? []
                    arrMagazines = gplusStory.data?.magazines ?? []
                    arrDistrictEditions = gplusStory.data?.district_editions ?? []
                    
                    DispatchQueue.main.async { [self] in
                        collViewPaper.reloadData()
                    }
                } catch {
                    debugPrint(error)
                }
            } else {
                print("HTTP Error: \(httpResponse.statusCode)")
            }
        }
        task.resume()
    }
}
