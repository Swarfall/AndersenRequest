//
//  DetailViewController.swift
//  AnderserRequest
//
//  Created by admin on 30.09.2019.
//  Copyright © 2019 Viacheslav Savitsky. All rights reserved.
//

import UIKit
import Kingfisher

class DetailViewController: UIViewController {

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var loadingProgressView: UIProgressView!
    
    var requestParametrModel = RequestParametrModel()
    var user = UserModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        showImage(image: user.largeImage ?? "")
    }

    private func showImage(image: String) {
        let imageURL = URL(string: image)
        self.avatarImageView.kf.indicatorType = .activity
        self.avatarImageView.kf.setImage(with: imageURL)
    }
        
    @IBAction func didTapCancelLoadingButton(_ sender: Any) {
        
    }
    
    @IBAction func didTapPushPopVCButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

