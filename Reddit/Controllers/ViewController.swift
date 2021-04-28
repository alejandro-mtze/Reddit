//
//  ViewController.swift
//  Reddit
//
//  Created by Blue Parrot Software Mac 01 on 4/23/21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    
    var feed1 = Feed([""], [""], [""])

    var feedManager = FeedManager()

    override func viewDidLoad() {
        feedManager.delegate = self
        feedManager.fetchFeed()
        
        super.viewDidLoad()

        tableView.dataSource = self
        
        tableView.register(UINib(nibName: "FeedCell", bundle: nil), forCellReuseIdentifier: "ReusableCell")
        
    }

}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feed1.author.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReusableCell", for: indexPath) as! FeedCell
        
        //cell.authorLabel.text = prueba[0].data.author
        cell.authorLabel.text = feed1.author[indexPath.row]
        cell.numberLabel.text = feed1.nu_comments[indexPath.row]
        cell.titleLabel.text = feed1.title[indexPath.row]
        
        return cell
    }
    
    private func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print(indexPath.row)
    }
}

extension ViewController: FeedManagerDelegate {
    
    func didUpdateFeed(_ feedManager: FeedManager, feed: FeedModel){
        DispatchQueue.main.async {
            print(feed.author[0])
            
            self.feed1 = Feed(feed.title,feed.author, feed.num_comments)
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}
