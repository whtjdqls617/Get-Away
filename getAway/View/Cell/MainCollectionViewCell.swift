//
//  MainCollectionViewCell.swift
//  getAway
//
//  Created by 조성빈 on 2022/08/11.
//

import UIKit

class MainCollectionViewCell: UICollectionViewCell {
    
    static let identifier: String = "mainCollectionViewCell"
        
    @IBOutlet weak var postImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        initCell()
    }
    
    func initCell() {
        postImageView.layer.cornerRadius = 15
        postImageView.layer.masksToBounds = true
        postImageView.isUserInteractionEnabled = true
    }
}
