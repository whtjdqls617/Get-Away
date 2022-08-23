//
//  MyPageViewController.swift
//  getAway
//
//  Created by 조성빈 on 2022/08/22.
//

import UIKit

class MyPageViewController: UIViewController {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var myPageCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initView()
        setDelegate()
        configure()
        initLayout()
        // firebase로 부터 내 정보 (프로필사진, 닉네임, 자기소개 받아오기)
        // firebase로 부터 내 게시물들 가져오기
    }
    
    func initView() {
        self.navigationController?.navigationBar.topItem?.title = "이름"
        profileImageView.image = UIImage(systemName: "person")
        profileImageView.layer.borderWidth = 1
        profileImageView.layer.cornerRadius = profileImageView.frame.height/2
        profileImageView.layer.masksToBounds = true
    }
    
    func setDelegate() {
        myPageCollectionView.dataSource = self
        myPageCollectionView.delegate = self
    }
    
    func configure() {
        let cell = UINib(nibName: "MyPageCollectionViewCell", bundle: nil) // nibName에 파일명 그대로 들어가야함
        myPageCollectionView.register(cell, forCellWithReuseIdentifier: MyPageCollectionViewCell.identifier)
        let layout = myPageCollectionView.collectionViewLayout as? CustomLayout
        layout?.delegate = self
    }
    
    func initLayout() {
        let layout = UICollectionViewFlowLayout()
        let width = UIScreen.main.bounds.width / 4
        let height = width
        layout.itemSize = CGSize(width: width, height: height) //아이템 사이즈 초기화
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        myPageCollectionView.collectionViewLayout = layout //CollctionView의 Layout 적용
    }
}

extension MyPageViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyPageCollectionViewCell.identifier, for: indexPath) as? MyPageCollectionViewCell else {return UICollectionViewCell() }
        cell.layer.borderWidth = 1
        
        // cell에 받아온 post들 이미지 넣기
        return cell
    }
    
}

extension MyPageViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.item)
    }
}

extension MyPageViewController: CustomLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, heightForImageAtIndexPath indexPath: IndexPath) -> CGFloat {
//        return CGFloat(postList?[indexPath.item].height ?? 0)
        return 100
    }
    
    func collectionView(_ collectionView: UICollectionView, widthForImageAtIndexPath indexPath: IndexPath) -> CGFloat {
//        return CGFloat(postList?[indexPath.item].width ?? 0)
        return 100
    }
}
