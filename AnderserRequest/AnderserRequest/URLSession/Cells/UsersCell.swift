//
//  UsersCell.swift
//  AnderserRequest
//
//  Created by admin on 30.09.2019.
//  Copyright © 2019 Viacheslav Savitsky. All rights reserved.
//

import UIKit
import Kingfisher

class UsersCell: UITableViewCell {

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var surnameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func update(user: UserModel) {
        let imageURL = URL(string: user.thumbnailImage ?? "")
        avatarImageView.kf.indicatorType = .activity
        avatarImageView.kf.setImage(with: imageURL)
        
        nameLabel.text = user.name
        surnameLabel.text = user.surname
        emailLabel.text = user.email
        countryLabel.text = user.country
        cityLabel.text = user.city
    }
}
