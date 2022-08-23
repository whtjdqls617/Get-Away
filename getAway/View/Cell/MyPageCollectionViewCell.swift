//
//  MyPageCollectionViewCell.swift
//  getAway
//
//  Created by 조성빈 on 2022/08/23.
//

import UIKit

class MyPageCollectionViewCell: UICollectionViewCell {
    
    static let identifier: String = "myPageCollectionViewCell"

    @IBOutlet weak var postImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
