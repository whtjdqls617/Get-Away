//
//  SearchViewController.swift
//  getAway
//
//  Created by 조성빈 on 2022/08/18.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initView()
    }
    
    func initView() {
        searchBar.placeholder = "검색"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: searchBar)

    }

}
