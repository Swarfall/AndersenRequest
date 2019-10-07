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
        
        getData()
      // avatarImageView.downloaded(from: user.largeImage ?? "")
       // fetchImage(URL(string: user.largeImage ?? ""))
    }
    
    private func getData() {
        let url = URL(string: user.largeImage ?? "")!
        let session = URLSession(configuration: .default)

        let downloadTask = session.downloadTask(with: url) { (data, response, error) in

            if let err = error {
                print("Error downloading person picture: \(err)")
            } else {
                if let res = response as? HTTPURLResponse {
                    print("Downloaded person picture with response code \(res.statusCode)")
                    if let imageData = data {

                        let image = try! Data(contentsOf: imageData)
                        
                        DispatchQueue.main.async {
                            self.avatarImageView.image = UIImage(data: image)
                        }
                    } else {
                        print("Couldn't get image: Image is nil")
                    }
                } else {
                    print("Couldn't get response code for some reason")
                }
            }
        }

        downloadTask.resume()
    }
    
//    private func fetchImage(_ photoURL: URL?) {
//        guard let imageURL = photoURL else { return  }
//
//        DispatchQueue.global(qos: .userInitiated).async {
//            do{
//                let imageData: Data = try Data(contentsOf: imageURL)
//
//                DispatchQueue.main.async {
//                    let image = UIImage(data: imageData)
//                    self.avatarImageView.image = image
//                    self.avatarImageView.sizeToFit()
//                }
//            } catch {
//                    print("Unable to load data: \(error)")
//            }
//        }
//    }
    
//    func downloadImage(from url: URL) {
//        print("Download Started")
//        getData(from: url) { data, response, error in
//            guard let data = data, error == nil else { return }
//            print(response?.suggestedFilename ?? url.lastPathComponent)
//            print("Download Finished")
//            DispatchQueue.main.async() {
//                self.avatarImageView.image = UIImage(data: data)
//            }
//        }
//    }
    
//    private func getData() {
//            Create destination URL
//            let documentsUrl:URL =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first as URL!
//            let destinationFileUrl = documentsUrl.appendingPathComponent("downloadedFile.jpg")
//
//            //Create URL to the source file you want to download
//        let fileURL = URL(string: user.largeImage ?? "")
//
//            let sessionConfig = URLSessionConfiguration.default
//            let session = URLSession(configuration: sessionConfig)
//
//            let request = URLRequest(url:fileURL!)
//
//            let task = session.downloadTask(with: request) { (tempLocalUrl, response, error) in
//                if let tempLocalUrl = tempLocalUrl, error == nil {
//                    // Success
//                    if let statusCode = (response as? HTTPURLResponse)?.statusCode {
//                        print("Successfully downloaded. Status code: \(statusCode)")
//                    }
//
//                    do {
//                        try FileManager.default.copyItem(at: tempLocalUrl, to: destinationFileUrl)
//                        DispatchQueue.main.async {
//                            //avatarImageView.image =
//                        }
//                    } catch (let writeError) {
//                        print("Error creating a file \(destinationFileUrl) : \(writeError)")
//                    }
//
//                } else {
//                    print(error?.localizedDescription)
//                }
//            }
//            task.resume()
//     }
        
//    private func getData() {
//        let urlString = "\(user.largeImage ?? "")"
//        guard let url = URL(string: urlString) else { return }
//        var request = URLRequest(url: url)
//        request.httpMethod = "GET"
//    let task = URLSession.shared.dataTask(with: request) {(data, response, error) in
//            guard let data = data else { return }
//
//            do {
//
//                self.image = data as! Image()
//
//            } catch let error as NSError {
//                debugPrint("Error: \(error.localizedDescription)")
//            }
//        }
//        task.resume()
//    }
    
    @IBAction func didTapCancelLoadingButton(_ sender: Any) {
        //avatarImageView.cancel(from: "http://www.rosphoto.com/images/u/articles/1607/1_23.jpg")
    }
    
    @IBAction func didTapPushPopVCButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
