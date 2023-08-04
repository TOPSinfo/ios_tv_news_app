//
//  ShowMoreNewsCell.swift
//  GujaratSamachar
//
//  Created by Nand Parikh on 23/06/23.
//

import UIKit

class ShowMoreNewsCell: UICollectionViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet weak var imgStory: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!

    // MARK: - Global Variable
    var arrData : [Any] = [Any]()
    var type: CellType = .topStories


    override func awakeFromNib() {
        super.awakeFromNib()
        imgStory.setRadiusToView(cornerRadius: 20)
        imgStory.setBorderToView(borderColor: UIColor.clear, borderWidth: 10)
        imgStory.contentMode = .scaleAspectFill
    }
    
    // MARK: - Did Update Focus
    override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        coordinator.addCoordinatedAnimations({ [weak self] in
            if self?.isFocused ?? false{
                self?.imgStory.transform = CGAffineTransform(scaleX: 1.01, y: 1.01)
                self?.imgStory.layer.borderColor = UIColor.white.cgColor
            } else {
                self?.imgStory.transform = CGAffineTransform(scaleX: 1, y: 1)
                self?.imgStory.layer.borderColor = UIColor.clear.cgColor
            }
        }, completion: nil)
    }
   
    // MARK: - Configure Cell
    func configureCell<T>(title : String, modelArray: [T], imageURL: String, type : CellType) {
        lblTitle.text = title
        self.type = type
        self.arrData = modelArray
        
        let imgURL = String(format: "%@%@",APPCONST.imageBaseURL,imageURL)
        //print("Top Story - imgUrl is \(imgURL)")
        imgStory.sd_setImage(with: URL(string:  imgURL), placeholderImage: UIImage(named: "gs_default"))
        imgStory.contentMode = .scaleAspectFill
    }
}
