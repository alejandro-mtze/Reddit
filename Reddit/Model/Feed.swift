//
//  Feed.swift
//  Reddit
//
//  Created by Blue Parrot Software Mac 01 on 4/26/21.
//

import Foundation

struct Feed {
    var title = [String]()
    var author = [String]()
    var nu_comments = [String]()
    
    init(_ title: [String], _ author: [String], _ nu_comments: [String]) {
        self.title = title
        self.author = author
        self.nu_comments = nu_comments
    }
}
