//
//  MainViewModel.swift
//  getAway
//
//  Created by 조성빈 on 2022/08/11.
//

import UIKit

class MainViewModel {
    
    @Published var postList : [Post]?
    
    private var pageNumber = 1
    private var perPage = 15
    private let postManager = PostManager()
    
    func getDataFromServer() {
        postManager.getData(perPage, pageNumber) { [weak self] postList in
//            self?.imageCaching(photoList)
            if self?.postList == nil {
                self?.postList = postList
            } else {
                self?.postList?.append(contentsOf: postList)
            }
        }
        pageNumber += 1
    }
    
    func makeImage(_ url : String) -> UIImage? {
            guard let imageUrl = URL(string: url) else {return nil}
            guard let imageData = try? Data(contentsOf: imageUrl) else {return nil}
            guard let image = UIImage(data: imageData) else {return nil}
            return image
    }
}
