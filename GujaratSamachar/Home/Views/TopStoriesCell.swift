//
//  TopStoriesCell.swift
//  GujaratSamachar
//
//  Created by Nand Parikh on 22/06/23.
//

import UIKit

class TopStoriesCell: UICollectionViewCell {
    
    @IBOutlet weak var imgStory: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    var type: CellType = .topStories

    override func awakeFromNib() {
        super.awakeFromNib()
        imgStory.setRadiusToView(cornerRadius: 20)
        imgStory.setBorderToView(borderColor: UIColor.clear, borderWidth: 10)
        imgStory.contentMode = .scaleAspectFill
    }
    
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
    
}
