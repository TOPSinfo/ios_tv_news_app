//
//  VideoStoriesCell.swift
//  GujaratSamachar
//
//  Created by Nand Parikh on 23/06/23.
//

import UIKit

class VideoStoriesCell: UICollectionViewCell {
    // MARK: - IBOutlets
    @IBOutlet weak var imgVideoThumb: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    
    // MARK: - Global Variable
    var tblHeight : CGFloat = 0

    override func awakeFromNib() {
        super.awakeFromNib()
        imgVideoThumb.setRadiusToView(cornerRadius: 20)
        imgVideoThumb.setBorderToView(borderColor: UIColor.clear, borderWidth: 10)
        imgVideoThumb.contentMode = .scaleAspectFill
    }
    
    // MARK: - Configure Cell
    func configureCell(title : String, objData: Datum, tblHeight : CGFloat){
        lblTitle.text = objData.title
        
        let strImgUrl : String = objData.videoThumb ?? ""
        let imgURL = String(format: "%@%@",APPCONST.videoImageBaseURL,strImgUrl)
        print("img url is \(imgURL)")
        imgVideoThumb.sd_setImage(with: URL(string:  imgURL), placeholderImage: UIImage(named: "gs_default"))
        imgVideoThumb.contentMode = .scaleAspectFill
        self.tblHeight = tblHeight
    }
    
    // MARK: - Did Update Focus
    override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        coordinator.addCoordinatedAnimations({ [weak self] in
            if self?.isFocused ?? false{
                self?.imgVideoThumb.transform = CGAffineTransform(scaleX: 1.01, y: 1.01)
                self?.imgVideoThumb.layer.borderColor = UIColor.white.cgColor
            } else {
                self?.imgVideoThumb.transform = CGAffineTransform(scaleX: 1, y: 1)
                self?.imgVideoThumb.layer.borderColor = UIColor.clear.cgColor
            }
        }, completion: nil)
    }
}
