//
//  PostManager.swift
//  getAway
//
//  Created by 조성빈 on 2022/08/11.
//

import UIKit
import Alamofire

struct PostManager {
    
    let base = "https://api.unsplash.com"
    
    private let apiKey = "bLLN-gZPMVL302TW5Hbh6KWXJjogg-8C2i75EFqNNiA"
    
    func getData(_ perPage : Int, _ pageNumber : Int, completion : @escaping ([Post]) -> Void) {
        let api = makeApi(base, apiKey)
        if let url = URL(string: fetchURL(perPage, pageNumber, api)) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if let error = error {
                    print(error)
                    return
                }
                let successRange = 200..<300
                guard let statusCode = (response as? HTTPURLResponse)?.statusCode else {return}
                if successRange.contains(statusCode) {
                    if let safeData = data {
                        guard let result = self.parseJSON(safeData) else {return}
                        completion(result)
                    }
                }
            }
            task.resume()
        }
    }
    
    func getData2(_ perPage : Int, _ pageNumber : Int, completion : @escaping ([Post]) -> Void) {
        let api = makeApi(base, apiKey)
        let url = fetchURL(perPage, pageNumber, api)
        let request = AF.request(url, method: .get).validate(statusCode: 200..<300)
        request.responseData { dataResponse in
            switch dataResponse.result {
            case .success:
                guard let value = dataResponse.value else {return}
                guard let result = self.parseJSON(value) else {return}
                completion(result)
            case .failure:
                print("error")
            }
        }
    }
    
    func parseJSON(_ data : Data) -> [Post]? {
        let decorder = JSONDecoder()
        do {
            let decodeData = try decorder.decode([Post].self, from: data)
            return decodeData
        } catch {
            return nil
        }
    }
    
    func makeApi(_ base : String, _ apiKey : String) -> String {
        return "\(base)/photos/?client_id=\(apiKey)"
    }
    
    func fetchURL(_ perPage : Int, _ pageNumber : Int, _ api : String) -> String {
        let urlString = api + "&page=\(pageNumber)&per_page=\(perPage)"
        return urlString
    }
}
