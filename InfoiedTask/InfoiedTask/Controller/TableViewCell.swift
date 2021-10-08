//
//  TableViewCell.swift
//  InfoiedTask
//
//  Created by VENKSTESHKSTL on 07/10/21.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet var emailLbl: UILabel!
    @IBOutlet var firstlastNameLbl: UILabel!
    @IBOutlet var img: LazyLoadingImages!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.img.layer.cornerRadius = 5
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
