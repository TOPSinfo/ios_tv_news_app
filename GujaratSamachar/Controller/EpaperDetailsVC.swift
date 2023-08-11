//
//  EpaperDetailsVC.swift
//  GujaratSamachar
//
//  Created by iMac on 04/07/23.
//

import UIKit

class EpaperDetailsVC: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var collViewPaperDetail: UICollectionView!
    @IBOutlet weak var imgNewPaper: UIImageView!
    
    // MARK: - Global Variable
    var strSelectedDate = ""
    var strSelectedEpaperID = ""
    
    // Current scale and translation values
    var currentScale: CGFloat = 1.0
    var currentTranslation: CGPoint = .zero
    
    // Minimum and maximum zoom scale
    let minimumScale: CGFloat = 1.0
    let maximumScale: CGFloat = 5.0
    
    // Movement limitations
    let maximumTranslation: CGFloat = 100.0
    
    // MARK: - Model and View Model Reference Variable
    var ePaperDetailsModel : EpaperDetailsModel?
    var ePaperDetailViewModel = EpaperDetailViewModel()
    
    var arrData : [Any] = [Any]()
    
    // MARK: - Viewcontroller life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureControl()
    }
    
    // MARK: - Configure Control
    func configureControl() {
        registerNibs()
        ePaperDetailViewModel.getData(selectedDate: strSelectedDate, selectedEpaperID: strSelectedEpaperID)
        
        ePaperDetailViewModel.action = { [self] in
            arrData = ePaperDetailViewModel.arrEpaperDetails
            if arrData.count > 0 {
                if let objEpaperImage : EpaperImage = self.arrData.first as? EpaperImage {
                    imgNewPaper.sd_setImage(with: URL(string: objEpaperImage.imageName), placeholderImage: UIImage(named: "gs_default"))
                }
            }
            reloadClv()
        }
    }
    
    // MARK: - Reload Table
    func reloadClv(){
        DispatchQueue.main.async { [self] in
            collViewPaperDetail.reloadData()
        }
    }
    
    func registerNibs(){
        collViewPaperDetail.register(UINib(nibName: "EpaperDetailsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "EpaperDetailsCollectionViewCell")
    }
    
    // MARK: - IBAction methods
    @IBAction func btnZoomInClicked(_ sender: Any) {
        // Increase the zoom scale of the image view
        let newScale = currentScale * 1.1
        if newScale <= maximumScale {
            currentScale = newScale
            applyTransform(scale: currentScale, translation: currentTranslation)
        }
    }
    
    @IBAction func btnZoomOutClicked(_ sender: Any) {
        // Decrease the zoom scale of the image view
        let newScale = currentScale / 1.1
        if newScale >= minimumScale {
            currentScale = newScale
            applyTransform(scale: currentScale, translation: currentTranslation)
        }
    }
    
    @IBAction func btnUpClicked(_ sender: Any) {
        // Move the image view upwards
        let newTranslation = currentTranslation.y - 10
        if newTranslation >= -maximumTranslation {
            currentTranslation.y = newTranslation
            applyTransform(scale: currentScale, translation: currentTranslation)
        }
    }
    
    @IBAction func btnDownClicked(_ sender: Any) {
        // Move the image view downwards
        let newTranslation = currentTranslation.y + 10
        if newTranslation <= maximumTranslation {
            currentTranslation.y = newTranslation
            applyTransform(scale: currentScale, translation: currentTranslation)
        }
    }
    
    @IBAction func btnLeftClicked(_ sender: Any) {
        // Move the image view to the left
        let newTranslation = currentTranslation.x - 10
        if newTranslation >= -maximumTranslation {
            currentTranslation.x = newTranslation
            applyTransform(scale: currentScale, translation: currentTranslation)
        }
    }
    
    @IBAction func btnRightClicked(_ sender: Any) {
        // Move the image view to the right
        let newTranslation = currentTranslation.x + 10
        if newTranslation <= maximumTranslation {
            currentTranslation.x = newTranslation
            applyTransform(scale: currentScale, translation: currentTranslation)
        }
    }
    
    // Apply scale and translation to the image view
    func applyTransform(scale: CGFloat, translation: CGPoint) {
        let transform = CGAffineTransform(scaleX: scale, y: scale).translatedBy(x: translation.x, y: translation.y)
        imgNewPaper.transform = transform
    }
}

// MARK: - Collection Delegate and Datasource Methods
extension EpaperDetailsVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EpaperDetailsCollectionViewCell", for: indexPath) as? EpaperDetailsCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.layer.cornerRadius = 10
        cell.layer.borderWidth = 0.0
        cell.layer.borderColor = UIColor.clear.cgColor
        if let objEpaperImage : EpaperImage = self.arrData[indexPath.row] as? EpaperImage {
            cell.lblPageNumbers.text = "Page \(objEpaperImage.pageNumber)"
            let strImgUrl = objEpaperImage.imageNameThumbnail
            cell.imgPaper.sd_setImage(with: URL(string: strImgUrl), placeholderImage: UIImage(named: "gs_default"))
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewWidth = collectionView.bounds.width
        let spacing: CGFloat = 20
        let numberOfCells: CGFloat = 1
        let cellWidth = (collectionViewWidth - spacing * (numberOfCells - 1)) / numberOfCells
        let cellHeight = collectionView.bounds.height / 3.5
        
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // Handle item selection
        if let objEpaperImage : EpaperImage = self.arrData[indexPath.row] as? EpaperImage {
            let selectedImageName = objEpaperImage.imageName
            imgNewPaper.sd_setImage(with: URL(string: selectedImageName), placeholderImage: UIImage(named: "gs_default"))
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
                
                if let objEpaperImage : EpaperImage = self.arrData[nextIndexPath.row] as? EpaperImage {
                    let selectedImageName = objEpaperImage.imageName
                    imgNewPaper.sd_setImage(with: URL(string: selectedImageName), placeholderImage: UIImage(named: "gs_default"))
                }
            }
        }
    }
}
