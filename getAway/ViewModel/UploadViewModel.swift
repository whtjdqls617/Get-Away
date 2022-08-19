//
//  UploadViewModel.swift
//  getAway
//
//  Created by 조성빈 on 2022/08/19.
//

import Foundation
import Photos
import UIKit

class UploadViewModel {
    
    var allAlbums : PHFetchResult<PHAsset>?
    let imageManager = PHCachingImageManager()
    
}

extension UploadViewModel {
    func getAlbum() {
        let cameraRoll : PHFetchResult<PHAssetCollection> = PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .smartAlbumUserLibrary, options: nil)
        guard let cameraRollCollection = cameraRoll.firstObject else {return}
        let fetchOptions = PHFetchOptions()
        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        self.allAlbums = PHAsset.fetchAssets(in: cameraRollCollection, options: fetchOptions)
    }
}
