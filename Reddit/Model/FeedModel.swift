//
//  FeedModel.swift
//  Reddit
//
//  Created by Blue Parrot Software Mac 01 on 4/23/21.
//

import Foundation

struct FeedModel{
    var author = [String]()
    var title = [String]()
    var num_comments = [String]()
    var selftext = [String]()
    
    init(author: [String], title: [String], num_comments: [String], selftext: [String]) {
        self.author = author
        self.title = title
        self.num_comments = num_comments
        self.selftext = selftext
    }
}
