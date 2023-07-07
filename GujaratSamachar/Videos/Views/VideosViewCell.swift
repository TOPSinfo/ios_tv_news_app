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

//    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var cnstVideosiewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var clvVideos: UICollectionView!

    weak var delegate: VideoTableViewCellDelegate?
    var arrVideoLists : [Datum] = [Datum]()
    var tblHeight : CGFloat = 0
    
    let minLineSpacing : CGFloat = 30
    let minInterSpacing : CGFloat = 30

    
    override func awakeFromNib() {
        super.awakeFromNib()
        clvVideos.delegate = self
        clvVideos.dataSource = self
        registerNibs()
    }
    
    func registerNibs(){
        clvVideos.register(UINib(nibName: "VideoStoriesCell", bundle: nil), forCellWithReuseIdentifier: "VideoStoriesCell")
    }

}

extension VideosViewCell :UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.arrVideoLists.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell: VideoStoriesCell = collectionView.dequeueReusableCell(withReuseIdentifier: "VideoStoriesCell", for: indexPath) as? VideoStoriesCell {
            
            cell.lblTitle.text = self.arrVideoLists[indexPath.row].title

            let strImgUrl : String = self.arrVideoLists[indexPath.row].videoThumb ?? ""
            let imgURL = String(format: "%@%@",APPCONST.videoImageBaseURL,strImgUrl)
            print("img url is \(imgURL)")

            cell.imgVideoThumb.sd_setImage(with: URL(string:  imgURL), placeholderImage: UIImage(named: "gs_default"))
            cell.imgVideoThumb.contentMode = .scaleAspectFill
            
            cell.tblHeight = self.tblHeight
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
        let strVideoURL : String = String(format: "%@%@", APPCONST.videoBaseURL,self.arrVideoLists[indexPath.row].videoUrl ?? "")

        print("selected video url \(strVideoURL)")

        delegate?.didSelectItem(videoURL: strVideoURL, index: indexPath.row)

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return minLineSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return minInterSpacing
    }
}

