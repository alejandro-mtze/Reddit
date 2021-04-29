//
//  FeedManager.swift
//  Reddit
//
//  Created by Blue Parrot Software Mac 01 on 4/23/21.
//

import Foundation

protocol FeedManagerDelegate {
    func didUpdateFeed(_ feedManager: FeedManager, feed: FeedModel)
    func didFailWithError(error: Error)
}

struct FeedManager {
    let feedURL = "https://www.reddit.com/r/androiddev.json"
    
    var delegate: FeedManagerDelegate?
    
    func fetchFeed(){
        performRequest(with: feedURL)
    }
    
    
    func performRequest(with urlString: String) {
        
        if let url = (URL(string: urlString)){
            
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                
                if let safeData = data {
                    if let feed = self.parseJason(safeData){
                        self.delegate?.didUpdateFeed(self, feed: feed)
                    }
                }
            }
            
            task.resume()
        }
        
    }
    
    func parseJason(_ feedData: Data) -> FeedModel?{
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(FeedData.self, from: feedData)
            
            
            let data = decodedData.data.children

            var author = [String]()
            var title = [String]()
            var num_comments = [String]()
            var selftext = [String]()
            
            for value in data {
                author.append("Author: "+value.data.author)
                title.append(value.data.title)
                num_comments.append("\(value.data.num_comments)")
                selftext.append(value.data.selftext)
            }
            
            let feed = FeedModel(author: author, title: title, num_comments: num_comments, selftext: selftext)
            return feed
            
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}
