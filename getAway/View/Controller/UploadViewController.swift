//
//  UploadViewController.swift
//  getAway
//
//  Created by 조성빈 on 2022/08/19.
//

import UIKit
import Photos

class UploadViewController: UIViewController {
    
    @IBOutlet weak var selectedImageView: UIImageView!
    @IBOutlet weak var albumCollectionView: UICollectionView!
    
    private let uploadViewModel = UploadViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        setDelegate()
        initLayout()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setPermissions()
    }
    
    func setDelegate() {
        albumCollectionView.dataSource = self
        albumCollectionView.delegate = self
    }
    
    func configure() {
        let cell = UINib(nibName: "UploadCollectionViewCell", bundle: nil) // nibName에 파일명 그대로 들어가야함
        albumCollectionView.register(cell, forCellWithReuseIdentifier: UploadCollectionViewCell.identifier)
    }
    
    func initLayout() {
        let layout = UICollectionViewFlowLayout()
        let width = UIScreen.main.bounds.width / 4
        let height = width
        layout.itemSize = CGSize(width: width, height: height) //아이템 사이즈 초기화
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        albumCollectionView.collectionViewLayout = layout //CollctionView의 Layout 적용
    }
}

extension UploadViewController {
    func setPermissions() {
        let photoAuthorizationStatus = PHPhotoLibrary.authorizationStatus()
        
        switch photoAuthorizationStatus {
        case .authorized:
            print("허가됨")
            uploadViewModel.getAlbum()
            DispatchQueue.main.async { [weak self] in
                self?.albumCollectionView.reloadData()
            }
        case .denied:
            print("접근 불허됨")
            settingAlert()
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization { [weak self] status in
                switch status {
                case .authorized:
                    print("허가함")
                    self?.uploadViewModel.getAlbum()
                    DispatchQueue.main.async {
                        self?.albumCollectionView.reloadData()
                    }
                case .denied:
                    print("불허함")
                default:
                    break
                }
            }
        case .restricted:
            print("접근 제한됨")
        default:
            break
        }
    }
    
    func settingAlert() {
        let message = "'나는 떠나고 싶다'이(가) Album 접근이 허용되어 있지않습니다. \r\n 설정화면으로 가시겠습니까?"
        let alert = UIAlertController(title: "설정", message: message, preferredStyle: .alert)
        let cancle = UIAlertAction(title: "취소", style: .default)
        
        let confirm = UIAlertAction(title: "확인", style: .default) { action in
            UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
        }
        
        alert.addAction(cancle)
        alert.addAction(confirm)
        
        self.present(alert, animated: true)
    }
}

extension UploadViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // 앨범에 있는 사진 개수
        return uploadViewModel.allAlbums?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UploadCollectionViewCell.identifier, for: indexPath) as? UploadCollectionViewCell else {return UICollectionViewCell() }
        cell.layer.borderWidth = 1
        guard let asset = uploadViewModel.allAlbums?.object(at: indexPath.item) else {return UICollectionViewCell()}
        
        uploadViewModel.imageManager.requestImage(for: asset, targetSize: CGSize(width: cell.bounds.width, height: cell.bounds.height), contentMode: .aspectFill, options: nil) { image, _ in
            cell.albumImageView.image = image
        }
        return cell
    }
}

extension UploadViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.item)
        
        guard let asset = uploadViewModel.allAlbums?.object(at: indexPath.item) else {return}
        
        uploadViewModel.imageManager.requestImage(for: asset, targetSize: CGSize(width: selectedImageView.bounds.width, height: selectedImageView.bounds.height), contentMode: .aspectFit, options: nil) { image, _ in
            self.selectedImageView.image = image
        }
    }
}
