//
//  ViewController.swift
//  Reddit
//
//  Created by Blue Parrot Software Mac 01 on 4/23/21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBAction func okButton(_ sender: UIButton) {
        animationOut(desiredView: popupView)
        animationOut(desiredView: blurView)
    }
    @IBOutlet var blurView: UIVisualEffectView!
    @IBOutlet var popupView: UIView!
    @IBOutlet weak var selftextLabel: UILabel!
    
    
    
    
    var feed1 = Feed([""], [""], [""], [""])

    var feedManager = FeedManager()
    
    var selectedItem = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        feedManager.delegate = self
        feedManager.fetchFeed()

        tableView.dataSource = self
        
        tableView.register(UINib(nibName: "FeedCell", bundle: nil), forCellReuseIdentifier: "ReusableCell")
        
        blurView.bounds = self.view.bounds
        
        popupView.bounds = CGRect(x: 0, y:0, width: self.view.bounds.width * 0.9, height: self.view.bounds.height * 0.70)
        
        
    }
    
    func animateIn(desiredView: UIView) {
        
        let backgroundView = self.view!
        
        backgroundView.addSubview(desiredView)
        
        desiredView.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        desiredView.alpha = 0
        desiredView.center = backgroundView.center
        
        UIView.animate(withDuration: 0.3) {
            desiredView.transform = CGAffineTransform(scaleX: 1, y: 1)
            desiredView.alpha = 1
        }
    }
    
    func animationOut(desiredView: UIView) {
        UIView.animate(withDuration: 0.3, animations: {
            desiredView.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            desiredView.alpha = 0
        }, completion: { _ in
            desiredView.removeFromSuperview()
        })
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
        
        cell.cellDelegate = self
        cell.index = indexPath
        
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
            
            self.feed1 = Feed(feed.title,feed.author, feed.num_comments, feed.selftext)
            self.tableView.reloadData()
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}

extension ViewController: TableViewNew {
    func onClickCell(index: Int) {
        
        
        self.selftextLabel.text = feed1.selftext[index]
        animateIn(desiredView: blurView)
        animateIn(desiredView: popupView)
    }
    
    
}
