//
//  EpaperDetailsCollectionViewCell.swift
//  GujaratSamachar
//
//  Created by iMac on 04/07/23.
//

import UIKit

class EpaperDetailsCollectionViewCell: UICollectionViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet weak var imgPaper: UIImageView!
    @IBOutlet weak var lblPageNumbers: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: - Did Update Focus
    override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        coordinator.addCoordinatedAnimations({ [weak self] in
            if self?.isFocused ?? false{
                self?.imgPaper.transform = CGAffineTransform(scaleX: 1.01, y: 1.01)
                self?.imgPaper.layer.borderColor = UIColor.white.cgColor
            } else {
                self?.imgPaper.transform = CGAffineTransform(scaleX: 1, y: 1)
                self?.imgPaper.layer.borderColor = UIColor.clear.cgColor
            }
        }, completion: nil)
    }
}
