//
//  GCDCell.swift
//  AnderserRequest
//
//  Created by admin on 03.10.2019.
//  Copyright © 2019 Viacheslav Savitsky. All rights reserved.
//

import UIKit
import Kingfisher

class GCDCell: UITableViewCell {

    @IBOutlet weak var avatarImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func update(image: ImageModel) {
        let imageURL = URL(string: image.thumbnail ?? "")
        avatarImageView.kf.indicatorType = .activity
        avatarImageView.kf.setImage(with: imageURL)
    }
    
}
