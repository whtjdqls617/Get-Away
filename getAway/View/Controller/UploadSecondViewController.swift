//
//  UploadSecondViewController.swift
//  getAway
//
//  Created by 조성빈 on 2022/08/20.
//

import UIKit

class UploadSecondViewController: UIViewController {
    
    static let identifier: String = "uploadSecondViewController"
    
    @IBOutlet weak var uploadImageView: UIImageView!
    
    var receivedImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        uploadImageView.image = receivedImage
    }
    
//    override func viewDidDisappear(_ animated: Bool) {
//        super.viewDidDisappear(animated)
//        navigationController?.popViewController(animated: true)
//    }
    
    @IBAction func pressUpload(_ sender: UIBarButtonItem) {
        self.navigationController?.popToRootViewController(animated: true)
        // Todo : tabbar main으로 이동 시키고싶음
    }
}
