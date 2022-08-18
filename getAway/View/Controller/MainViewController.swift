//
//  MainViewController.swift
//  getAway
//
//  Created by 조성빈 on 2022/08/11.
//

import UIKit
import Combine
import Kingfisher

class MainViewController: UIViewController {

    @IBOutlet weak var mainCollectionView: UICollectionView!
    
    private let mainViewModel = MainViewModel()
    
    private var postList : [Post]?
    private var disposalbleBag = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initView()
        setDelegate()
        configure()
        setBinding()
    }

    func initView() {
        self.navigationController?.navigationBar.topItem?.title = "나는 떠나고 싶다"
        mainViewModel.getDataFromServer()
    }
    
    func setDelegate() {
        mainCollectionView.dataSource = self
        mainCollectionView.delegate = self
    }
    
    func configure() {
        let cell = UINib(nibName: "MainCollectionViewCell", bundle: nil) // nibName에 파일명 그대로 들어가야함
        mainCollectionView.register(cell, forCellWithReuseIdentifier: MainCollectionViewCell.identifier)
        let layout = mainCollectionView.collectionViewLayout as? CustomLayout
        layout?.delegate = self
    }

}

extension MainViewController {
    private func setBinding() {
        self.mainViewModel.$postList.sink {[weak self] updatedPostList in
            self?.postList = updatedPostList
            DispatchQueue.main.async {
                self?.mainCollectionView.reloadData()
            }
        }.store(in: &disposalbleBag)
    }
}

extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return postList?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainCollectionViewCell.identifier, for: indexPath) as? MainCollectionViewCell else { return UICollectionViewCell() }
//        cell.postImageView.image = mainViewModel.makeImage(postList?[indexPath.item].urls.small ?? "")
        cell.postImageView.kf.setImage(with: URL(string:  postList?[indexPath.item].urls.small ?? ""))
        return cell
    }
}

extension MainViewController: UICollectionViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
            beginBatchFetch()
    }
    
    private func beginBatchFetch() {
        DispatchQueue.main.async {
            self.mainViewModel.getDataFromServer()
        }
    }
}

extension MainViewController: CustomLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, heightForImageAtIndexPath indexPath: IndexPath) -> CGFloat {
        return CGFloat(postList?[indexPath.item].height ?? 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, widthForImageAtIndexPath indexPath: IndexPath) -> CGFloat {
        return CGFloat(postList?[indexPath.item].width ?? 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.item)
    }
}

extension MainViewController: PressImageViewDelegate {
    func pressImageView(_ cell: MainCollectionViewCell) {
        print("hi")
    }
}
