//
//  VideoStoriesCell.swift
//  GujaratSamachar
//
//  Created by Nand Parikh on 23/06/23.
//

import UIKit

class VideoStoriesCell: UICollectionViewCell {
    @IBOutlet weak var imgVideoThumb: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    var tblHeight : CGFloat = 0

    override func awakeFromNib() {
        super.awakeFromNib()
        imgVideoThumb.setRadiusToView(cornerRadius: 20)
        imgVideoThumb.setBorderToView(borderColor: UIColor.clear, borderWidth: 10)
        imgVideoThumb.contentMode = .scaleAspectFill
    }
    
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
