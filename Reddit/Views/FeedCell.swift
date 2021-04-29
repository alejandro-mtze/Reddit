//
//  FeedCell.swift
//  Reddit
//
//  Created by Blue Parrot Software Mac 01 on 4/26/21.
//

import UIKit

protocol TableViewNew {
    func onClickCell(index: Int)
}

class FeedCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    
    var cellDelegate: TableViewNew?
    var index: IndexPath?
    
    @IBAction func buttonCell(_ sender: UIButton) {
        cellDelegate?.onClickCell(index: index!.row)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
