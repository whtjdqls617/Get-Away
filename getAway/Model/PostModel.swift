//
//  PostModel.swift
//  getAway
//
//  Created by 조성빈 on 2022/08/11.
//

import Foundation

struct Post : Decodable {
    let id : String
    let width : Int
    let height : Int
    let urls : Urls
}

struct Urls : Decodable {
    let raw : String
    let small : String
}
