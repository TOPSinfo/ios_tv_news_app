//
//  NewsViewCell.swift
//  GujaratSamachar
//
//  Created by Nand Parikh on 22/06/23.
//

import UIKit

protocol VideoTableViewCellDelegate: AnyObject {
    func didSelectItem(videoURL : String, index : Int)
}

class VideosViewCell: UITableViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet weak var cnstVideosiewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var clvVideos: UICollectionView!
    
    // MARK: - Global Variable
    weak var delegate: VideoTableViewCellDelegate?
    var arrVideoLists : [Any] = [Any]()
    var tblHeight : CGFloat = 0
    
    let minLineSpacing : CGFloat = 30
    let minInterSpacing : CGFloat = 30
    
    // MARK: - IBOutlets
    override func awakeFromNib() {
        super.awakeFromNib()
        clvVideos.delegate = self
        clvVideos.dataSource = self
        registerNibs()
    }
    
    // MARK: - Register Nibs
    func registerNibs(){
        clvVideos.register(UINib(nibName: "VideoStoriesCell", bundle: nil), forCellWithReuseIdentifier: "VideoStoriesCell")
    }
    
    // MARK: - Configure Cell
    func configureCell<T>(arrVideoLists: [T], clvVideos: UICollectionView, tblHeight : CGFloat, tbl : UITableView, cnstHeight : CGFloat) {
        self.arrVideoLists = arrVideoLists
        self.clvVideos.reloadData()
        self.tblHeight = tblHeight
        self.cnstVideosiewHeightConstraint.constant = cnstHeight
    }
}

// MARK: - Collection Delegate and Datasource Methods
extension VideosViewCell :UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.arrVideoLists.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell: VideoStoriesCell = collectionView.dequeueReusableCell(withReuseIdentifier: "VideoStoriesCell", for: indexPath) as? VideoStoriesCell {
            if let objVideoData : Datum = self.arrVideoLists[indexPath.row] as? Datum {
                cell.configureCell(title: objVideoData.title ?? "", objData: objVideoData, tblHeight: self.tblHeight)
            }
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let widthPerItem = collectionView.frame.width / 3 - minInterSpacing
        return CGSize(width: widthPerItem - 8, height: widthPerItem - 8)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("selected index is \(indexPath.item)")
        
        if let objVideoData : Datum = self.arrVideoLists[indexPath.row] as? Datum {
            let strVideoURL : String = String(format: "%@%@", APPCONST.videoBaseURL,objVideoData.videoUrl ?? "")
            print("selected video url \(strVideoURL)")
            delegate?.didSelectItem(videoURL: strVideoURL, index: indexPath.row)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return minLineSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return minInterSpacing
    }
}
