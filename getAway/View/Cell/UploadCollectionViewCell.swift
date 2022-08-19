//
//  UploadCollectionViewCell.swift
//  getAway
//
//  Created by 조성빈 on 2022/08/19.
//

import UIKit

class UploadCollectionViewCell: UICollectionViewCell {
    
    static let identifier: String = "uploadCollectionViewCell"
    
    @IBOutlet weak var albumImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        initCell()
    }

    func initCell() {

//        albumImageView.bounds.width = self.bounds.width
//        albumImageView.bounds.height = self.bounds.height
    }
}
