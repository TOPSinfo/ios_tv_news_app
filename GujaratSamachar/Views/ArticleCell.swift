//
//  ArticleCell.swift
//  GujaratSamachar
//
//  Created by Nand Parikh on 22/06/23.
//

import UIKit

class ArticleCell: UICollectionViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet weak var imgStory: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    
    // MARK: - Global Variable
    var type: CellType = .topSubStories

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
    func configureCell(title : String, imageURL: String, type : CellType) {
        lblTitle.text = title
        self.type = type
        
        let imgURL = String(format: "%@%@",APPCONST.imageBaseURL,imageURL)
        //print("Top Story - imgUrl is \(imgURL)")
        imgStory.sd_setImage(with: URL(string:  imgURL), placeholderImage: UIImage(named: "gs_default"))
        imgStory.contentMode = .scaleAspectFill
    }
}
