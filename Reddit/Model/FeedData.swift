//
//  FeedData.swift
//  Reddit
//
//  Created by Blue Parrot Software Mac 01 on 4/23/21.
//

import Foundation

struct FeedData: Codable {
    let data: Data1
}

struct Data1: Codable {
    let children: [Children]
}

struct Children: Codable {
    let data: Data2
}

struct Data2: Codable {
    let author: String
    let title: String
    let num_comments: Int
    let selftext: String
}
