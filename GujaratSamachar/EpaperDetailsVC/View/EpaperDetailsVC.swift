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
    var arrEpaperDetails : [EpaperImage] = [EpaperImage]()
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
    
    // MARK: - Viewcontroller life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerNibs()
        makeAPIRequestToGetEpaperDetails(selectedDate: strSelectedDate, selectedEpaperID: strSelectedEpaperID)
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
        return arrEpaperDetails.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EpaperDetailsCollectionViewCell", for: indexPath) as? EpaperDetailsCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.layer.cornerRadius = 10
        cell.layer.borderWidth = 0.0
        cell.layer.borderColor = UIColor.clear.cgColor
        cell.lblPageNumbers.text = "Page \(arrEpaperDetails[indexPath.row].pageNumber)"
        
        let strImgUrl = arrEpaperDetails[indexPath.row].imageNameThumbnail
        cell.imgPaper.sd_setImage(with: URL(string: strImgUrl), placeholderImage: UIImage(named: "gs_default"))
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
        let selectedImageName = arrEpaperDetails[indexPath.row].imageName
        imgNewPaper.sd_setImage(with: URL(string: selectedImageName), placeholderImage: UIImage(named: "gs_default"))
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
                
                let selectedImageName = arrEpaperDetails[nextIndexPath.row].imageName
                imgNewPaper.sd_setImage(with: URL(string: selectedImageName), placeholderImage: UIImage(named: "gs_default"))
            }
        }
    }
}

extension EpaperDetailsVC {
    // MARK: - API Call
    func makeAPIRequestToGetEpaperDetails(selectedDate: String, selectedEpaperID: String) {
        guard let url = URL(string: APICall.gEpaperDetails) else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        // Create the parameter string in Form-Data format
        let parameters = "selected_date=\(selectedDate)&epaper_id=\(selectedEpaperID)"
        let formData = parameters.data(using: .utf8)
        
        // Set the content-type header for Form-Data
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        request.httpBody = formData
        
        let session = URLSession.shared
        let task = session.dataTask(with: request) { [self] (data, response, error) in
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
                    let epaperDetails = try JSONDecoder().decode(EpaperDetailsModel.self, from: data)
                    arrEpaperDetails = epaperDetails.data.epaperImages
                    if let firstImageName = arrEpaperDetails.first?.imageName {
                        imgNewPaper.sd_setImage(with: URL(string: firstImageName), placeholderImage: UIImage(named: "gs_default"))
                    }
                    DispatchQueue.main.async { [self] in
                        collViewPaperDetail.reloadData()
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
