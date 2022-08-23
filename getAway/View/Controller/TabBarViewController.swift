//
//  TabBarViewController.swift
//  getAway
//
//  Created by 조성빈 on 2022/08/23.
//

import UIKit

class TabBarViewController: UITabBarController {

    var index = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        self.delegate = self
    }
    
}

//extension TabBarViewController: UITabBarControllerDelegate {
//    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
//        if item.image == UIImage(systemName: "plus.app") {
////            guard let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "UploadViewController") else {return}
////            navigationController?.pushViewController(nextVC, animated: true)
//            print("1")
//        }
//    }
//}
