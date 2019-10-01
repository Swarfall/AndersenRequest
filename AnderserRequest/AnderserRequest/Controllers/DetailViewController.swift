//
//  DetailViewController.swift
//  AnderserRequest
//
//  Created by admin on 30.09.2019.
//  Copyright © 2019 Viacheslav Savitsky. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var loadingProgressView: UIProgressView!
    
    var user = UserModel()
    
     override func viewDidLoad() {
        super.viewDidLoad()
    
        avatarImageView.downloaded(from: "http://www.rosphoto.com/images/u/articles/1604/3_19.jpg")
    }
        
    @IBAction func didTapCancelLoadingButton(_ sender: Any) {
        avatarImageView.cancel(from: "http://www.rosphoto.com/images/u/articles/1604/3_19.jpg")
    }
    
    @IBAction func didTapPushPopVCButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
