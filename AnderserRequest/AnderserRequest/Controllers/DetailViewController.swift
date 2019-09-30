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

        getData()
    }
    
    private func getData() {
        let urlString = "\(requestParametrModel.randomRequestURL)\(requestParametrModel.allResults))"
            guard let url = URL(string: urlString) else { return }
            
            let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
                guard let data = data else { return }
                
                do {
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                        if let result = json["results"] as? [[String: Any]] {
                        if result.count > 0 {
                            
                            for info in result {

                                if let login = info["login"] as? [String: Any] {
                                    if let uuid = login["uuid"] as? String {
                                        if uuid == self.user.uuid {
                                            
                                            if let avatar = info["picture"] as? [String: Any] {
                                                if let image = avatar["large"] as? String {
                                                    self.user.largeImage = image
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                            DispatchQueue.main.async {
                                guard let avatar = self.user.largeImage else { return }
                                self.showImage(image: avatar)
                            }
                        }
                    }
                } catch let error as NSError {
                    debugPrint("Error: \(error.localizedDescription)")
                }
            }
            task.resume()
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

