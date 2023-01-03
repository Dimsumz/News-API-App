//
//  newsViewCell.swift
//  newsApp
//
//  Created by Jonathan Ouyang on 1/1/23.
//

import Foundation
import UIKit

class newsViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var contentLabel: UILabel!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10))
    }
    
}
