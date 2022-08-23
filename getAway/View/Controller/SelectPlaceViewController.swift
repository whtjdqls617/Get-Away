//
//  SelectPlaceViewController.swift
//  getAway
//
//  Created by 조성빈 on 2022/08/23.
//

import UIKit

class SelectPlaceViewController: UIViewController {

    @IBOutlet weak var placeSearchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initView()
    }
    
    func initView() {
        placeSearchBar.searchBarStyle = .minimal
    }

}
